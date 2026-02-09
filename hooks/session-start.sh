#!/usr/bin/env bash
# Inject the using-compound-engineering skill into every new session.
# This ensures the agent knows about all available skills on startup.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILL_FILE="$SCRIPT_DIR/skills/using-compound-engineering/SKILL.md"

if [ ! -f "$SKILL_FILE" ]; then
  echo '{"additionalContext": "compound-engineering skills not found. Please reinstall."}'
  exit 0
fi

SKILL_CONTENT=$(cat "$SKILL_FILE" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')

echo "{\"additionalContext\": $SKILL_CONTENT}"
