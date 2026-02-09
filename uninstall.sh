#!/usr/bin/env bash
# compound-engineering uninstaller
# Works for both Claude Code and Codex.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/cklxx/compound-engineering/main/uninstall.sh | bash
#   # or
#   bash ~/.compound-engineering/uninstall.sh

set -euo pipefail

CE_HOME="${CE_HOME:-$HOME/.compound-engineering}"
GREEN='\033[0;32m'
DIM='\033[2m'
NC='\033[0m'

step() { echo -e "  → $1"; }

echo ""
echo "  compound-engineering uninstaller"
echo ""

# ── 1. Remove Claude Code skills symlink ────────────────────────────

if [ -L "$HOME/.claude/skills/compound-engineering" ]; then
  rm -f "$HOME/.claude/skills/compound-engineering"
  step "Removed Claude Code skills symlink"
fi

# ── 2. Remove Claude Code slash commands ────────────────────────────

for cmd in write-plan.md record.md retro.md; do
  target="$HOME/.claude/commands/$cmd"
  if [ -L "$target" ]; then
    rm -f "$target"
  fi
done
step "Removed slash commands"

# ── 3. Remove SessionStart hook from hooks.json ─────────────────────

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
  step "Removed SessionStart hook from ${HOOKS_FILE}"
fi

# ── 4. Remove Codex skills symlink ──────────────────────────────────

if [ -L "$HOME/.agents/skills/compound-engineering" ]; then
  rm -f "$HOME/.agents/skills/compound-engineering"
  step "Removed Codex skills symlink"
fi

# ── 5. Remove the cloned repo ───────────────────────────────────────

if [ -d "$CE_HOME" ]; then
  rm -rf "$CE_HOME"
  step "Removed ${CE_HOME}"
fi

echo ""
echo -e "  ${GREEN}Done.${NC} compound-engineering has been uninstalled."
echo ""
echo "  Your project data is safe — docs/ directories in your projects are untouched."
echo "  To reinstall: curl -fsSL https://raw.githubusercontent.com/cklxx/compound-engineering/main/install.sh | bash"
echo ""
