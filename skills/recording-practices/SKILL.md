---
name: recording-practices
description: "Use when a notable engineering event occurs — bug fix, debugging breakthrough, performance win, effective pattern, anti-pattern discovered. Automatically captures structured experience records."
---

# Recording Practices

You MUST use this skill whenever a notable engineering event occurs during your work. Do not wait until the end — record while context is fresh.

## When This Activates

- You fixed a bug or resolved a technical issue.
- You discovered an effective pattern or technique.
- You hit a pitfall, anti-pattern, or counter-intuitive behavior.
- A debugging session revealed a non-obvious root cause.
- You completed a task and there is a reusable takeaway.

## Workflow

### Step 1 — Classify

Determine the experience type:
- **error-experience** — Bugs, pitfalls, anti-patterns, debugging lessons, things that went wrong.
- **good-experience** — Best practices, successful patterns, effective techniques, things that went right.

### Step 2 — Write the Entry

**For error-experience** — Create `docs/error-experience/entries/YYYY-MM-DD-<slug>.md`:

```markdown
# YYYY-MM-DD — <Short descriptive title>

## What Happened
- Symptoms, error messages, unexpected behavior.
- Where: file paths, functions, modules involved.
- During: what activity (coding, testing, deploying, reviewing).

## Root Cause
- The actual underlying cause.
- Contributing factors (environment, assumptions, knowledge gaps).

## Impact
- Severity: P0 (production down) / P1 (major bug) / P2 (moderate) / P3 (minor)
- Blast radius: what was affected.

## Resolution
- What fixed it (specific steps).

## Prevention Rule
- What check or practice would have caught this earlier?
- Suggested: lint rule / test / code pattern / process change.

## Tags
`tag1` `tag2` `tag3`
```

**For good-experience** — Create `docs/good-experience/entries/YYYY-MM-DD-<slug>.md`:

```markdown
# YYYY-MM-DD — <Short descriptive title>

## Practice
- What was done (technique, pattern, approach).
- Context: what problem was being solved.

## Why It Worked
- Key factors that made this effective.
- Comparison: what would have happened without this practice.

## Impact
- Measurable improvement (time saved, bugs prevented, clarity gained).

## How to Reproduce
- Step-by-step guide to apply this in similar situations.
- Prerequisites and conditions where it applies.

## When NOT to Use
- Conditions where this practice backfires.

## Tags
`tag1` `tag2` `tag3`
```

### Step 3 — Cross-reference

- Check if similar entries already exist. Reference them rather than duplicate.
- If the lesson is high-impact or recurring, trigger the `managing-memory` skill to persist it in long-term memory.

### Step 4 — Periodic Summarization

When entries in a category exceed 10 unsummarized items, automatically generate a summary at `docs/{error,good}-experience/summary/YYYY-MM-<topic>.md`:

```markdown
# Summary: <Topic> — YYYY-MM

## Patterns Observed
- Pattern 1: <description> (entries: file1, file2, ...)
- Pattern 2: <description> (entries: file3, file4, ...)

## Consolidated Rules
1. Rule from pattern 1.
2. Rule from pattern 2.

## Open Questions
- Items needing more data to confirm.
```

## Key Principles

- **Immediate over deferred** — Record while context is fresh, not from memory later.
- **Root cause over symptoms** — "Why" is always more valuable than "what."
- **Actionable** — Every entry must include a prevention rule or reproduction guide.
- **Deduplicate** — Check existing entries before creating new ones. Update rather than repeat.
