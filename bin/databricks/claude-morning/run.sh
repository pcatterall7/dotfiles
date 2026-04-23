#!/usr/bin/env bash
set -euo pipefail
echo "/morning" | /usr/local/bin/isaac -p --model haiku --allowedTools '*' 2>&1 | while IFS= read -r line; do printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$line"; done
