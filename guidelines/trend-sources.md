# Trend scan: where to look every morning (daily run, step "Trend scan")

Goal: find 0–2 stories from the last 24–48 hours worth a newsjack (craft.md §5). Most days there is none; say so.
Only public search and public APIs. Never log in to or scrape LinkedIn or X.

## Queries (web search; restrict to the last 2 days where possible)
- Big money and moves in AI/tech: "raises Series" AI this week · "valuation" AI startup today · acquisition AI
  startup · layoffs tech this week · "is hiring" field marketing / event marketing / community at AI companies
- GTM and marketing world: "field marketing" news · "event marketing" news · CMO news · B2B marketing budget
  survey 2026 · "in-person events" B2B report
- Events industry: Luma news · Cvent news · Eventbrite news · Partiful · conference cancelled / sold out
- What the founders' world is reading: YC news · Y Combinator Demo Day · Paul Graham essay · a16z / Sequoia post
  about GTM or events

## Public feeds (WebFetch)
- Hacker News front page: https://hn.algolia.com/api/v1/search?tags=front_page (titles + points; anything with
  > 300 points about AI companies, hiring, marketing or events is a candidate)
- Google News RSS search, e.g. https://news.google.com/rss/search?q=%22event+marketing%22+when:2d&hl=en-US&gl=US&ceid=US:en
  (swap the query: "field marketing", "AI raises", "Y Combinator", "Dreamforce")

## Calendar pegs (plan 3–7 days ahead; ALWAYS verify this year's dates by search before using)
Dreamforce (SF, autumn) · Web Summit (Lisbon, November) · Slush (Helsinki, late Nov/Dec) · AWS re:Invent (Las Vegas,
early Dec) · YC Demo Day (end of each batch) · Davos / WEF (January) · SaaStr Annual (spring) · SXSW (March) ·
Startup Nights (Winterthur, November) · Zurich Film Festival (autumn) · ETH / Swiss startup events.
A big conference = "what the hallway conversations at X are about", "the side events are the real event".

## Scoring each candidate (write it in the draft file)
- Size 1–5 (how many people in tech/GTM are talking about it today)
- Freshness: hours since it broke (> 48 h → skip)
- Bridge 1–5 (honest link to rooms / events / field marketing / GTM)
- Proof available? (a public link/screenshot the reader can check)
- Risk check passed?
Draft a newsjack only if Size ≥ 4, Bridge ≥ 3, fresh, with proof and no risk. Mark it "post today or skip".

## Later (TODO.md)
X/Twitter trends via Grok `x_search`; Reddit hot threads via the Reddit API; Instagram hashtag top posts.
