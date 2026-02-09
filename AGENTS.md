# Compound Engineering — Agent Rules (Codex / Claude Code)

## Project snapshot
- A structured engineering workflow system that compounds experience over time.
- Core loop: Plan → Execute → Record → Remember → Retro → Improve.
- Key directories: `.claude/commands/`, `docs/plans/`, `docs/memory/`, `docs/error-experience/`, `docs/good-experience/`.

## Non-negotiables (must follow)
- Plan before building: non-trivial work requires a plan under `docs/plans/`.
- Record experiences: errors → `docs/error-experience/entries/`, wins → `docs/good-experience/entries/`.
- Maintain long-term memory in `docs/memory/long-term.md` (30–50 curated items).
- Run retros regularly to distill patterns into rules.
- Commit often; split into incremental commits.
- No destructive git operations unless explicitly requested.
- Avoid unnecessary defensive code; no compatibility shims.

## Skills / Slash Commands

### /plan — Project Planning & Task Decomposition
**When**: Before starting non-trivial work.
**What**: Creates a structured plan at `docs/plans/YYYY-MM-DD-<slug>.md` covering goal, context, task breakdown, technical design, risks, milestones.
**Usage**: `/plan <description of what to plan>`

### /record — Best Practice & Anti-Pattern Recording
**When**: After encountering a significant success or failure.
**What**: Creates a structured entry in `docs/error-experience/entries/` or `docs/good-experience/entries/` with root cause, impact, resolution, and prevention rules.
**Usage**: `/record <what happened>` or `/record error: <error>` or `/record good: <success>`

### /memory — Long-term Knowledge Management
**When**: After making a technical decision, discovering a recurring pattern, or learning something durable.
**What**: Manages `docs/memory/long-term.md` — add, query, update, or refresh knowledge items. Keeps 30–50 curated active items.
**Usage**: `/memory add <knowledge>` or `/memory query <question>` or `/memory refresh`

### /retro — Retrospective Review Process
**When**: Weekly, or after completing a significant milestone.
**What**: Reviews git history + experience entries, identifies patterns (wins/pains/surprises), distills reusable rules, updates memory and summaries.
**Usage**: `/retro` (last 7 days) or `/retro today` or `/retro <topic>` or `/retro month`

## Memory loading (every new session)
1. Read `docs/memory/long-term.md`.
2. Scan latest 3–5 entries from error/good experience.
3. Rank by recency + relevance, keep top 8–12 as active context.
4. Expand beyond active memory only when a known pattern is relevant.
5. Update `docs/memory/long-term.md` `Updated:` timestamp on first write each day.

## Workflow integration
```
Plan (/plan)
  → Execute (write code)
  → Record (/record) — capture wins and errors as they happen
  → Memory (/memory) — persist durable knowledge
  → Retro (/retro) — periodic review, distill rules
  → Feed back into next Plan
```
