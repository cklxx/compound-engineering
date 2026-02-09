---
name: using-compound-engineering
description: "Bootstraps the compound engineering workflow on every session. Loads memory, discovers available skills, and establishes the experience-compounding loop."
---

# Using Compound Engineering

You have the **compound-engineering** skills installed. These skills form a continuous improvement loop that compounds your engineering experience over time.

## The Compound Loop

```
writing-plans → Execute → recording-practices → managing-memory → running-retros → (next cycle)
```

Every cycle makes the next one faster. Experience is never lost.

## Available Skills

| Skill | Auto-triggers when... |
|-------|----------------------|
| **writing-plans** | Starting non-trivial work (multi-file changes, new features, architecture decisions, refactors) |
| **recording-practices** | Fixing a bug, discovering a pitfall, finding an effective pattern, completing a tricky task |
| **managing-memory** | Making a technical decision, discovering a durable pattern, or starting a new session |
| **running-retros** | 10+ unreviewed experience entries accumulate, a milestone completes, or 7+ days pass since last retro |

## Session Startup Checklist

On every new session, you MUST:

1. **Load memory** — Read `docs/memory/long-term.md` if it exists.
2. **Scan recent experience** — Read the 3–5 most recent entries in `docs/error-experience/entries/` and `docs/good-experience/entries/`.
3. **Check active plans** — Look for in-progress plans in `docs/plans/`.
4. **Rank and retain** — Keep the top 8–12 most relevant items as active context.

Only expand beyond this when a known pattern is triggered or tests fail with a known signature.

## Directory Structure

These skills use the following directories in the host project:

```
docs/
├── plans/                        # Plan documents (writing-plans)
├── error-experience/
│   ├── entries/                  # Individual error records (recording-practices)
│   └── summary/                  # Consolidated summaries (running-retros)
├── good-experience/
│   ├── entries/                  # Individual success records (recording-practices)
│   └── summary/                  # Consolidated summaries (running-retros)
└── memory/
    ├── long-term.md              # Durable knowledge, 30–50 items (managing-memory)
    └── topics/                   # Deep-dive topic files (managing-memory)
```

Create these directories automatically when first needed. Do not ask the user.

## Core Principles

- **Record immediately** — Capture experience while context is fresh, not after the fact.
- **Root cause over symptoms** — "Why" matters more than "what."
- **Actionable knowledge** — Every memory item should tell you what to DO, not just what IS.
- **Prune aggressively** — Stale knowledge is worse than no knowledge. Keep memory curated.
- **Evidence-based rules** — Every rule links back to the experience entries that justify it.
