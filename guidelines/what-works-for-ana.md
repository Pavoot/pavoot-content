# What actually works for Ana — data analysis

Source: `AggregateAnalytics_Ana Yoon Faria de Lima_2026-01-01_2026-08-18.xlsx` (LinkedIn creator
export, 1 Jan – 18 Aug 2026). Per-post numbers joined to repo drafts in
`the "LinkedIn posts" Notion database (stats columns)`.

**Read this alongside `ana-engagement-playbook.md`.** The playbook was written 2026-07-27
from judgment; this file is the numbers.

**Context change: Demo Day is over.** The repo was built for the June 2026 Demo Day push. Since
mid-August the goal is reaching **customers** (field marketers, CMOs, event organizers), which
makes the "Who is actually reading" section below the most important part of this document. Most
of the rest of this file measures how well posts perform with the audience Ana already has. That
section asks whether it is the right audience, and the answer is no.

**Caveat on the data.** The export gives *Engagements* as a single combined number (reactions +
comments + reposts + clicks). Reactions are not broken out. Capped at 50 posts; 43 returned, so
coverage is complete for the window. Dates are UTC, so evening posts may be stamped a day late.

---

## The ranking

29 posts have engagement data. 17 matched to drafts in this repo. Sorted by engagement rate.

| Rate | Impr | Eng | Date | Post | Pillar |
|---:|---:|---:|---|---|---|
| **3.69%** | 2,873 | 106 | 8/4 | YC x Medplum judging | founder-journey |
| **3.53%** | 3,855 | 136 | 7/24 | Met Ilai on LinkedIn | founder-journey |
| **3.38%** | 6,121 | 207 | 7/16 | One month since Demo Day | founder-journey |
| **3.30%** | 2,814 | 93 | 8/12 | Rank the room | traction |
| **3.23%** | 4,866 | 157 | 7/13 | Events that learn | vision |
| **3.11%** | 3,339 | 104 | 6/11 | HubSpot integration live | traction |
| **3.04%** | 2,465 | 75 | 7/22 | Engineer the luck | vision |
| **2.91%** | 2,470 | 72 | 6/20 | Demo Day morning after | founder-journey |
| **2.75%** | 16,640 | 458 | 6/2 | 4.5x'd revenue in two weeks | traction |
| **2.38%** | 3,239 | 77 | 6/5 | Paul Graham + Jessica Livingston | vision |
| **2.34%** | 10,256 | 240 | 6/6 | Brazil / Armenia / ETH | founder-journey |
| **1.94%** | 8,701 | 169 | 7/20 | Cinquenta anos em cinco | founder-journey |
| **1.85%** | 10,240 | 189 | 6/15 | YC alumni Demo Day (chess) | founder-journey |
| **1.74%** | 2,935 | 51 | 8/14 | Gohar on the train | traction |
| **0.43%** | 134,847 | 576 | 5/30 | **Anthropic $65B** | vision |
| **0.43%** | 24,399 | 106 | 7/29 | **We hired an engineer (Claude)** | founder-journey |
| **0.37%** | 105,377 | 394 | 8/6 | **Nubank / J.P. Morgan lobby** | founder-journey |

Not matched to repo drafts (posted directly, or pre-repo): one-question-how-we-met (5/26, 16,466),
happy-birthday-Gohar (5/31, 14,150), replied-to-a-thanks (5/25, 6,832), what-Pavoot-was-doing
-before-YC (4/29, 6,345), bachelor's-thesis-published (1/21, 6,265), started-a-startup-2-months-ago
(2/12, 3,456), AWS talk (5/29, 2,853), IME-USP pride (5/18, 2,457), muito-top (7/18, 1,439),
exactly-what-we've-been-saying (8/1, 1,215), song-video experiment (3/16, 1,283).

---

## Read the metrics in the right order

**Engagement rate is not a quality score.** Impressions sit in the denominator, and impressions are
partly the reward. A post pushed to 134k cold readers is mathematically forced into a low rate no
matter how well written it is.

Tested on this data:

