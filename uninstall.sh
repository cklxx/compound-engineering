#!/usr/bin/env bash
# compound-engineering uninstaller
# Works on macOS, Linux, and WSL.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/cklxx/compound-engineering/main/uninstall.sh | bash
#   # or
#   bash ~/.compound-engineering/uninstall.sh

set -euo pipefail

CE_HOME="${CE_HOME:-$HOME/.compound-engineering}"

if [ -t 1 ]; then
  GREEN='\033[0;32m'; NC='\033[0m'
else
  GREEN=''; NC=''
fi

info() { echo "  -> $1"; }

echo ""
echo "  compound-engineering uninstaller"
echo ""

# ── 1. Claude Code skills ───────────────────────────────────────────

target="$HOME/.claude/skills/compound-engineering"
if [ -L "$target" ] || [ -d "$target" ]; then
  rm -rf "$target"
  info "Removed Claude Code skills"
fi

# ── 2. Claude Code slash commands ────────────────────────────────────

for cmd in write-plan.md record.md retro.md; do
  target="$HOME/.claude/commands/$cmd"
  if [ -L "$target" ] || [ -f "$target" ]; then
    rm -f "$target"
  fi
done
info "Removed slash commands"

# ── 3. SessionStart hook ────────────────────────────────────────────

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
" 2>/dev/null && info "Removed hook from hooks.json" || \
    echo "  [skip] Could not update hooks.json. Remove the compound-engineering entry manually."
fi

# ── 4. Codex skills ─────────────────────────────────────────────────

target="$HOME/.agents/skills/compound-engineering"
if [ -L "$target" ] || [ -d "$target" ]; then
  rm -rf "$target"
  info "Removed Codex skills"
fi

# ── 5. Remove cloned repo ───────────────────────────────────────────

if [ -d "$CE_HOME" ]; then
  rm -rf "$CE_HOME"
  info "Removed ${CE_HOME}"
fi

echo ""
echo -e "  ${GREEN}Uninstalled.${NC}"
echo "  Your project data (docs/ directories) is untouched."
echo "  Reinstall: curl -fsSL https://raw.githubusercontent.com/cklxx/compound-engineering/main/install.sh | bash"
echo ""
