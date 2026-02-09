---
name: recording-practices
description: "Use DURING work when a notable event occurs — bug fixed, non-obvious root cause found, effective technique discovered, pitfall hit. Logs raw experience entries. Does NOT distill rules (that's running-retros) or persist knowledge (that's managing-memory)."
---

# Recording Practices

**Role in the loop:** LOG raw events as they happen. This skill captures what occurred, why, and what to do about it. It does NOT decide what to remember long-term (that's `managing-memory`) or find patterns across entries (that's `running-retros`).

## Precise Trigger Conditions

Activate this skill when you observe ANY of these **concrete signals**:

| Signal | What to record | Type |
|--------|---------------|------|
| You changed code to fix a bug | The bug, its root cause, the fix | error |
| A test failed for a non-obvious reason | The failure, the actual cause, how you diagnosed it | error |
| You wasted 10+ minutes on something avoidable | What happened, what would have saved time | error |
| You tried approach A, it failed, approach B worked | Why A failed, why B worked | error + good |
| You found a technique that saved significant time | The technique, the context, the impact | good |
| A code pattern prevented a class of bugs | The pattern, what it prevents, how to apply it | good |
| You discovered something counter-intuitive | The expectation, the reality, the explanation | error or good |

Do NOT activate when:
- The fix was trivial and obvious (typo, missing import)
- The information is already in an existing entry (check first)
- You're still in the middle of debugging (wait until resolved)

## Workflow

### Step 1 — Classify: error or good?

Ask yourself one question: **Did something go wrong, or did something go right?**

- Wrong → `docs/error-experience/entries/YYYY-MM-DD-<slug>.md`
- Right → `docs/good-experience/entries/YYYY-MM-DD-<slug>.md`

If both (tried A, failed; tried B, succeeded), write TWO entries.

### Step 2 — Write the entry

**Error entry template:**

```markdown
# YYYY-MM-DD — <verb phrase describing what went wrong>

## What Happened
<2–3 sentences. What were you doing? What went wrong? What did you see?>

## Root Cause
<1–2 sentences. The ACTUAL underlying reason, not the symptom.>

## Impact
- Severity: P0 / P1 / P2 / P3
- Time lost: <how long this cost you>

## Fix
<The specific code change, config change, or command that resolved it.>

## Prevention Rule
<One sentence: what check, test, or practice would catch this BEFORE it happens again?>

## Tags
`<domain>` `<language>` `<category>`
```

**Good entry template:**

```markdown
# YYYY-MM-DD — <verb phrase describing what worked>

## What Was Done
<2–3 sentences. What technique, pattern, or approach was used? In what context?>

## Why It Worked
<1–2 sentences. The key factor that made this effective.>

## Impact
<What improved — time saved, bugs prevented, clarity gained. Be specific.>

## How to Reproduce
<Step-by-step: how to apply this technique in a similar situation.>

## Conditions
- Works when: <prerequisites>
- Doesn't work when: <counter-conditions>

## Tags
`<domain>` `<language>` `<category>`
```

### Concrete Examples

**Error entry — real example:**

```markdown
# 2026-02-09 — nil map panic in config loader

## What Happened
Added a new config field. Tests passed. Production crashed on startup with
`assignment to entry in nil map` at config/loader.go:47.

## Root Cause
The `Overrides` map was declared but never initialized. Tests used a
factory function that initializes it, but the production code path
uses struct literal without the factory.

## Impact
- Severity: P1 (app won't start)
- Time lost: 45 minutes (debugging + hotfix + deploy)

## Fix
Changed `Overrides map[string]string` to `Overrides map[string]string` with
init in `NewConfig()` and added a nil check in `LoadConfig()`.

## Prevention Rule
Always initialize maps in struct constructors. Add a linter check for
uninitialized map fields in exported structs.

## Tags
`go` `nil-safety` `config`
```

**Good entry — real example:**

```markdown
# 2026-02-09 — table-driven tests caught 4 edge cases in parser

## What Was Done
Rewrote the CSV parser tests from 12 individual test functions to one
table-driven test with 30 cases covering: empty input, single column,
quoted fields, escaped quotes, Unicode, trailing newlines, CRLF vs LF.

## Why It Worked
Table format made it trivial to add cases — just one more row. The visual
alignment made missing coverage obvious (no Unicode case? add one).

## Impact
Caught 4 bugs that individual tests missed: Unicode BOM handling, empty
last field, CR-only line endings, and quoted field with embedded newline.

## How to Reproduce
1. List all inputs as `{name, input, expected}` rows in a test table
2. Scan the table visually for missing categories (empty, boundary, Unicode, error)
3. Run with `-v` to see which cases pass/fail

## Conditions
- Works when: function has many input variants with predictable outputs
- Doesn't work when: tests need complex setup/teardown per case

## Tags
`go` `testing` `table-driven`
```

### Step 3 — Check for duplicates

Before writing, scan existing entries in the same directory:
- If a similar entry exists → update it instead of creating a new one
- If the same root cause appeared before → reference the old entry and note recurrence

### Step 4 — Handoff

After writing the entry:
- If the lesson is **high-impact AND durable** (you're confident it will matter in 2+ weeks) → trigger `managing-memory` to persist a one-liner to `long-term.md`
- If there are now **10+ entries** without a summary → note that `running-retros` should be triggered
- Otherwise, just move on. Not every entry needs to be memorialized.