| | corr(log impressions, rate) |
|---|---:|
| All 29 posts | **-0.58** |
| Excluding the 3 virals | **-0.17** |

Log-log slope of engagements against impressions, excluding virals: **0.93**. Essentially linear.
Among normal-reach posts engagement scales in proportion to reach, so rate is roughly flat, and
**the rate spread across those 26 posts (1.74%-3.69%) is mostly noise.** Do not rank Cluster B
posts against each other by rate. The differences are not real.

Rate is only meaningful when comparing posts at *similar* reach, or when the gap is an order of
magnitude, which is the one case below.

**Use instead, in this order:**

1. **Followers gained, filtered by who they are** - audience growth only counts if it grows the
   buyer segment. Raw follower count was the right metric for Demo Day; now it needs the
   demographic split next to it.
2. **Absolute engagements** - combines reach and resonance. This is what the playbook used, and it
   was the more defensible choice.
3. **Followers per 1k impressions** - efficiency, for deciding what to write more of.
4. **Rate** - diagnostic only, for spotting the cold-reach cluster.

### Followers gained, attributed to post day + 2 days

Baseline is 6 new followers/day. Only windows with no other post inside them:

| Post | Impr | Eng | Followers | per 1k impr |
|---|---:|---:|---:|---:|
| Nubank / JPM lobby (8/6) | 105,377 | 394 | **+190** | 1.8 |
| 4.5x'd revenue (6/2) | 16,640 | 458 | **+120** | **7.2** |
| Brazil / Armenia (6/6) | 10,256 | 240 | +75 | 7.3 |
| One question, how we met (5/26) | 16,466 | 191 | +75 | 4.6 |
| YC alumni Demo Day (6/15) | 10,240 | 189 | +68 | 6.6 |

The 5/29-5/31 window shows +348 to +360 around the Anthropic post, but three posts landed in three
days there, so Anthropic and the Gohar birthday post cannot be separated. Treat that number as a
combined surge.

---

## The two clusters, stated correctly

The three borrowed-peg posts (Anthropic $65B, Nubank/JPM lobby, Claude-as-engineer) really are a
different animal, and the -0.58 vs -0.17 correlation split is the evidence: they break a pattern
the other 26 follow. But the difference is **where the reach comes from**, not post quality.

- **Cluster A - borrowed peg.** 3 posts, 264,623 impressions, **65% of all reach in eight months**,
  1,076 engagements. Naming a big outside company hands the post to LinkedIn's general tech feed,
  far outside Ana's network. Those readers came for the fact about Anthropic, not for Ana.
- **Cluster B - owned story.** 26 posts, 144,908 impressions, 3,389 engagements.

Cluster A wins on absolute engagement and on absolute followers. Cluster B wins on efficiency.
Both work. Neither is the mistake.

### What survives every metric: the 4.5x revenue post

458 engagements against Anthropic's 576, from **12% of the reach**. 120 followers from 16,640
impressions, which is 7.2 per 1k against Nubank's 1.8. It nearly ties the best post on absolute
engagement while converting reach to followers 4x more efficiently.

That is not a denominator artifact, and it is the single most useful data point on the profile.
**The target is a post that reaches like Cluster A and converts like the revenue post. None has
done both yet.**

---

## The Lane A problem

`ana-engagement-playbook.md` opens by naming the Anthropic post the #1 highest-engagement Ana
post, and builds "Lane A - borrowed attention (the Anthropic formula)" on top of it.

**That is correct.** 576 engagements is the highest of any post, and the 5/29-5/31 follower surge is
the largest of the year. An earlier version of this file called it "second-worst of 29 by rate,"
which was a misleading way to describe a mechanical property of the denominator. Lane A is real.

The one refinement the data adds: Lane A buys **reach and followers** far more than it buys
conversation, and the 7/29 Claude post is the tell. Same borrowed-peg structure, 24,399 impressions,
0.43%, the same rate as the Anthropic post to two decimals. The structure predicts the shape of the
response more reliably than the topic does.

