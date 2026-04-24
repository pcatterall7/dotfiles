#!/bin/bash
# Intentionally no `set -e`: we want to report an ERR: verdict on failure
# rather than dying silently, so consumers (launchd, Hammerspoon) can surface
# a meaningful alert.
set -uo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: $0 <customer-name>"
  exit 1
fi

CUSTOMER="$1"
TITLE="[$CUSTOMER] - $(date '+%Y-%m-%d')"
FOLDER_ID="118ohJF-gYWyPY5TI50jgZZsMXkCLzHpo"

PROMPT="Create a Google Doc titled '$TITLE' in the folder with ID '$FOLDER_ID'. Use this template content:

---
# $TITLE

## Attendees

**$CUSTOMER:**

**Databricks:**

## TL;DR

## Next Steps

## Raw Notes

---

Be sure to use the tool docs_document_create_from_markdown. After creating it, return ONLY the document URL, nothing else."

URL=$(isaac --model haiku --print "$PROMPT" 2>&1)

# Validate: the LLM is supposed to return ONLY the doc URL. If it didn't,
# the tool call probably failed and we're looking at an explanation instead.
if [[ "$URL" =~ ^https://docs\.google\.com/ ]]; then
  open -a "Google Chrome" "$URL"
  echo "OK: created doc for $CUSTOMER"
  exit 0
fi

echo "ERR: no doc URL returned (got: ${URL:0:120})"
exit 1
