---
description: "Manage project long-term memory — add, query, or update knowledge items. Usage: /memory <add|query|update|refresh> <content>"
---

# Memory — Long-term Knowledge Management

Manage project memory based on: **$ARGUMENTS**

## Memory Architecture

```
docs/memory/
├── long-term.md          # Durable knowledge (top 30–50 items, always loaded)
└── topics/               # Deep-dive files by topic (loaded on demand)
    ├── architecture.md
    ├── debugging.md
    ├── conventions.md
    └── decisions.md
```

## Operations

### `add` — Add New Knowledge

1. Evaluate if the knowledge is **durable** (useful beyond this session):
   - Will this be relevant in 2+ weeks?
   - Is it a pattern, decision, or constraint (not a one-off fix)?
   - Would forgetting this cause repeated mistakes?

2. If durable → append to `docs/memory/long-term.md` under the appropriate section:

```markdown
## Active Memory

### Architecture & Design
- [YYYY-MM-DD] <knowledge item — concise, actionable, one line>

### Conventions & Patterns
- [YYYY-MM-DD] <knowledge item>

### Technical Decisions
- [YYYY-MM-DD] <decision> — rationale: <why>

### Known Pitfalls
- [YYYY-MM-DD] <pitfall> — prevention: <how>

### Environment & Config
- [YYYY-MM-DD] <knowledge item>
```

3. If the item needs detail, create/update a topic file in `docs/memory/topics/<topic>.md` and add a brief pointer in `long-term.md`.

4. Update the `Updated:` timestamp at the top of `long-term.md`.

### `query` — Search Memory

1. Read `docs/memory/long-term.md` first.
2. If the answer isn't there, search topic files in `docs/memory/topics/`.
3. If still not found, search `docs/error-experience/` and `docs/good-experience/` entries.
4. Report what was found and confidence level.

### `update` — Modify Existing Knowledge

1. Find the item in `docs/memory/long-term.md` or topic files.
2. Update with new information, preserving the date trail:
   ```
   - [2026-01-15] Original knowledge → [2026-02-09] Updated: <new understanding>
   ```
3. If an item is now **wrong**, mark it clearly and replace:
   ```
   - ~~[2026-01-15] Old incorrect belief~~ → [2026-02-09] Corrected: <truth>
   ```

### `refresh` — Curate and Prune Memory

1. Read all items in `docs/memory/long-term.md`.
2. Score each by: **recency** (last 30 days = high), **frequency** (referenced often = high), **impact** (caused bugs or saved time = high).
3. Archive items scoring low on all three to `docs/memory/archive/YYYY-MM-archive.md`.
4. Ensure total active items stay between 30–50.
5. Update the `Updated:` timestamp.

## Memory Loading Protocol (For Every New Session)

When starting fresh on this repo, the AI should:
1. Read `docs/memory/long-term.md` (always).
2. Read latest 3–5 entries from `docs/error-experience/entries/` and `docs/good-experience/entries/`.
3. Rank by recency + relevance to current task.
4. Keep top 8–12 as active working memory.
5. Expand only when a known pattern is triggered or tests fail with known signatures.

## Guidelines
- **Concise over verbose**: Each item in `long-term.md` should be one line. Details go in topic files.
- **Date everything**: Every item gets a `[YYYY-MM-DD]` prefix.
- **Deduplicate**: Before adding, check if a similar item exists. Update rather than duplicate.
- **Actionable**: Knowledge should tell you what to DO, not just what IS.
