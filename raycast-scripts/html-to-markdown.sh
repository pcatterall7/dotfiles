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

# Pre-process HTML to remove prosemirror artifacts before pandoc
html=$(echo "$html" | sed -E '
    # Remove data-prosemirror-* attributes
    s/ data-prosemirror-[^=]*="[^"]*"//g
    # Remove prosemirror-* attributes (without data- prefix)
    s/ prosemirror-[^=]*="[^"]*"//g
    # Remove spellcheck attributes
    s/ spellcheck="[^"]*"//g
')

# Convert <span class="code"> to <code> tags so pandoc renders them as backticks
html=$(echo "$html" | sed -E 's/<span class="code"[^>]*>/<code>/g; s/<\/span>/<\/code>/g')

# Convert to Markdown using pandoc
markdown=$(echo "$html" | /opt/homebrew/bin/pandoc -f html -t gfm --wrap=none)

# Clean up any remaining artifacts:
# - Remove escaped single quotes (\' -> ')
# - Remove escaped brackets (\[ and \] -> [ and ])
markdown=$(echo "$markdown" | sed "s/\\\\'/'/g; s/\\\\\[/[/g; s/\\\\\]/]/g")

# Copy result to clipboard
echo -n "$markdown" | pbcopy

echo "Converted to Markdown ✓"
