#!/usr/bin/env bash
# Drop -e so LLM/tool failures don't kill us before we can report a verdict.
set -uo pipefail

JSONL="$HOME/Library/Application Support/meeting-notifier/$(date +%Y-%m-%d).jsonl"
LOG="$HOME/Library/Logs/claude-morning.log"
START=$(date +%s)

# Under launchd, the plist's StandardOutPath already redirects stdout to $LOG.
# When invoked manually (Hammerspoon sets INVOKED_BY=hammerspoon), tee stdout
# to the same log so both paths leave a trail — and Hammerspoon still gets
# the stdout stream it needs to parse the final OK:/ERR: line.
if [[ -n "${INVOKED_BY:-}" ]]; then
  exec > >(tee -a "$LOG")
  exec 2>&1
fi

echo "--- $(date '+%Y-%m-%d %H:%M:%S') (invoked by: ${INVOKED_BY:-launchd}) ---"
echo "/morning" | /usr/local/bin/isaac -p --model haiku --allowedTools '*' 2>&1 \
  | while IFS= read -r line; do printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$line"; done

# Success is defined as: today's meetings JSONL was (re)written during this
# run. Empty file is OK (genuinely no meetings); stale file from an earlier
# run is not.
if [[ -f "$JSONL" ]] && (( $(stat -f %m "$JSONL") >= START )); then
  echo "OK: loaded $(wc -l < "$JSONL" | tr -d ' ') meeting(s)"
  exit 0
fi
echo "ERR: meetings file not written ($JSONL)"
exit 1
