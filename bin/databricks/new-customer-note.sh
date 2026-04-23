#!/bin/bash

if [ -z "$1" ]; then
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

URL=$(isaac --model haiku --print "$PROMPT")

# Open in Chrome
open -a "Google Chrome" "$URL"