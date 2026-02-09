#!/usr/bin/env bash
# compound-engineering uninstaller

set -euo pipefail

CE_HOME="${CE_HOME:-$HOME/.compound-engineering}"
RED='\033[0;31m'
NC='\033[0m'

echo ""
echo "  Removing compound-engineering..."
echo ""

# Remove Claude Code links
rm -f "$HOME/.claude/skills/compound-engineering"
for cmd in "$CE_HOME"/commands/*.md 2>/dev/null; do
  [ -f "$cmd" ] && rm -f "$HOME/.claude/commands/$(basename "$cmd")"
done

# Remove hook from hooks.json
HOOKS_FILE="$HOME/.claude/hooks.json"
if [ -f "$HOOKS_FILE" ] && grep -q "compound-engineering" "$HOOKS_FILE" 2>/dev/null; then
  python3 -c "
import json
with open('$HOOKS_FILE') as f:
    data = json.load(f)
data['hooks'] = [h for h in data.get('hooks', []) if 'compound-engineering' not in h.get('command', '')]
with open('$HOOKS_FILE', 'w') as f:
    json.dump(data, f, indent=2)
    f.write('\n')
"
  echo "  Removed hook from ${HOOKS_FILE}"
fi

# Remove Codex link
rm -f "$HOME/.agents/skills/compound-engineering"

# Remove the repo itself
rm -rf "$CE_HOME"

echo ""
echo -e "  ${RED}Removed.${NC} compound-engineering has been uninstalled."
echo "  Note: docs/ directories in your projects are untouched (your data is safe)."
echo ""
