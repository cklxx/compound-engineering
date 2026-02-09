#!/usr/bin/env bash
# compound-engineering installer
# Works for both Claude Code and Codex. Run once in any project directory.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/cklxx/compound-engineering/main/install.sh | bash
#   # or
#   bash install.sh

set -euo pipefail

REPO="https://github.com/cklxx/compound-engineering.git"
CE_HOME="${CE_HOME:-$HOME/.compound-engineering}"
BLUE='\033[0;34m'
GREEN='\033[0;32m'
DIM='\033[2m'
NC='\033[0m'

step() { echo -e "${BLUE}→${NC} $1"; }
done() { echo -e "${GREEN}✓${NC} $1"; }

echo ""
echo "  compound-engineering installer"
echo "  Automatic learning loop for AI coding agents"
echo ""

# ── 1. Clone or update the skills repo ──────────────────────────────

step "Downloading skills to ${CE_HOME}"
if [ -d "$CE_HOME/.git" ]; then
  git -C "$CE_HOME" pull --quiet
  done "Updated existing installation"
else
  git clone --quiet "$REPO" "$CE_HOME"
  done "Cloned to ${CE_HOME}"
fi

# ── 2. Claude Code setup ────────────────────────────────────────────

step "Setting up Claude Code"

# 2a. Personal skills (global, all projects)
CLAUDE_SKILLS="$HOME/.claude/skills"
mkdir -p "$CLAUDE_SKILLS"
ln -sfn "$CE_HOME/skills" "$CLAUDE_SKILLS/compound-engineering"
done "Skills linked → ${CLAUDE_SKILLS}/compound-engineering"

# 2b. Hooks (global)
CLAUDE_HOOKS_DIR="$HOME/.claude"
HOOKS_FILE="$CLAUDE_HOOKS_DIR/hooks.json"
CE_HOOK_CMD="bash $CE_HOME/hooks/session-start.sh"

if [ -f "$HOOKS_FILE" ]; then
  # Check if our hook already exists
  if grep -q "compound-engineering" "$HOOKS_FILE" 2>/dev/null; then
    done "Hook already registered in ${HOOKS_FILE}"
  else
    # Append our hook into existing hooks array
    python3 -c "
import json, sys
with open('$HOOKS_FILE') as f:
    data = json.load(f)
hooks = data.get('hooks', [])
hooks.append({
    'type': 'UserPromptSubmit',
    'command': '$CE_HOOK_CMD',
    'events': ['startup', 'resume', 'clear', 'compact']
})
data['hooks'] = hooks
with open('$HOOKS_FILE', 'w') as f:
    json.dump(data, f, indent=2)
    f.write('\n')
"
    done "Hook appended to ${HOOKS_FILE}"
  fi
else
  cat > "$HOOKS_FILE" <<HOOKEOF
{
  "hooks": [
    {
      "type": "UserPromptSubmit",
      "command": "$CE_HOOK_CMD",
      "events": ["startup", "resume", "clear", "compact"]
    }
  ]
}
HOOKEOF
  done "Hook created at ${HOOKS_FILE}"
fi

# 2c. Commands (optional slash commands)
CLAUDE_COMMANDS="$HOME/.claude/commands"
mkdir -p "$CLAUDE_COMMANDS"
for cmd in "$CE_HOME"/commands/*.md; do
  [ -f "$cmd" ] && ln -sfn "$cmd" "$CLAUDE_COMMANDS/$(basename "$cmd")"
done
done "Slash commands linked → ${CLAUDE_COMMANDS}/"

# ── 3. Codex setup ──────────────────────────────────────────────────

step "Setting up Codex"
CODEX_SKILLS="$HOME/.agents/skills"
mkdir -p "$CODEX_SKILLS"
ln -sfn "$CE_HOME/skills" "$CODEX_SKILLS/compound-engineering"
done "Skills linked → ${CODEX_SKILLS}/compound-engineering"

# ── 4. Done ─────────────────────────────────────────────────────────

echo ""
echo -e "${GREEN}Done.${NC} compound-engineering is installed for both Claude Code and Codex."
echo ""
echo "  What happens next:"
echo "    1. Start a Claude Code or Codex session in any project"
echo "    2. The agent automatically loads the compound-engineering skills"
echo "    3. It will plan, record, remember, and review — with zero manual effort"
echo ""
echo "  To update:  cd ${CE_HOME} && git pull"
echo "  To remove:  bash ${CE_HOME}/uninstall.sh"
echo ""
