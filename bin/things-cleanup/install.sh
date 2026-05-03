#!/usr/bin/env bash
set -euo pipefail

LABEL="com.user.things-cleanup"
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
        <string>/usr/bin/osascript</string>
        <string>$SCRIPT_DIR/things-cleanup.applescript</string>
    </array>

    <!-- Run daily at 9:00 AM -->
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>9</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>

    <key>RunAtLoad</key>
    <false/>

    <key>StandardOutPath</key>
    <string>$LOG_DIR/things-cleanup.log</string>

    <key>StandardErrorPath</key>
    <string>$LOG_DIR/things-cleanup-error.log</string>

    <key>ProcessType</key>
    <string>Background</string>
</dict>
</plist>
EOF

# Unload first if already installed (ignore errors)
launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"

echo "Installed and loaded $LABEL"
echo "Logs: $LOG_DIR/things-cleanup.log"
echo ""
echo "To uninstall:"
echo "  launchctl unload $PLIST && rm $PLIST"
