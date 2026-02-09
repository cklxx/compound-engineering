# Compound Engineering — AI-Assisted Workflow System

## Project Overview
A structured engineering workflow system that compounds experience over time through planning, recording, memory, and retrospectives. Designed for use with Claude Code and Codex.

## Non-negotiables
- **Plan before building**: Non-trivial work requires a plan file under `docs/plans/`.
- **Record as you go**: Errors and wins go to `docs/error-experience/entries/` and `docs/good-experience/entries/`.
- **Memory is sacred**: Key learnings live in `docs/memory/long-term.md`; keep it curated (30–50 items).
- **Retro regularly**: Run `/retro` weekly to distill patterns into reusable rules.
- **Commit often**: Split work into small, incremental commits.
- **Safety first**: No destructive git operations unless explicitly requested.

## Available Skills (slash commands)

| Command | Purpose | Example |
|---------|---------|---------|
| `/plan` | Create a structured project plan | `/plan add user authentication` |
| `/record` | Record a best practice or anti-pattern | `/record error: forgot to handle null case in parser` |
| `/memory` | Manage long-term project knowledge | `/memory add always use UTC for timestamps` |
| `/retro` | Run a retrospective review | `/retro` or `/retro testing` |

## Memory Loading (every new session)
1. Read `docs/memory/long-term.md` first.
2. Scan latest 3–5 entries from `docs/error-experience/entries/` and `docs/good-experience/entries/`.
3. Rank by recency and relevance; keep top 8–12 as active context.
4. Expand only when a known pattern is triggered.

## Directory Structure
```
.claude/commands/        # Skill definitions (Claude Code)
docs/
├── plans/               # Project plans (dated)
├── error-experience/
│   ├── entries/         # Individual error records
│   └── summary/         # Consolidated summaries
├── good-experience/
│   ├── entries/         # Individual success records
│   └── summary/         # Consolidated summaries
├── memory/
│   ├── long-term.md     # Durable knowledge (always loaded)
│   └── topics/          # Deep-dive topic files
└── guides/              # How-to guides
```

## Coding Conventions
- Prefer correctness and maintainability over cleverness.
- Avoid unnecessary defensive code; trust guaranteed invariants.
- No compatibility shims — refactor cleanly.
- Use TDD when touching logic.
- Run lint + tests before delivery.
