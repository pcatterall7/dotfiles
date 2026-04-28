#!/usr/bin/env bash
set -euo pipefail

LABEL="com.user.claude-theme-sync"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT="$SCRIPT_DIR/claude-theme-sync.py"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
WATCH_PATH="$HOME/Library/Preferences/.GlobalPreferences.plist"
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
        <string>/usr/bin/python3</string>
        <string>$SCRIPT</string>
    </array>

    <!-- Fire whenever macOS appearance prefs change -->
    <key>WatchPaths</key>
    <array>
        <string>$WATCH_PATH</string>
    </array>

    <!-- Also run once at login to sync immediately -->
    <key>RunAtLoad</key>
    <true/>

    <key>StandardOutPath</key>
    <string>$LOG_DIR/claude-theme-sync.log</string>

    <key>StandardErrorPath</key>
    <string>$LOG_DIR/claude-theme-sync-error.log</string>
</dict>
</plist>
EOF

# Unload first if already installed (ignore errors)
launchctl unload "$PLIST" 2>/dev/null || true
launchctl load "$PLIST"

echo "Installed and loaded $LABEL"
echo "Logs: $LOG_DIR/claude-theme-sync.log"
echo ""
echo "To uninstall:"
echo "  launchctl unload $PLIST && rm $PLIST"
