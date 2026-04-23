#!/usr/bin/env bash
set -euo pipefail

JSONL="$HOME/Library/Application Support/meeting-notifier/$(date +%Y-%m-%d).jsonl"

if [[ ! -f "$JSONL" ]]; then
  echo "No meetings file for today. Run the morning script first." >&2
  exit 1
fi

# Build display lines: "HH:MM  Meeting Name  [Room]"
display=$(jq -r '
  .time + "  " + .description +
  (if .conference_room != "" then "  [" + .conference_room + "]" else "" end)
' "$JSONL")

if [[ -z "$display" ]]; then
  echo "No meetings today." >&2
  exit 0
fi

# Present picker
selected=$(echo "$display" | choose) || exit 0

# Find which line was selected
line_num=$(echo "$display" | grep -nxF "$selected" | head -1 | cut -d: -f1)

if [[ -z "$line_num" ]]; then
  echo "Could not match selection." >&2
  exit 1
fi

# Extract meeting link from that JSONL line
link=$(sed -n "${line_num}p" "$JSONL" | jq -r '.meeting_link')

if [[ -n "$link" && "$link" != "" ]]; then
  open "$link"
else
  echo "No meeting link for: $selected" >&2
fi
