#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Window Gaps
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥️
# @raycast.packageName RectangleGaps

# Documentation:
# @raycast.description Toggles Rectangle window gaps
# @raycast.author Filip Chabik
# @raycast.authorURL https://github.com/pcatterall7


current_gap=$(defaults read com.knollsoft.Rectangle gapSize 2>/dev/null || echo "0")

if [ "$current_gap" -eq 0 ]; then
    defaults write com.knollsoft.Rectangle gapSize 8
    echo "Set Rectangle gapSize to 8"
else
    defaults write com.knollsoft.Rectangle gapSize 0
    echo "Set Rectangle gapSize to 0"
fi

killall Rectangle 2>/dev/null
open -a Rectangle
