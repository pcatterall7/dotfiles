#!/usr/bin/env bash
set -euo pipefail

LABEL="com.user.claude-morning"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="$SCRIPT_DIR/run.sh"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
LOG_DIR="$HOME/Library/Logs"

chmod +x "$SCRIPT"

cat > "$PLIST" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$LABEL</string>

    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$SCRIPT</string>
    </array>

    <!-- Run daily at 9:00 AM -->
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>9</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>

    <key>StandardOutPath</key>
    <string>$LOG_DIR/claude-morning.log</string>

    <key>StandardErrorPath</key>
    <string>$LOG_DIR/claude-morning-error.log</string>
</dict>
</plist>
EOF

# Unload first if already installed (ignore errors)
launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"

echo "Installed and loaded $LABEL"
echo "Logs: $LOG_DIR/claude-morning.log"
echo ""
echo "To uninstall:"
echo "  launchctl unload $PLIST && rm $PLIST"
