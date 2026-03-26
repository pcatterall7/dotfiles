#!/usr/bin/env python3
"""
Poll today's meetings JSONL and fire a terminal-notifier notification
5 minutes before each meeting. Designed to run every minute via launchd.
"""

import datetime
import json
import os
import subprocess
import sys

DATA_DIR = os.path.expanduser("~/Library/Application Support/meeting-notifier")
TERMINAL_NOTIFIER = "/opt/homebrew/bin/terminal-notifier"
NOTIFY_MINUTES_BEFORE = 5


def main():
    today = datetime.date.today().strftime("%Y-%m-%d")
    jsonl_path = os.path.join(DATA_DIR, f"{today}.jsonl")
    state_path = os.path.join(DATA_DIR, f"{today}.notified")

    if not os.path.exists(jsonl_path):
        sys.exit(0)  # No meetings file for today yet

    notified = set()
    if os.path.exists(state_path):
        with open(state_path) as f:
            notified = {line.strip() for line in f if line.strip()}

    with open(jsonl_path) as f:
        meetings = [json.loads(line) for line in f if line.strip()]

    now = datetime.datetime.now()

    for meeting in meetings:
        meeting_id = f"{meeting['time']}|{meeting['description']}"
        if meeting_id in notified:
            continue

        h, m = map(int, meeting["time"].split(":"))
        meeting_dt = now.replace(hour=h, minute=m, second=0, microsecond=0)
        minutes_until = (meeting_dt - now).total_seconds() / 60

        if not (0 <= minutes_until <= NOTIFY_MINUTES_BEFORE):
            continue

        message = meeting["description"]
        if meeting.get("conference_room"):
            message += f" · {meeting['conference_room']}"

        meeting_link = meeting.get("meeting_link", "")

        args = [
            TERMINAL_NOTIFIER,
            "-title", "Meeting in 5 min",
            "-message", message,
            "-sound", "default",
            "-group", meeting["time"],
        ]
        if meeting_link:
            args += ["-open", meeting_link]

        subprocess.run(args)

        with open(state_path, "a") as f:
            f.write(meeting_id + "\n")


if __name__ == "__main__":
    main()
