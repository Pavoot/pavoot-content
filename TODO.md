# TODO

- [ ] **X trends via Grok**: add an xAI API key + `grok-mcp` (https://github.com/guzus/grok-mcp) to the daily
      run so it checks what's trending on X around field marketing / events / GTM each morning
      (`x_search`, ~$5 per 1k calls per third-party sources; verify on docs.x.ai).
- [ ] **X performance**: once posting on X regularly, pull own posts' metrics via the X API (pay-per-use,
      ~$0.005 per post read; own non-public metrics only last 30 days; verify on docs.x.com).
- [ ] Auto-posting via LinkedIn / X APIs with a one-click approve in Slack (after drafts are reliably good).
- [ ] "posted <url>" reply in #content → bot sets the idea's Status = Posted.
- [ ] **Reddit API** (requested 2026-10-25 via Reddit's Data Access Request form, account Personal_Proposal960,
      read-only: subreddit search + own comment history). Self-serve app creation is closed until approved.
      When approved: create a "script" app, keys in Keychain (`pavoot-reddit-id`, `pavoot-reddit-secret`), build the
      read-only scanner that runs before the daily drafter. Until then: paste a thread into #content → bot drafts the reply.
