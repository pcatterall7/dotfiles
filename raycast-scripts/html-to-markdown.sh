#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title HTML to Markdown
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📝
# @raycast.packageName Clipboard

# Get HTML from clipboard (macOS stores multiple representations)
html=$(osascript -e 'the clipboard as «class HTML»' 2>/dev/null | \
       sed 's/^«data HTML//;s/»$//' | xxd -r -p)

# Fallback to plain text if no HTML
if [ -z "$html" ]; then
    echo "No HTML found on clipboard"
    exit 1
fi

# Convert to Markdown using pandoc
markdown=$(echo "$html" | /opt/homebrew/bin/pandoc -f html -t markdown --wrap=none)

# Copy result to clipboard
echo -n "$markdown" | pbcopy

echo "Converted to Markdown ✓"
