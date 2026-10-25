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
  (missing numbers count as 0; say in the playbook how many posts had full data).

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
