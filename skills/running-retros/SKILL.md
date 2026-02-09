---
name: running-retros
description: "Use when enough raw experience has accumulated to compress — 10+ unreviewed entries, milestone completed, or 7+ days since last retro. Reads entries, finds patterns, distills executable rules, and feeds them back into memory. This is the compression step that turns raw logs into curated knowledge."
---

# Running Retros

**Role in the loop:** COMPRESS raw experience into systematic knowledge. This is the skill that makes compound-engineering actually compound. Without retros, you just have a pile of entries. With retros, you have rules.

**What this skill does that others don't:**
- `recording-practices` logs individual events → this skill finds PATTERNS across events
- `managing-memory` stores one-off insights → this skill produces SYSTEMATIC rules from evidence
- `writing-plans` looks forward → this skill looks backward

## Precise Trigger Conditions

| Trigger | How to detect |
|---------|--------------|
| **10+ new entries** | Count files in `docs/error-experience/entries/` and `docs/good-experience/entries/` created since last retro report |
| **Milestone completed** | A plan in `docs/plans/` changed to `Status: completed` |
| **7+ days elapsed** | Last file in `docs/plans/*retro*` is older than 7 days |
| **Pattern spotted** | You notice the same issue appearing in 3+ entries while working |

Do NOT run a retro:
- In the middle of executing a plan (finish the work first)
- When there are fewer than 5 entries to review (not enough data)
- If the last retro was less than 3 days ago (too soon)

## Workflow

### Phase 1 — Gather (read, don't write)

```bash
# 1. What was committed
git log --oneline --since="7 days ago"

# 2. What went wrong
ls docs/error-experience/entries/    # read all since last retro

# 3. What went right
ls docs/good-experience/entries/     # read all since last retro

# 4. What was planned
ls docs/plans/                       # check status of active plans

# 5. What we know
cat docs/memory/long-term.md         # current state of knowledge
```

### Phase 2 — Find patterns (the hard part)

For each entry, extract: **category**, **root cause**, **domain**.

Then look for clusters:

```
Entry 1: nil map panic (root cause: uninitialized struct field)
Entry 4: nil pointer in handler (root cause: uninitialized struct field)
Entry 7: zero value bug in config (root cause: uninitialized struct field)
──────────────────────────────────────────────────────────────────────
PATTERN: "Uninitialized struct fields" — 3 occurrences, all P1/P2
```

Categorize patterns into:

| Category | Question | Action |
|----------|----------|--------|
| **Wins** | What went well? Keep doing it? | Reinforce in memory |
| **Pains** | What was slow, painful, error-prone? | Create prevention rule |
| **Recurring errors** | What root cause appeared 2+ times? | Create prevention rule + suggest automation |
| **Gaps** | What knowledge was missing? | Add to memory |
| **Surprises** | What was unexpected? | Investigate further or add to pitfalls |

### Phase 3 — Distill rules

A rule is NOT "be careful with X." A rule IS:

```markdown
## Rule: Initialize all map and slice fields in Go struct constructors

- **Trigger**: Creating a new Go struct with map or slice fields
- **Action**: Add initialization in the constructor function. If no constructor exists, create one.
- **Evidence**: error-experience entries 2026-02-03, 2026-02-05, 2026-02-07 — all nil map/slice panics from uninitialized fields
- **Example**:
  ```go
  // BAD
  type Config struct {
      Overrides map[string]string
  }

  // GOOD
  func NewConfig() *Config {
      return &Config{
          Overrides: make(map[string]string),
      }
  }
  ```
```

**Rule quality checklist:**
- [ ] Has a concrete trigger (when to apply)
- [ ] Has a concrete action (what to do)
- [ ] Links to 2+ entries as evidence
- [ ] Includes a do/don't example

### Phase 4 — Update systems

For each distilled rule:

| Destination | When | How |
|------------|------|-----|
| `docs/memory/long-term.md` | Always for high-impact rules | One-liner via `managing-memory` format |
| `docs/{error,good}-experience/summary/` | When 5+ entries cover the same topic | Create summary file |
| Suggest CLAUDE.md / AGENTS.md update | When the rule is fundamental to the project | Propose to user, don't auto-modify |

### Phase 5 — Write the retro report

Create `docs/plans/YYYY-MM-DD-retro.md`:

```markdown
# Retrospective: YYYY-MM-DD

> Period: YYYY-MM-DD to YYYY-MM-DD
> Entries reviewed: N (errors: X, good: Y)
> Commits reviewed: N

## Patterns Found

### Pattern 1: <name> (N occurrences)
- Entries: <links>
- Impact: <aggregate impact>
- Rule created: yes → <rule name>

### Pattern 2: <name> (N occurrences)
- Entries: <links>
- Impact: <aggregate impact>
- Rule created: yes/no

## New Rules Added to Memory
1. **<rule>** — evidence: <entries> → added to: memory/long-term.md
2. **<rule>** — evidence: <entries> → added to: memory/long-term.md

## Wins to Reinforce
1. <practice> — evidence: <entries> — keep doing this

## Unresolved Pains
1. <pain> — needs: <what would fix it>

## Memory Changes
- Added: N items
- Updated: N items
- Archived: N items
- Active items now: N (target: 30–50)

## Next Retro
Recommended: YYYY-MM-DD (based on current velocity)
```

### Concrete Example

A real retro output:

```markdown
# Retrospective: 2026-02-09

> Period: 2026-02-02 to 2026-02-09
> Entries reviewed: 12 (errors: 8, good: 4)
> Commits reviewed: 23

## Patterns Found

### Pattern 1: Uninitialized Go struct fields (3 occurrences)
- Entries: 2026-02-03-nil-map, 2026-02-05-slice-panic, 2026-02-07-config-zero
- Impact: 2.5 hours debugging total, 1 production incident
- Rule created: yes → "Initialize all map/slice fields in constructors"

### Pattern 2: Table-driven tests finding more bugs (2 occurrences)
- Entries: 2026-02-04-table-tests-parser, 2026-02-06-table-tests-validator
- Impact: Caught 7 edge case bugs that individual tests missed
- Rule created: yes → "Default to table-driven tests for functions with many input variants"

## New Rules Added to Memory
1. **Initialize all map/slice fields in constructors** — 3 entries → memory/long-term.md
2. **Default to table-driven tests** — 2 entries → memory/long-term.md

## Wins to Reinforce
1. Writing plans before multi-file changes — 0 scope creep incidents this week

## Memory Changes
- Added: 2 items
- Updated: 1 item
- Archived: 0 items
- Active items now: 34 (target: 30–50)

## Next Retro
Recommended: 2026-02-16 (weekly, current velocity: 3.3 commits/day)
```

## Key Principles

- **Patterns over incidents.** One entry is an event. Three entries with the same root cause is a pattern. Only patterns become rules.
- **Rules must be executable.** "Be careful" = useless. "Before X, always do Y" = useful.
- **Evidence chain.** Every rule links to 2+ entries. No evidence, no rule.
- **Compress, don't hoard.** After a retro, the entries served their purpose. The rules carry the knowledge forward.
