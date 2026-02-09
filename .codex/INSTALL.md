# Codex Installation

## Install

```bash
git clone https://github.com/cklxx/compound-engineering.git ~/.codex/compound-engineering
mkdir -p ~/.agents/skills
ln -s ~/.codex/compound-engineering/skills ~/.agents/skills/compound-engineering
```

## Update

```bash
cd ~/.codex/compound-engineering && git pull
```

## Uninstall

```bash
rm -f ~/.agents/skills/compound-engineering
rm -rf ~/.codex/compound-engineering
```