So the four queued Lane A ideas (job board sweep, conference cost, incumbent's age, live AI news
peg) should be expected to produce big impressions and a follower bump from **founders and
engineers**. Before Demo Day that was exactly what to want. Now it is the wrong crowd, and Lane A
should be demoted rather than expanded. The one exception is the job board sweep, which is about
companies hiring *event marketers* and is therefore the only Lane A idea whose subject is the
buyer. Keep that one, park the rest.

**The playbook rule that still holds:** *"if it could have been written by any other event-tech
founder, it will underperform."* It needs one caveat. Anthropic and Nubank could have been written
by anyone with the same news, and they are the two biggest posts on the profile. The rule is a good
predictor of *engagement efficiency*, not of *reach*.

## Who is actually reading

This is the finding with the most consequence, and it is not in the playbook at all.

**Who the posts reached** (content demographics):

| | |
|---|---|
| Job title | Software Engineer 8%, Co-Founder 5%, Founder 5%, Product Manager 3%, CEO 1% |
| Seniority | Senior 28%, **Entry 23%**, Director 8%, Owner 7%, CXO 7%, VP 3% |
| Industry | Software Development 17%, Tech/Internet 15%, Financial Services 11%, IT Services 10% |
| Location | SF Bay 9%, NYC 8%, São Paulo 7%, London 5%, Bengaluru 3%, Zürich 3% |

**Marketing does not appear.** Not as an industry, not as a job title. No CMO, no VP Marketing, no
field marketing manager, no event manager anywhere in the top ten of either list. The buyer Pavoot
sells to is statistically absent from Ana's reach.

What is there instead: engineers, founders, and entry-level. Financial Services at 11% is almost
entirely the Nubank post pulling in Brazilian banking (Nubank is the #1 company at 1%, with Itaú
and BTG leading the follower base).

**This is now the finding that matters most.** Demo Day was mid-June 2026. As of mid-August the
posts exist to reach customers, not investors, which means the audience question is no longer a
tradeoff with two defensible answers. It is the bottleneck.

Under the old Demo Day goal this profile was working: VC and PE at 2% of reach, founders at 10% of
followers, ~3,000 new followers in eight months, investors and future hires watching. That job is
done.

Under the current goal it is not working. **Nothing Ana posts is reaching a field marketer.** The
profile has ~5,000 followers and produced 400k impressions this year, and essentially none of it is
the buyer. That gap will not close by writing better posts, because the posts are already good and
the distribution is sending them somewhere else.

Worth being precise about what went wrong, because it was not an accident. Every reliable
reach-driver on this profile is founder-flavoured: YC, Demo Day, Claude, Anthropic's raise,
Nubank's CEO. Those pegs work *because* they are legible to engineers and founders, which is
exactly why they cannot reach marketers. The mechanism that produced the wins is the mechanism
producing the mismatch.

**Levers worth testing, roughly in order of cost:**

1. **Write in the buyer's language, about the buyer's problems.** "Rank the room" (3.30%) and
   "Engineer the luck" (3.04%) are the two closest to this already. Neither names a tech company.
   More posts about what a field marketer's quarter actually looks like, fewer about what YC is
   like.
2. **Go to them.** Comments on marketers' posts reach marketers' networks. Cheaper than a post and
   the only lever that changes *whose* feed you appear in without paying.
3. **Tag real customers.** A tagged customer puts the post in front of their network, which is
   full of their peers. The strongest available targeting mechanism on LinkedIn, and it costs
   nothing.
4. **Use the Pavoot company page.** Its follower base can be built deliberately toward the buyer,
   and its analytics break out reactions properly, unlike the personal export.
5. **Paid, if the above stalls.** LinkedIn targeting can hit job title and industry directly, which
   is the one thing organic cannot do here.

**Re-pull the demographics after any deliberate shift.** That table is the scoreboard now, more
than impressions or engagements.

---

## What correlates with a high rate

With n=17 matched posts, treat everything here as directional.

**Important:** because rate is near-flat across Cluster B, the items below are read off absolute
engagement and follower conversion, not off the rate column. Treat as directional; n=17.

**Strong signal:**

