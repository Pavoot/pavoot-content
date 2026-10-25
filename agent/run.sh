#!/bin/zsh
# Daily content run: Claude drafts today's posts, then the summary goes to Slack #content.
# Manual run: ./agent/run.sh [daily|learn]   ·   Schedule: ~/Library/LaunchAgents/com.pavoot.content-daily.plist (copy of agent/)
# Slack webhook URL lives in the macOS Keychain (never in a file):
#   security add-generic-password -a "$USER" -s pavoot-content-webhook -w 'https://hooks.slack.com/services/...'
set -u
export PATH="/Users/ana/.nvm/versions/node/v24.14.0/bin:/Users/ana/.local/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"

ROOT="${0:A:h:h}"                       # .../pavoot-content
cd "$ROOT" || exit 1
MODE="${1:-daily}"                      # daily (every morning) | learn (Mondays)
TODAY=$(date +%F)
mkdir -p drafts/daily learning agent/logs
if [[ "$MODE" == "learn" ]]; then
  PROMPT_FILE=agent/learn.md
  OUT="learning/learnings.md"
  SLACKF="learning/$TODAY.slack.txt"
else
  PROMPT_FILE=agent/daily.md
  OUT="drafts/daily/$TODAY.md"
  SLACKF="drafts/daily/$TODAY.slack.txt"
fi
LOG="agent/logs/$TODAY-$MODE.log"

PROMPT=$(sed -e "s|{DRAFT_FILE}|$OUT|g" -e "s|{LEARN_FILE}|$OUT|g" -e "s|{SLACK_FILE}|$SLACKF|g" -e "s|{TODAY}|$TODAY|g" "$PROMPT_FILE")
PROMPT="$PROMPT

Today is $(date '+%A %Y-%m-%d'). Output file: $OUT. Slack file: $SLACKF. Playbook from the weekly learning run: learning/learnings.md."

# Read everything; write only today's two files; Notion edits limited to updating a page (Status).
ALLOWED=(
  "Read" "Glob" "Grep" "WebSearch" "WebFetch"
  "Edit(drafts/daily/**)" "Edit(learning/**)"
  "mcp__granola__search_meetings" "mcp__granola__list_meetings" "mcp__granola__get_meetings"
  "mcp__granola__get_meeting_transcript"
  "mcp__pavoot__whoami" "mcp__pavoot__list_my_events" "mcp__pavoot__get_event_dashboard"
  "mcp__pavoot__get_event_analytics" "mcp__pavoot__get_attendance_report" "mcp__pavoot__list_reportable_events"
  "mcp__pavoot__get_post_event_insights"
  "mcp__notion__notion-search" "mcp__notion__notion-fetch" "mcp__notion__notion-query-data-sources"
  "mcp__notion__notion-update-page"
  "mcp__google-calendar__search-events" "mcp__google-calendar__list-events"
)

claude -p "$PROMPT" --allowedTools "${ALLOWED[@]}" --permission-mode dontAsk \
  --no-session-persistence > "$LOG" 2>&1
rc=$?

if [[ -s "$SLACKF" ]]; then
  MSG=$(cat "$SLACKF")
else
  MSG="Content $MODE run for $TODAY didn't produce a summary (exit $rc). Log: $ROOT/$LOG"
fi

HOOK=$(security find-generic-password -a "$USER" -s pavoot-content-webhook -w 2>/dev/null)
if [[ -z "$HOOK" ]]; then
  echo "No Slack webhook in Keychain (pavoot-content-webhook); summary is in $SLACKF" >> "$LOG"
  exit $rc
fi
/usr/bin/python3 -I -c 'import json,sys; print(json.dumps({"text": sys.stdin.read()}))' <<< "$MSG" \
  | curl -sS -X POST -H 'Content-Type: application/json' --data @- "$HOOK" >> "$LOG" 2>&1
exit $rc
