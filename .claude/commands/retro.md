---
description: "Run a retrospective — review recent work, distill scattered experience into reusable rules. Usage: /retro [topic or time range]"
---

# Retro — Retrospective Review Process

Run a retrospective for: **$ARGUMENTS**

If no arguments, default to reviewing the last 7 days of work.

## Workflow

### Phase 1 — Gather Raw Material

1. **Recent commits**: Review git log for the retro period.
   ```
   git log --oneline --since="7 days ago"
   ```
2. **Experience entries**: Read all entries from the retro period in:
   - `docs/error-experience/entries/`
   - `docs/good-experience/entries/`
3. **Plans**: Check `docs/plans/` for plans created or updated in the period.
4. **Memory**: Read `docs/memory/long-term.md` for context.

### Phase 2 — Pattern Analysis

Categorize findings into:

| Category | Question |
|----------|----------|
| **Wins** | What went well? What should we keep doing? |
| **Pains** | What was painful, slow, or error-prone? |
| **Patterns** | What kept recurring (good or bad)? |
| **Surprises** | What was unexpected? |
| **Gaps** | What knowledge or tools were missing? |

For each pattern found, determine:
- **Frequency**: How often did this occur?
- **Impact**: How much time/quality was affected?
- **Actionability**: Can we create a rule or automation to address this?

### Phase 3 — Distill Rules

Convert patterns into actionable rules. Each rule should be:

```markdown
## Rule: <Short imperative name>

- **Trigger**: When does this rule apply?
- **Action**: What specifically to do.
- **Rationale**: Why — link to experience entries as evidence.
- **Example**: Concrete before/after or do/don't.
```

### Phase 4 — Update Systems

Based on the rules distilled:

1. **Update memory**: Add high-impact rules to `docs/memory/long-term.md` via the memory management format.
2. **Create summaries**: If 5+ entries cover a similar topic, create a summary in `docs/{error,good}-experience/summary/`.
3. **Update CLAUDE.md / AGENTS.md**: If a rule is fundamental enough, propose adding it to project conventions.
4. **Archive stale items**: Move outdated memory items to archive.

### Phase 5 — Generate Report

Output a retro report at `docs/plans/YYYY-MM-DD-retro.md`:

```markdown
# Retrospective: YYYY-MM-DD

> Period: <start> to <end>
> Commits reviewed: N
> Experience entries reviewed: N

## Wins
1. <win> — evidence: <link to entry>
2. ...

## Pains
1. <pain> — impact: <description> — proposed fix: <action>
2. ...

## Patterns Identified
1. <pattern> — frequency: N occurrences — rule created: yes/no
2. ...

## New Rules Added
1. **<rule name>**: <one-line summary> → added to: memory / CLAUDE.md / summary
2. ...

## Action Items
- [ ] <action> — owner — deadline
- [ ] <action> — owner — deadline

## Metrics
- Error entries this period: N
- Good entries this period: N
- Rules distilled: N
- Memory items added/updated: N
```

### Phase 6 — Schedule Next

Suggest when the next retro should happen based on work velocity:
- High velocity (5+ commits/day): weekly retro
- Normal velocity (1–4 commits/day): bi-weekly retro
- Low velocity: monthly retro

## Quick Retro Modes
- `/retro` — Full 7-day retro (default)
- `/retro today` — Quick daily review
- `/retro <topic>` — Focused retro on a specific topic (e.g., `/retro testing`, `/retro performance`)
- `/retro month` — Comprehensive monthly review
