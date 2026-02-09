---
description: "Record a best practice or anti-pattern from current work. Usage: /record <what happened — success or failure>"
---

# Record — Structured Practice Recording

Record an engineering experience based on: **$ARGUMENTS**

## Workflow

### Step 1 — Classify the Experience
Determine the type:
- **good-experience** (best practice, success pattern, useful technique)
- **error-experience** (bug, anti-pattern, pitfall, debugging lesson)

### Step 2 — Gather Details
- Read relevant code, error logs, or discussion context.
- Identify the root cause (for errors) or key insight (for good practices).
- Determine impact and reproducibility.

### Step 3 — Write the Entry

**For error-experience** → `docs/error-experience/entries/YYYY-MM-DD-<slug>.md`:

```markdown
# YYYY-MM-DD — <Short descriptive title>

## Error
- What happened? (symptoms, error messages, unexpected behavior)
- Where? (file paths, functions, modules involved)
- When? (during what activity — coding, testing, deployment, review)

## Root Cause
- Why did it happen? (the actual underlying cause)
- Contributing factors (environment, assumptions, missing knowledge)

## Impact
- Severity: P0 (production down) / P1 (major bug) / P2 (moderate) / P3 (minor)
- Blast radius: what was affected?

## Resolution
- What fixed it? (specific steps taken)
- Time to resolution.

## Lessons & Prevention
- What rule or check would have caught this earlier?
- Suggested prevention: lint rule / test / code pattern / process change.

## Tags
`<tag1>` `<tag2>` `<tag3>`
```

**For good-experience** → `docs/good-experience/entries/YYYY-MM-DD-<slug>.md`:

```markdown
# YYYY-MM-DD — <Short descriptive title>

## Practice
- What was done? (technique, pattern, approach)
- Context: what problem was being solved?

## Why It Worked
- Key factors that made this effective.
- Comparison: what would have happened without this practice?

## Impact
- Measurable improvement (time saved, bugs prevented, clarity gained).

## How to Reproduce
- Step-by-step guide to apply this practice in similar situations.
- Prerequisites or conditions where this applies.

## When NOT to Use
- Conditions where this practice doesn't apply or could backfire.

## Tags
`<tag1>` `<tag2>` `<tag3>`
```

### Step 4 — Cross-reference
- Check if similar entries already exist in the entries directories. If so, reference them.
- If the lesson is significant and recurring, suggest adding it to `docs/memory/long-term.md` via `/memory`.

### Step 5 — Summarize (Periodic)
When entries in a category exceed 10 unsummarized items, create a summary:
`docs/{error,good}-experience/summary/YYYY-MM-<topic>-summary.md`:

```markdown
# Summary: <Topic> — YYYY-MM

## Patterns Observed
- Pattern 1: <description> (entries: file1, file2, ...)
- Pattern 2: <description> (entries: file3, file4, ...)

## Consolidated Rules
1. Rule derived from pattern 1.
2. Rule derived from pattern 2.

## Open Questions
- Unresolved items that need more data.
```

## Quick Record Shortcuts
- If the user says `/record good: <text>`, skip classification and write a good-experience entry.
- If the user says `/record error: <text>`, skip classification and write an error-experience entry.
- If the user says `/record` with no arguments, ask what happened.
