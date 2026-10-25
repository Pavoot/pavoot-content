# pavoot-content

Every morning at 08:00 (launchd on Ana's Mac) `agent/run.sh` runs Claude headless with `agent/daily.md`:
it reads `guidelines/`, the Notion "Content ideas" (Status = New) and "LinkedIn posts" databases,
Granola calls of the last 3 days, Pavoot event numbers and this week's news, then writes
`drafts/daily/<date>.md` (full drafts) and posts a summary to Slack #content.

## Setup (once)
1. Notion in Claude Code: `claude mcp add --scope user --transport http notion https://mcp.notion.com/mcp`, sign in via `/mcp`.
2. Slack incoming webhook for #content, stored in Keychain:
   `security add-generic-password -a "$USER" -s pavoot-content-webhook -w 'https://hooks.slack.com/services/...'`
3. Schedule: `cp agent/com.pavoot.content-daily.plist ~/Library/LaunchAgents/ && launchctl load ~/Library/LaunchAgents/com.pavoot.content-daily.plist`
4. Test now: `./agent/run.sh` (log in `agent/logs/<date>.log`).

## Updating the data
DM the pavoot-ops bot a fresh LinkedIn export zip and/or the creator analytics `.xlsx`
(LinkedIn → Analytics → Export). The bot stores it and refreshes the Notion "LinkedIn posts" database.
