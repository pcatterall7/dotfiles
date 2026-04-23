#!/usr/bin/env python3
import json
import subprocess
import sys
from pathlib import Path

CHROME_DIR = Path.home() / "Library/Application Support/Google/Chrome"


def get_bookmarks_path():
    local_state = CHROME_DIR / "Local State"
    with open(local_state) as f:
        state = json.load(f)
    profile = state.get("profile", {}).get("last_used", "Default")
    return CHROME_DIR / profile / "Bookmarks"


def walk(node, path=""):
    t = node.get("type")
    name = node.get("name", "")
    if t == "url":
        label = f"{path}/{name}" if path else name
        yield label, node.get("url", "")
    elif t == "folder":
        new_path = f"{path}/{name}" if path else name
        for child in node.get("children", []):
            yield from walk(child, new_path)


def load_bookmarks(path):
    with open(path) as f:
        data = json.load(f)
    entries = []
    for root_name in ("bookmark_bar", "other", "synced"):
        root = data["roots"].get(root_name, {})
        for child in root.get("children", []):
            entries.extend(walk(child))
    return entries


def open_in_chrome(url):
    subprocess.run(["open", "-a", "Google Chrome", url], check=True)


def main():
    bookmarks_path = get_bookmarks_path()
    if not bookmarks_path.exists():
        print(f"No bookmarks file found at: {bookmarks_path}", file=sys.stderr)
        sys.exit(1)

    entries = load_bookmarks(bookmarks_path)
    if not entries:
        print("No bookmarks found.", file=sys.stderr)
        sys.exit(0)

    labels = "\n".join(label for label, _ in entries)
    result = subprocess.run(["choose"], input=labels, capture_output=True, text=True)
    if result.returncode != 0 or not result.stdout.strip():
        sys.exit(0)

    selected = result.stdout.strip()
    url = next((url for label, url in entries if label == selected), None)
    if not url:
        print(f"Could not find URL for: {selected}", file=sys.stderr)
        sys.exit(1)

    open_in_chrome(url)


if __name__ == "__main__":
    main()
