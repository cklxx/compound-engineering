#!/usr/bin/env bash
# compound-engineering installer
# Works for both Claude Code and Codex on macOS, Linux, and WSL.
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/cklxx/compound-engineering/main/install.sh | bash
#   # or
#   bash install.sh

set -euo pipefail

REPO="https://github.com/cklxx/compound-engineering.git"
CE_HOME="${CE_HOME:-$HOME/.compound-engineering}"

# ── Colors (safe for non-tty) ───────────────────────────────────────

if [ -t 1 ]; then
  BLUE='\033[0;34m'; GREEN='\033[0;32m'; NC='\033[0m'
else
  BLUE=''; GREEN=''; NC=''
fi

info()  { echo -e "  ${BLUE}->${NC} $1"; }
ok()    { echo -e "  ${GREEN}ok${NC} $1"; }

# ── Detect platform ─────────────────────────────────────────────────

OS="$(uname -s)"
case "$OS" in
  Linux*)   PLATFORM="linux" ;;
  Darwin*)  PLATFORM="macos" ;;
  MINGW*|MSYS*|CYGWIN*) PLATFORM="windows" ;;
  *)        PLATFORM="unknown" ;;
esac

echo ""
echo "  compound-engineering installer (${PLATFORM})"
echo ""

# ── 1. Clone or update the skills repo ──────────────────────────────

info "Downloading skills to ${CE_HOME}"
if [ -d "$CE_HOME/.git" ]; then
  git -C "$CE_HOME" pull --quiet 2>/dev/null || git -C "$CE_HOME" pull
  ok "Updated existing installation"
else
  git clone --quiet "$REPO" "$CE_HOME" 2>/dev/null || git clone "$REPO" "$CE_HOME"
  ok "Cloned to ${CE_HOME}"
fi

# ── 2. Claude Code setup ────────────────────────────────────────────

info "Setting up Claude Code"

# 2a. Skills symlink
CLAUDE_SKILLS="$HOME/.claude/skills"
mkdir -p "$CLAUDE_SKILLS"
if [ "$PLATFORM" = "windows" ]; then
  # Windows: use junction or copy
  if command -v cmd.exe &>/dev/null; then
    cmd.exe /c "mklink /J \"$(cygpath -w "$CLAUDE_SKILLS/compound-engineering")\" \"$(cygpath -w "$CE_HOME/skills")\"" 2>/dev/null || \
      cp -r "$CE_HOME/skills" "$CLAUDE_SKILLS/compound-engineering"
  else
    cp -r "$CE_HOME/skills" "$CLAUDE_SKILLS/compound-engineering"
  fi
else
  ln -sfn "$CE_HOME/skills" "$CLAUDE_SKILLS/compound-engineering"
fi
ok "Skills -> ${CLAUDE_SKILLS}/compound-engineering"

# 2b. Hooks
HOOKS_FILE="$HOME/.claude/hooks.json"
CE_HOOK_CMD="bash $CE_HOME/hooks/session-start.sh"

if [ -f "$HOOKS_FILE" ]; then
  if grep -q "compound-engineering" "$HOOKS_FILE" 2>/dev/null; then
    ok "Hook already registered"
  else
    # Append hook using python3 (available on macOS/Linux/WSL)
    python3 -c "
import json
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
" 2>/dev/null && ok "Hook appended to hooks.json" || {
      echo "  [skip] Could not update hooks.json (python3 not found). Add manually."
    }
  fi
else
  mkdir -p "$(dirname "$HOOKS_FILE")"
  printf '%s\n' '{' \
    '  "hooks": [' \
    '    {' \
    "      \"type\": \"UserPromptSubmit\"," \
    "      \"command\": \"$CE_HOOK_CMD\"," \
    '      "events": ["startup", "resume", "clear", "compact"]' \
    '    }' \
    '  ]' \
    '}' > "$HOOKS_FILE"
  ok "Hook created at hooks.json"
fi

# 2c. Slash commands
CLAUDE_COMMANDS="$HOME/.claude/commands"
mkdir -p "$CLAUDE_COMMANDS"
for cmd in "$CE_HOME"/commands/*.md; do
  [ -f "$cmd" ] || continue
  if [ "$PLATFORM" = "windows" ]; then
    cp "$cmd" "$CLAUDE_COMMANDS/$(basename "$cmd")"
  else
    ln -sfn "$cmd" "$CLAUDE_COMMANDS/$(basename "$cmd")"
  fi
done
ok "Slash commands -> ${CLAUDE_COMMANDS}/"

# ── 3. Codex setup ──────────────────────────────────────────────────

info "Setting up Codex"
CODEX_SKILLS="$HOME/.agents/skills"
mkdir -p "$CODEX_SKILLS"
if [ "$PLATFORM" = "windows" ]; then
  if command -v cmd.exe &>/dev/null; then
    cmd.exe /c "mklink /J \"$(cygpath -w "$CODEX_SKILLS/compound-engineering")\" \"$(cygpath -w "$CE_HOME/skills")\"" 2>/dev/null || \
      cp -r "$CE_HOME/skills" "$CODEX_SKILLS/compound-engineering"
  else
    cp -r "$CE_HOME/skills" "$CODEX_SKILLS/compound-engineering"
  fi
else
  ln -sfn "$CE_HOME/skills" "$CODEX_SKILLS/compound-engineering"
fi
ok "Skills -> ${CODEX_SKILLS}/compound-engineering"

# ── 4. Summary ──────────────────────────────────────────────────────

echo ""
echo -e "  ${GREEN}Installed.${NC} compound-engineering is ready for Claude Code and Codex."
echo ""
echo "  Next steps:"
echo "    Start any Claude Code or Codex session — skills activate automatically."
echo ""
echo "  Update:     cd ${CE_HOME} && git pull"
echo "  Uninstall:  curl -fsSL https://raw.githubusercontent.com/cklxx/compound-engineering/main/uninstall.sh | bash"
echo ""
