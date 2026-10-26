"""The content agent's side of the shared GTM database (pavoot-gtm `gtm` schema, tables from db/004_content_links.sql).

    gtm_sync.py links   <draft.md>        store the ```links block of a daily draft in gtm.content_links (drafted)
    gtm_sync.py export  <out.json>        write recent content_links + campaign_results for the learning run
    gtm_sync.py results <results.json>    store the learning run's campaign numbers in gtm.campaign_results and mark
                                          links whose campaign got traffic as posted

The database URL comes from the Keychain item `pavoot-gtm-db` (or GTM_DB_URL) and is never printed. Every write is
one short transaction; the headless Claude runs never touch the database themselves.
"""

from __future__ import annotations

import json
import os
import re
import subprocess
import sys
from datetime import date, timedelta

PLATFORMS = {"linkedin", "x", "reddit", "instagram", "other"}
TARGETS = {"event_page", "pavoot_events", "pavoot_com", "booking", "other"}
CAMPAIGN = re.compile(r"^[a-z0-9][a-z0-9-]{2,80}$")


def db_url() -> str:
    if os.environ.get("GTM_DB_URL"):
        return os.environ["GTM_DB_URL"]
    r = subprocess.run(["security", "find-generic-password", "-s", "pavoot-gtm-db", "-w"],
                       capture_output=True, text=True)
    if r.returncode or not r.stdout.strip():
        raise SystemExit("gtm_sync: no GTM database configured (Keychain item pavoot-gtm-db); skipped")
    return r.stdout.strip()


def connect():
    import psycopg
    from psycopg.rows import dict_row
    return psycopg.connect(db_url(), row_factory=dict_row, autocommit=True, prepare_threshold=None,
                           options="-c search_path=gtm")


def links_block(text: str) -> list[dict]:
    """The last ```links block of a draft, validated; malformed entries are dropped with a note."""
    blocks = re.findall(r"```links\s*\n(.*?)```", text, re.S)
    if not blocks:
        return []
    try:
        items = json.loads(blocks[-1])
    except json.JSONDecodeError as e:
        print(f"gtm_sync: links block is not valid JSON ({e}); nothing stored")
        return []
    out = []
    for it in items if isinstance(items, list) else []:
        if not isinstance(it, dict):
            continue
        dest = str(it.get("destination") or "")
        camp = str(it.get("campaign") or "")
        if (it.get("platform") not in PLATFORMS or it.get("target") not in TARGETS or not CAMPAIGN.match(camp)
                or not dest.startswith("https://") or not it.get("author")):
            print(f"gtm_sync: skipped a malformed link entry: {json.dumps(it)[:200]}")
            continue
        if it["target"] != "other" and f"utm_campaign={camp}" not in dest:
            print(f"gtm_sync: skipped a link whose URL doesn't carry its campaign: {dest[:160]}")
            continue
        out.append({"campaign": camp, "platform": it["platform"], "author": str(it["author"])[:60],
                    "utm_content": (str(it.get("utm_content") or "")[:80] or None), "destination": dest[:1000],
                    "target": it["target"], "test_arm": (str(it.get("test_arm") or "")[:20] or None),
                    "draft_ref": (str(it.get("draft_ref") or "")[:200] or None)})
    return out


def store_links(path: str) -> int:
    items = links_block(open(path, encoding="utf-8").read())
    if not items:
        print("gtm_sync: no links to store")
        return 0
    with connect() as conn, conn.transaction(), conn.cursor() as cur:
        for it in items:
            cur.execute("""insert into gtm.content_links (campaign, platform, author, utm_content, destination, target,
                                                          test_arm, draft_ref)
                           values (%(campaign)s, %(platform)s, %(author)s, %(utm_content)s, %(destination)s,
                                   %(target)s, %(test_arm)s, %(draft_ref)s)
                           on conflict (campaign, platform, author, destination) do nothing""", it)
    print(f"gtm_sync: {len(items)} link(s) recorded (already-known ones are left as they were)")
    return len(items)


