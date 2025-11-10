#!/bin/bash

# Dependency: requires iTerm (https://iterm2.com)
# Install via Homebrew: `brew install --cask iterm2`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open AI Chat
# @raycast.mode silent
# @raycast.packageName iTerm

# Optional parameters:
# @raycast.icon images/iterm.png

# Documentation
# @raycast.author Phil Catterall
# @raycast.authorURL https://github.com/pcatterall7

# Check if iTerm is running
if pgrep -x "iTerm2" > /dev/null; then
    # iTerm is running - focus it, create new tab, and run aichat
    osascript <<EOF
tell application "iTerm"
    activate
    tell current window
        create tab with default profile
    end tell
    tell current session of current window
        write text "aichat"
    end tell
end tell
EOF
else
    # iTerm is not running - select right-most container, open iTerm, resize, and run aichat

    # Focus the right-most container
    aerospace focus right

    # Open iTerm and wait for it to be ready
    osascript <<EOF
tell application "iTerm"
    activate
    -- Wait for iTerm to fully start and have windows
    repeat until (count of windows) > 0
        delay 0.1
    end repeat
    -- Additional small delay to ensure session is ready
    delay 0.5
    tell current session of current window
        write text "aichat"
    end tell
end tell
EOF

    # Wait a moment then resize
    sleep 0.1
    aerospace resize width 500
fi
