# Links: tag every one, so we know what a post actually did

Every link in a draft carries UTM tags. The Pavoot app records them (event pages already do; pavoot.events once the
app change is live) and both agents' learning runs read the results per campaign: visits, registrations, sign-ups,
pledges, meetings. The same convention is used by pavoot-gtm for outreach, so the numbers are comparable.

## The tags
- `utm_source` = the platform: `linkedin` | `x` | `reddit` | `instagram`
- `utm_medium` = `social`
- `utm_campaign` = `content-<YYYY-MM-DD of the planned post>-<2–4 word slug>`, lowercase, hyphens
  (e.g. `content-2026-10-28-show-up-rates`). One campaign per post idea; the same campaign on every platform it goes to.
- `utm_content` = `<author>-<arm>`: author `ana` | `gohar` | `company`; arm = the A/B arm from the playbook
  (`a`/`b`) or `x` when no test runs (e.g. `ana-a`, `gohar-x`).
Order and encoding: `?utm_source=…&utm_medium=social&utm_campaign=…&utm_content=…` (no spaces; add with `&` if the
URL already has a `?`).

## Where links may point (and when)
| Target | When | Notes |
|---|---|---|
| A Pavoot event page `events.pavoot.com/e/<token>` | only for a confirmed Pavoot event (daily.md §0) | registrations per campaign already tracked |
| `pavoot.events` | only once Ana confirms the marketplace is live (`pavoot-today.md` / playbook) | sign-ups and pledges per campaign once the app change is deployed |
| `pavoot.com` | rarely: the post is about what Pavoot does | visits tracked once pavoot.com reads UTMs (check with Ana) |
| `cal.com/team/pavoot/30min` | bottom-funnel posts only ("we run your next dinner") | ask Ana; tagging cal.com links passes UTMs into the booking |
| Anything else (a news source) | proof links in newsjacks | no UTM on other people's sites |

## Platform rules
- LinkedIn: links go in the **first comment**, never the post body.
- X: in the post is fine (one link max), or in a reply to your own post.
- Reddit: only where the sub's rules allow links (`reddit/rules/<sub>.md`), never in conversational posts, never a
  shortener. Most Reddit posts have no link at all, and that's correct.
- Instagram: link in bio / story link sticker; note which link and campaign in the draft.

## Recording (machine-read)
At the end of the draft file, list every tagged link you proposed in one block, exactly:

```links
[{"campaign": "content-2026-10-28-show-up-rates", "platform": "linkedin", "author": "ana", "utm_content": "ana-a",
  "destination": "https://events.pavoot.com/e/abc?utm_source=linkedin&utm_medium=social&utm_campaign=content-2026-10-28-show-up-rates&utm_content=ana-a",
  "target": "event_page", "test_arm": "a", "draft_ref": "drafts/daily/2026-10-26.md#ana"}]
```
`target` is one of `event_page`, `pavoot_events`, `pavoot_com`, `booking`, `other`. Use `[]` when there are no links.
A script stores the block in the shared GTM database after the run.
