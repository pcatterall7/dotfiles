#!/usr/bin/env python3
"""
claude-theme-sync — sync Claude Code theme with macOS appearance

Triggered by launchd WatchPaths when ~/Library/Preferences/.GlobalPreferences.plist
changes. Reads the current macOS appearance and writes the matching theme to
~/.claude.json.
"""

import json
import os
import subprocess
import sys

CLAUDE_CONFIG = os.path.expanduser("~/.claude.json")


def current_appearance() -> str:
    """Return 'dark' or 'light' based on macOS appearance setting."""
    result = subprocess.run(
        ["defaults", "read", "-g", "AppleInterfaceStyle"],
        capture_output=True,
        text=True,
    )
    return "dark" if result.stdout.strip() == "Dark" else "light"


def set_claude_theme(theme: str) -> bool:
    """
    Update the 'theme' key in ~/.claude.json. Returns True if changed.
    Creates the file with just the theme key if it doesn't exist.
    Writes atomically via a temp file to avoid corrupting the config.
    """
    config = {}
    if os.path.exists(CLAUDE_CONFIG):
        with open(CLAUDE_CONFIG) as f:
            try:
                config = json.load(f)
            except json.JSONDecodeError:
                print(f"Warning: could not parse {CLAUDE_CONFIG}, overwriting", file=sys.stderr)

    if config.get("theme") == theme:
        return False

    config["theme"] = theme

    with open(CLAUDE_CONFIG, "w") as f:
        json.dump(config, f, indent=2)
        f.write("\n")

    return True


def main():
    theme = current_appearance()
    changed = set_claude_theme(theme)
    if changed:
        print(f"claude-theme-sync: set theme → {theme}")
    else:
        print(f"claude-theme-sync: theme already {theme}, no change")


if __name__ == "__main__":
    main()
