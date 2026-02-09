---
name: running-retros
description: "Use when enough experience has accumulated for review — 10+ new entries, milestone completion, or 7+ days since last retro. Distills scattered experience into systematic, reusable rules."
---

# Running Retros

You MUST use this skill to periodically review accumulated experience and distill it into reusable rules. This is how scattered observations become systematic improvements.

## When This Activates

- 10+ new experience entries have accumulated without a summary.
- A plan reaches `completed` status.
- 7+ days have passed since the last retrospective.
- Repeated patterns are noticed across multiple entries.

## Workflow

### Phase 1 — Gather Raw Material

1. **Recent commits** — Review git log for the retro period:
   ```bash
   git log --oneline --since="7 days ago"
   ```
2. **Experience entries** — Read all entries from the period:
   - `docs/error-experience/entries/`
   - `docs/good-experience/entries/`
3. **Plan status** — Check `docs/plans/` for completed or updated plans.
4. **Current memory** — Read `docs/memory/long-term.md` for context.

### Phase 2 — Identify Patterns

Categorize findings:

| Category | Question |
|----------|----------|
| **Wins** | What went well? What should we keep doing? |
| **Pains** | What was painful, slow, or error-prone? |
| **Patterns** | What kept recurring (good or bad)? |
| **Surprises** | What was unexpected? |
| **Gaps** | What knowledge or tooling was missing? |

For each pattern, assess:
- **Frequency** — How many times did it occur?
- **Impact** — How much time or quality was affected?
- **Actionability** — Can we create a rule or automation to address it?

### Phase 3 — Distill Rules

Convert high-frequency, high-impact patterns into executable rules:

```markdown
## Rule: <Short imperative title>

- **Trigger**: When does this rule apply?
- **Action**: What specifically to do.
- **Evidence**: Links to the experience entries that justify this rule.
- **Example**: Concrete do/don't or before/after.
```

### Phase 4 — Update Systems

1. **Long-term memory** — Add high-impact rules to `docs/memory/long-term.md` via `managing-memory`.
2. **Experience summaries** — For 5+ entries on a topic, generate a summary in `docs/{error,good}-experience/summary/`.
3. **Project conventions** — For fundamental rules, propose additions to CLAUDE.md or AGENTS.md (require human confirmation).
4. **Archive stale items** — Remove memory entries that have been superseded by new rules.

### Phase 5 — Generate Report

Create `docs/plans/YYYY-MM-DD-retro.md`:

```markdown
# Retrospective: YYYY-MM-DD

> Period: <start> to <end>
> Commits reviewed: N
> Experience entries reviewed: N (errors: X, successes: Y)

## Wins
1. <win> — evidence: <entry link>

## Pains
1. <pain> — impact: <description> — proposed fix: <action>

## Patterns Identified
1. <pattern> — frequency: N occurrences — rule created: yes/no

## New Rules
1. **<rule name>**: <one-line summary> → persisted to: memory / summary / conventions

## Action Items
- [ ] <action> — owner — deadline

## Metrics
- Error entries this period: N
- Good entries this period: N
- Rules distilled: N
- Memory items added/updated: N
```

### Phase 6 — Schedule Next

Recommend cadence based on velocity:
- High velocity (5+ commits/day) → weekly retro
- Normal velocity (1–4 commits/day) → bi-weekly retro
- Low velocity → monthly retro

## Key Principles

- **Patterns over incidents** — Look for what recurs, not what happened once.
- **Rules must be executable** — "Be careful with X" is not a rule. "Before doing X, always check Y" is.
- **Evidence chain** — Every rule links back to the experience entries that justify it.
- **Retire the obsolete** — Old rules and stale memory must be cleaned up, not just accumulated.
