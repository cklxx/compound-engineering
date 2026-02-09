# Compound Engineering Workflow Guide

## The Compound Loop

```
/plan  →  Execute  →  /record  →  /memory  →  /retro  →  (repeat)
```

### 1. `/plan <topic>` — Before You Build
Create a structured plan for any non-trivial work. The plan becomes your contract with yourself.

**Example:**
```
/plan implement API rate limiter
```
Creates `docs/plans/2026-02-09-api-rate-limiter.md` with goals, tasks, design, and risks.

### 2. Execute — Write the Code
Follow the plan. Commit incrementally. When something unexpected happens, record it.

### 3. `/record <event>` — Capture Experience
Record successes and failures as they happen. Don't wait until later.

**Examples:**
```
/record error: race condition in cache invalidation — two goroutines updating same key
/record good: table-driven tests caught 3 edge cases that manual tests missed
```

### 4. `/memory <action>` — Persist Knowledge
When you learn something that will be useful in future sessions, save it.

**Examples:**
```
/memory add always wrap database errors with %w for proper error chain
/memory query how do we handle authentication
/memory refresh
```

### 5. `/retro [scope]` — Review and Distill
Run regular retros to find patterns and create reusable rules.

**Examples:**
```
/retro              # Last 7 days
/retro today        # Quick daily review
/retro testing      # Focused on testing patterns
/retro month        # Comprehensive monthly review
```

## Why This Works
- **Plans** prevent aimless coding and scope creep.
- **Records** capture context while it's fresh (not reconstructed later).
- **Memory** prevents the same mistakes across sessions.
- **Retros** compound individual lessons into systematic improvements.

Each cycle makes the next one faster and more reliable.