def export(path: str) -> None:
    since = date.today() - timedelta(days=56)
    with connect() as conn, conn.cursor() as cur:
        cur.execute("""select campaign, platform, author, utm_content, destination, target, test_arm, draft_ref,
                              post_url, status, drafted_on::text, posted_on::text
                       from gtm.content_links where drafted_on >= %s order by drafted_on desc""", (since,))
        links = cur.fetchall()
        cur.execute("""select week::text, utm_source, utm_campaign, utm_content, event_page_views, registrations,
                              marketplace_visits, marketplace_signups, pledges, meetings
                       from gtm.campaign_results where week >= %s order by week desc, utm_campaign""", (since,))
        results = cur.fetchall()
    with open(path, "w", encoding="utf-8") as f:
        json.dump({"content_links": links, "campaign_results": results}, f, indent=1, default=str)
    print(f"gtm_sync: exported {len(links)} links, {len(results)} result rows")


NUMS = ("event_page_views", "registrations", "marketplace_visits", "marketplace_signups", "pledges", "meetings")


def store_results(path: str) -> None:
    data = json.load(open(path, encoding="utf-8"))
    rows = data.get("campaign_results") if isinstance(data, dict) else data
    week = date.today() - timedelta(days=date.today().weekday())
    ok = []
    for r in rows or []:
        if not isinstance(r, dict) or not r.get("utm_source") or not r.get("utm_campaign"):
            continue
        row = {"week": week, "utm_source": str(r["utm_source"])[:60], "utm_campaign": str(r["utm_campaign"])[:120],
               "utm_content": str(r.get("utm_content") or "")[:80]}
        for k in NUMS:
            v = r.get(k)
            row[k] = int(v) if isinstance(v, (int, float)) else None
        ok.append(row)
    if not ok:
        print("gtm_sync: no campaign results to store")
        return
    with connect() as conn, conn.transaction(), conn.cursor() as cur:
        for row in ok:
            cur.execute("""insert into gtm.campaign_results (week, utm_source, utm_campaign, utm_content, event_page_views,
                                registrations, marketplace_visits, marketplace_signups, pledges, meetings)
                           values (%(week)s, %(utm_source)s, %(utm_campaign)s, %(utm_content)s, %(event_page_views)s,
                                   %(registrations)s, %(marketplace_visits)s, %(marketplace_signups)s, %(pledges)s,
                                   %(meetings)s)
                           on conflict (week, utm_source, utm_campaign, utm_content) do update set
                             event_page_views = excluded.event_page_views, registrations = excluded.registrations,
                             marketplace_visits = excluded.marketplace_visits,
                             marketplace_signups = excluded.marketplace_signups, pledges = excluded.pledges,
                             meetings = excluded.meetings, recorded_at = now()""", row)
        # A campaign that got visits was posted: mark its drafted links (additive, never un-marks).
        cur.execute("""update gtm.content_links l set status = 'posted', posted_on = coalesce(l.posted_on, current_date)
                       where l.status = 'drafted' and exists (
                         select 1 from gtm.campaign_results r where r.utm_campaign = l.campaign
                           and coalesce(r.event_page_views, 0) + coalesce(r.marketplace_visits, 0)
                               + coalesce(r.registrations, 0) > 0)""")
    print(f"gtm_sync: {len(ok)} campaign result row(s) stored for week {week}")


if __name__ == "__main__":
    if len(sys.argv) != 3 or sys.argv[1] not in ("links", "export", "results"):
        raise SystemExit(__doc__)
    try:
        {"links": store_links, "export": export, "results": store_results}[sys.argv[1]](sys.argv[2])
    except SystemExit as e:
        print(e)
    except Exception as e:  # never break the content run because of the database
        print(f"gtm_sync: {sys.argv[1]} failed: {type(e).__name__}: {str(e)[:200]}")