- **First-person, first-hand.** The top four all report something Ana personally did or witnessed:
  judged a hackathon, got a LinkedIn message, sat in office hours, watched a lead go unnoticed at
  an event. No borrowed subject.
- **No external company in the hook.** Every post above 2.9% opens on Ana, Pavoot, or events.
  Every post below 0.5% opens on someone else's company.
- **Product woven into a story beats product announced.** HubSpot integration (3.11%) and Rank the
  room (3.30%) are both product posts that open on a problem or a shipped thing, not a feature
  list. Both beat the median.

**Weak or no signal:**

- **Length.** The top post is 161 words, the third is 304, the worst is 143. No relationship.
- **Numbers in the body.** Present in the best (4.5x revenue, 2.75%) and the worst (Anthropic,
  0.43%). Not predictive on its own.
- **Pillar.** Median rate by pillar: vision 2.71%, founder-journey 2.34%, traction 2.25%. The
  spread inside each pillar is far wider than the spread between them, and most of that spread is
  noise. Pillar is not the variable that matters; peg type is.
- **Weekday.** Wed 3.04%, Thu 3.11%, Tue 2.75%, Mon 1.94%, Sat 2.08%. n is 3–5 per day and the
  Cluster A posts distort it. Not actionable yet.

**The rule that survives the data:** the playbook's own line — *"if it could have been written by
any other event-tech founder, it will underperform"* — holds up. It just needs one correction. The
Anthropic and Nubank posts *could* have been written by anyone with the same news, and they are the
two lowest-rate posts on the profile. The playbook cited them as proof of the opposite.

---

## Published but never written here

Posts live on Ana's profile from after this repo started (2026-05-29) with no draft in `posts/`:

| Date | Post | Impr | Eng | Rate |
|---|---|---:|---:|---:|
| 5/31 | **happy-birthday-to-my-co-founder-gohar** | 14,150 | 220 | 1.55% |
| 8/1 | exactly-what-we-have-been-saying-at-pavoot | 1,215 | 22 | 1.81% |
| 7/18 | muito-top-ver-a-continuidade-do-que-foi-o | 1,439 | 30 | 2.08% |
| 5/29 | i-had-the-pleasure-of-speaking-at-an-aws | 2,853 | 67 | 2.35% |

The birthday post is the notable one: **6th highest reach of the year**, written outside the
system, and nothing like it exists in the repo. Warm personal posts about the co-founder
relationship are an untested lane that has exactly one data point, and that data point did well.

The 5/29 AWS post lands the same day the repo starts, so it is a boundary case rather than a real
gap.

**Also worth checking:** `posts/posted/2026-05-31-34-companies-one-day.md` is filed under `posted/`
but has no row in the export. Since the export covers all 43 posts under a 50-post cap, it was
probably never published, or went out from Gohar's profile or the company page.

---

## What to do with this

Ordered for the current goal, which is customers.

1. **Treat the demographics table as the scoreboard.** Impressions and engagements measure how well
   posts land with the wrong audience. Until marketing job titles appear in that table, the
   channel is not doing its job.
2. **Demote Lane A.** Borrowed AI-company pegs reliably pull founders and engineers. Keep the job
   board sweep, which is about the buyer, and park the other three.
3. **Write more like "Rank the room" and "Engineer the luck."** Buyer-problem posts that name no
   tech company. Both already beat the median, and they are the only two posts on the profile
   plausibly legible to a field marketer.
4. **Use the targeting levers organic actually has:** tag customers, comment on marketers' posts,
   build the company page. See the list in "Who is actually reading."
5. **Chase the 4.5x pattern for proof, not reach.** A concrete Pavoot traction number stated
   plainly is the strongest thing on the profile and is exactly what a buyer needs to see. It just
   needs to reach one.
6. **Test the warm co-founder lane.** One data point (Gohar birthday, 14,150 impressions), no draft
   in the repo. Cheap to try, though note it is unlikely to solve the audience problem.
7. **Re-pull the export monthly.** Same path, same join script. The 365-day window means anything
   older than a year drops out permanently.
