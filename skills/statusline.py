#!/usr/bin/env python3
import json
import sys

data = json.load(sys.stdin)

model = data.get("model", {}).get("display_name", "Unknown")

usage = (data.get("context_window") or {}).get("current_usage")
if usage:
    tokens_used = (
        (usage.get("input_tokens") or 0)
        + (usage.get("cache_creation_input_tokens") or 0)
        + (usage.get("cache_read_input_tokens") or 0)
    )
    remaining_pct = (data.get("context_window") or {}).get("remaining_percentage")
    tokens_str = f"{tokens_used / 1000:.1f}k"
    if remaining_pct is not None:
        print(f"{model} | {tokens_str} ({remaining_pct:.0f}% remaining)")
    else:
        print(f"{model} | {tokens_str}")
else:
    print(model)
