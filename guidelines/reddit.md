# Reddit strategy (Ana's account: u/Personal_Proposal960)

Adapted from the "rising" method (github.com/agamjn/rising: 500k views in 30 days for a YC founder) and Rocksalt's
Reddit guidance, fitted to Pavoot. The agent drafts; Ana reads the thread on Reddit and posts by hand. One account
only, used by Ana. Never vote, comment or post through a second account.

## 1. The three principles

1. **Write about the feeling, not the product.** People on Reddit engage with emotions: frustration, dread,
   confusion, vindication. Pavoot's problem space is full of them:
   - the dread of an empty room an hour before your event
   - the sting of 60 RSVPs and 10 people
   - the awkwardness of networking events where you meet nobody useful
   - "who do I even invite?" when you're new to a city or a role
   - the guilt of no follow-up after a great conversation
   - hosting a dinner and realising half the table didn't match
   - the boss asking "what did that event get us?"
   Name the feeling out loud. Agree-posts (naming what people quietly feel) and disagree-posts (picking a fight
   with the common take, e.g. "open RSVPs are why your meetups are bad") both drive comments.
2. **Go deep on each sub.** Read its rules (`reddit/rules/<sub>.md`), its top posts of the week and how people talk
   in the comments. Write like someone who has been there for months: its vocabulary, its post length, its tone.
3. **Two lists.** `reddit/subreddits.md`:
   - **post-here**: subs where conversational and lightly promotional posts fit.
   - **listen-only**: subs where the buyers live (marketers, sales, SaaS) but posting would read as marketing.
     Read them for language, pains and what people brag about; bring that into the post-here subs.

## 2. Post types (mix by what performs)

| Type | Default share | What it is | Test |
|---|---|---|---|
| Conversational | ~70% at first | a feeling, a question, a story, an opinion; no product at all | worth posting even if Pavoot didn't exist |
| Soft-promo | ~25% | a concrete pattern from running events, with what we built as the implementation, written as the builder ("we started approving guests by hand and built a small tool for it") | still worth reading with the product mention removed |
| Promotional | ≤5%, only in subs that allow it (showcase/self-promo threads) | openly "I built this" | the sub's rules explicitly allow it |

How Pavoot may appear: only as something Ana built/runs, in her own voice ("we", "I built"). Never as a neutral
recommendation of a tool ("I tried Pavoot, it's great"): that's a fake endorsement and gets removed and banned.
No links in posts unless the sub allows them; never more than one, never in the first lines.

## 3. Account ramp-up (the account is new)

- **Weeks 1–2**: comments only, ~3–5 helpful ones a day in post-here subs (15–30 min). No Pavoot at all. Goal:
  karma and a natural history. Many subs need minimum karma/age before posting.
- **Weeks 3–4**: first conversational posts (1 every 2–3 days), still no product.
- **From week 5**: add soft-promo, max 1 in 4 posts, only where the rules allow.
- Never post the same thing in several subs the same day; cross-post only with a rewrite and a day apart.
- Profile: Settings → Profile → hide posts and comments (keeps the profile from reading like a marketing trail).

## 4. What to pick each day

Prefer threads and topics that:
- are < 48 h old and still getting comments (answers to old threads go unseen)
- have few good answers yet
- **rank on Google or get cited by AI assistants for buyer questions** ("how do I get people to show up to my
  event", "best way to run a B2B dinner", "event ROI", "is Luma good for…"). Search those questions; when a Reddit
  thread shows up, a genuinely useful answer there keeps working for months (LLM visibility).
- match the current week's feeling in the listen-only subs.

## 5. Writing on Reddit (different from LinkedIn)

- Title: specific, with stakes, a number or a real question. "Thoughts on events?" is dead on arrival.
  Good: "60 RSVPs, 10 people showed up. What actually fixed it for us" · "Is approving every guest by hand worth it?"
- Body: plain, conversational, lowercase is fine where the sub does it. Short paragraphs, real details, no hooks
  or LinkedIn line breaks, no emojis, no hashtags, no "great question!", no sign-off.
- Comments: answer the actual question first, then one concrete detail from experience; ask a follow-up if useful.
- Never invent experiences or numbers. Use real lessons from pavoot-today.md §3–4, generalised; no customer names
  (pavoot-today.md §7).
- Same anti-AI rules as craft.md §7 (banned words, no symmetrical lists, no summary close).

## 6. Learning

- After posting, Ana drops `posted <reddit url>` in Slack #content (any message or thread). The bot logs it in
  Notion "Reddit posts" (sub, type, date). Upvotes/comments get filled in once the Reddit API is approved (or Ana
  can add them by hand).
- The weekly learning run compares types, subs and topics by upvotes and comments and shifts the mix (more of
  what lands, e.g. if conversational gets 10× promotional, go 80/20).
