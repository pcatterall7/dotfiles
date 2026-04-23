#!/usr/bin/env bash
set -euo pipefail
echo "/morning" | isaac -p --model haiku --allowedTools '*'
