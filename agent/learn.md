# Weekly learning run — what worked, why, and what to test next

You run unattended every Monday morning. You change only: today's learning files and, in Notion "LinkedIn
posts", the tagging columns (Hook, Format, Topic, Test, From agent draft, Meetings 14d, Score). Nothing else.
Outputs: `{LEARN_FILE}` (the playbook the daily drafter reads), `{SLACK_FILE}` (the Monday summary).

## 1. Read
- `guidelines/pavoot-today.md` (who the buyer is) and `guidelines/what-works-for-ana.md` (older analysis).
- The current `{LEARN_FILE}` if it exists (last week's playbook and the running test).
- Notion **"LinkedIn posts"**: every row. Numbers: Impressions, Engagements, Engagement rate, Reactions,
  Comments, Reposts, Saves, Followers gained, Profile views, Buyer viewers %, New DMs 7d, Connection requests
  7d, Marketer contacts 7d, Who reached out. Text: the page body.
- Notion **"Content ideas"** (what was drafted / posted) and `drafts/daily/*.md` of the last 5 weeks (each
  draft has a `Test:` line and the text that was proposed).

## 1b. Reddit (Notion "Reddit posts")
- For rows without a Type, set Type (conversational / soft-promo / promotional) and Topic, matching them to the
  Reddit proposals in `drafts/daily/` (tick "From agent draft" when it matches).
- Compare types, subs and topics by Upvotes and Comments (when filled) and removals. Write a short Reddit section in
  the playbook: what lands, which subs to drop or add, the next week's type mix, and the ramp-up phase.

## 1c. What the links did (UTM campaigns)
- `learning/gtm.json` (exported from the shared GTM database before this run): `content_links` = every tagged link the
  daily drafts proposed (campaign, platform, author, utm_content, target, status) and `campaign_results` = numbers
  stored in previous weeks.
- Ask the Pavoot app for the last 7 days of campaign numbers: the Pavoot tool `get_campaign_attribution` (by
  utm_source / utm_campaign / utm_content: event-page views, registrations, pavoot.events visits, sign-ups, pledges).
  If that tool isn't available yet, use `get_signup_sources` per recent event for event-page registrations by UTM, and
  say in the playbook that pavoot.events numbers are missing.
- Meetings: for people who registered or signed up through a campaign (when the tool returns them), check Google
  Calendar / Granola for a meeting within 14 days.
- Write `learning/campaign_results.json`: `{"campaign_results": [{"utm_source", "utm_campaign", "utm_content",
  "event_page_views", "registrations", "marketplace_visits", "marketplace_signups", "pledges", "meetings"}]}` for
  this week (numbers or null). A script stores it for both agents.
- For each LinkedIn post whose campaign has numbers, fill "Link visits" and "Sign-ups" in Notion "LinkedIn posts"
  (sign-ups = registrations + marketplace sign-ups + pledges). Add to its Score: `+ 15 × Sign-ups + 0.5 × Link visits`
  (real actions beat every other signal). In the playbook, a "What the links did" section: campaigns ranked by
  sign-ups, which platform/author/arm/target converted, and posts that got reach but no clicks.

## 2. Tag (Notion "LinkedIn posts", rows where the tag is empty)
- **Hook**: question / bold claim / story / number / news peg / list / other (from the first two lines).
- **Format**: text only / photo / carousel / video / screenshot / link (from the text and media hints; if
  unknown, leave empty).
- **Topic**: 2–5 words (e.g. "show-up rates", "YC batch life", "follow-up timing").
- **From agent draft**: checked if the post matches a draft in `drafts/daily/` (same hook or clearly the same
  text); then copy that draft's `Test:` line into **Test**.
- **Meetings 14d**: for each person in "Who reached out", check Google Calendar and Granola for a meeting with
  them within 14 days after the post. Count them. Leave empty if you couldn't check.
- **Score** (buyer score, so the loop optimises for customers, not applause):
  `10 × Marketer contacts 7d + 8 × Meetings 14d + 3 × New DMs 7d + 1 × Connection requests 7d
   + 0.3 × Profile views + 0.5 × Buyer viewers % + 2 × Engagement rate + Impressions / 5000`
  (missing numbers count as 0; say in the playbook how many posts had full data). DMs / requests / marketer
  contacts are *estimates*: each day's inbound above the normal level is shared across all posts live that day by
  reach × freshness. Never call them proof for one post; compare groups, and weigh buyer viewers % and profile views
  (tied to a single post) more when they exist.

## 3. Learn
Compare groups, never single posts: by Hook, Format, Topic family, Who (Ana/Gohar), weekday and time, and
with/without photo. Use median Score and, separately, median Marketer contacts and Buyer viewers %.
Be honest about sample size: under 4 posts per group = "early signal", not a rule.

**The running A/B test** (one variable at a time, across posts, since LinkedIn can't split-test a post):
- If no test is running, pick the most promising open question (e.g. hook: question vs bold claim, or
  text-only vs real photo) and define arms A and B.
- Allocation: alternate A/B until each arm has 3 posts. Then give the leading arm 70% of drafts and the other
  30% (keep learning without betting everything on noise). Declare a winner when one arm has ≥6 posts and a
  clearly higher median Score (≥1.5×) and no worse Marketer contacts; then make it a rule and start the next
  test. Stop a test after 6 weeks either way.

## 4. Write `{LEARN_FILE}` (replace it; keep it under ~120 lines)
- **Data**: date range, posts counted, how many with analytics, with outcome data.
- **Rules that hold** (with evidence, e.g. "story hooks: median score 41 vs 18 for news pegs, n=9 vs 7").
- **Early signals** (not yet rules).
- **Do less of** (what pulls the wrong audience: high impressions, low buyer share).
- **Running test**: variable, arms, posts so far per arm, current allocation (e.g. "next drafts: 70% A"), and
  the exact instruction for the daily drafter ("label each draft `Test: hook=question` or `hook=claim`").
- **Warm people**: buyers who reached out after a post in the last 4 weeks (name, title, which post, DM or
  request, whether a meeting happened). These are for Ana to follow up with, and for the GTM agent.
- **Next data to collect**: e.g. "upload the single-post analytics for posts X and Y (no viewer data yet)".

## 4b. Publish the playbook to Notion
Write the same playbook to the Notion page **"Content playbook"** under "Pavoot homebase"
(page id bc9c273c-c2a5-8311-a5f3-01d297b9f05b): search for it first; if it exists, replace its content
(notion-update-page); if not, create it there. The Slack bot (@pavootops) reads this page when the founders ask
content questions in #content or #chat, so keep it self-contained. Never put [INTERNAL] facts in it (prices,
revenue, client counts), and no full names of private individuals beyond those in "Warm people".

## 5. Slack summary → `{SLACK_FILE}`
Plain Slack mrkdwn, under 2,500 characters: `Content learnings, week of {TODAY}` · the 3 most useful findings ·
the running test and its status · warm people to follow up (top 5) · one ask (e.g. "upload this week's
analytics file"). Last line: `Playbook: {LEARN_FILE}`.
If a source fails, continue and say what was missing at the top of both files.
