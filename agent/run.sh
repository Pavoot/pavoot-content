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
  "mcp__pavoot__get_post_event_insights" "mcp__pavoot__get_campaign_attribution" "mcp__pavoot__get_signup_sources"
  "mcp__notion__notion-search" "mcp__notion__notion-fetch" "mcp__notion__notion-query-data-sources"
  "mcp__notion__notion-update-page" "mcp__notion__notion-create-pages"
  "mcp__google-calendar__search-events" "mcp__google-calendar__list-events"
)

if [[ "$MODE" == "learn" ]]; then      # the learning run reads links + past campaign numbers from the shared GTM db
  .venv/bin/python agent/gtm_sync.py export learning/gtm.json >> "$LOG" 2>&1
fi

claude -p "$PROMPT" --allowedTools "${ALLOWED[@]}" --permission-mode dontAsk \
  --no-session-persistence > "$LOG" 2>&1
rc=$?
if [[ "$MODE" == "learn" ]]; then
  [[ -s learning/campaign_results.json ]] && .venv/bin/python agent/gtm_sync.py results learning/campaign_results.json >> "$LOG" 2>&1
else
  [[ -s "$OUT" ]] && .venv/bin/python agent/gtm_sync.py links "$OUT" >> "$LOG" 2>&1
fi

if [[ -s "$SLACKF" ]]; then
  MSG=$(cat "$SLACKF")
else
  MSG="Content $MODE run for $TODAY didn't produce a summary (exit $rc). Log: $ROOT/$LOG"
fi

if [[ -n "${NO_SLACK:-}" ]]; then        # NO_SLACK=1 ./agent/run.sh : test run, nothing posted
  echo "NO_SLACK set: not posting; summary is in $SLACKF" >> "$LOG"
  exit $rc
fi
HOOK=$(security find-generic-password -a "$USER" -s pavoot-content-webhook -w 2>/dev/null)
if [[ -z "$HOOK" ]]; then
  echo "No Slack webhook in Keychain (pavoot-content-webhook); summary is in $SLACKF" >> "$LOG"
  exit $rc
fi
# Each section starts with "===== <channel>" (overview|linkedin|reddit|x|instagram) and goes to that platform's
# webhook (Keychain: pavoot-content-webhook-<channel>, e.g. pavoot-content-webhook-reddit); #content otherwise.
SLACK_HOOK="$HOOK" SLACK_MSG="$MSG" /usr/bin/python3 -I - >> "$LOG" 2>&1 <<'PY'
import json, os, re, subprocess, time, urllib.request
default, text = os.environ["SLACK_HOOK"], os.environ["SLACK_MSG"].replace("\r", "")
hooks = {}

def hook(name):
    if name not in hooks:
        r = subprocess.run(["security", "find-generic-password", "-a", os.environ.get("USER", ""), "-s",
                            f"pavoot-content-webhook-{name}", "-w"], capture_output=True, text=True)
        hooks[name] = r.stdout.strip() if r.returncode == 0 and r.stdout.strip() else default
    return hooks[name]

sections = re.split(r"(?m)^=====[ \t]*([a-z]*)[^\n]*$", "\n" + text)
parts = [("overview", sections[0])] + list(zip(sections[1::2], sections[2::2]))
for name, body in parts:
    body = body.strip()
    if not body:
        continue
    url = hook(name or "overview") if name != "overview" else default
    for i in range(0, len(body), 3900):          # Slack's limit per message is ~4,000 characters
        req = urllib.request.Request(url, json.dumps({"text": body[i:i + 3900]}).encode(),
                                     {"Content-Type": "application/json"})
        print(name, urllib.request.urlopen(req, timeout=20).read().decode())
        time.sleep(1)
PY
exit $rc
