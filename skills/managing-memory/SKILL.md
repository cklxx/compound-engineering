---
name: managing-memory
description: "Use when durable knowledge emerges — technical decisions, recurring patterns, project conventions, known pitfalls. Persists knowledge to a local knowledge base that survives across sessions."
---

# Managing Memory

You MUST use this skill to persist knowledge that will remain useful beyond the current session. This is how the agent builds lasting project understanding.

## When This Activates

- A technical decision is made (technology choice, architecture, trade-off).
- A recurring pattern or convention is established.
- The `recording-practices` skill captures a high-impact or recurring experience.
- A new session starts and project context must be loaded.
- Memory has grown stale and needs curation.

## Memory Architecture

```
docs/memory/
├── long-term.md              # Core knowledge (30–50 items, always loaded)
└── topics/                   # Deep-dive files by topic (loaded on demand)
    ├── architecture.md
    ├── debugging.md
    ├── conventions.md
    └── decisions.md
```

## Operations

### Persist — Store New Knowledge

1. **Evaluate durability** — Will this be useful in 2+ weeks? Is it a pattern, decision, or constraint (not a one-off fix)? Would forgetting it cause repeated mistakes?

2. **If durable** — Append to `docs/memory/long-term.md` under the appropriate section:

```markdown
## Active Memory

### Architecture & Design
- [YYYY-MM-DD] <concise, actionable, one line>

### Conventions & Patterns
- [YYYY-MM-DD] <knowledge item>

### Technical Decisions
- [YYYY-MM-DD] <decision> — rationale: <why>

### Known Pitfalls
- [YYYY-MM-DD] <pitfall> — prevention: <how>

### Environment & Config
- [YYYY-MM-DD] <knowledge item>
```

3. **If the item needs detail** — Create or update `docs/memory/topics/<topic>.md` and add a one-line pointer in `long-term.md`.

4. **Update the timestamp** at the top of `long-term.md`.

### Load — Session Startup

On every new session, MUST:
1. Read `docs/memory/long-term.md` (always).
2. Scan the 3–5 most recent entries from `docs/error-experience/entries/` and `docs/good-experience/entries/`.
3. Rank by recency and relevance to the current task.
4. Keep top 8–12 as active working context.
5. Expand only when a known pattern is triggered or tests fail with a known signature.

### Update — Correct Existing Knowledge

When knowledge changes:
```markdown
- [2026-01-15] Original understanding → [2026-02-09] Updated: <new understanding>
```

When knowledge was wrong:
```markdown
- ~~[2026-01-15] Incorrect belief~~ → [2026-02-09] Corrected: <actual truth>
```

### Curate — Prune Stale Knowledge

Triggered when items exceed 50 or during `running-retros`:
1. Score each item: **recency** (30 days = high) × **frequency** (often referenced = high) × **impact** (prevented bugs or saved time = high).
2. Archive items scoring low on all three to `docs/memory/archive/YYYY-MM-archive.md`.
3. Keep active items between 30–50.

## Key Principles

- **One line per item** — Details go in topic files, not in `long-term.md`.
- **Date everything** — Every item gets a `[YYYY-MM-DD]` prefix.
- **Deduplicate before adding** — Update existing items rather than creating duplicates.
- **Actionable over descriptive** — "Always do X before Y" beats "X depends on Y."
- **Prune aggressively** — Stale knowledge is worse than no knowledge.
