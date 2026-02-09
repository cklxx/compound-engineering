---
name: writing-plans
description: "Use when starting non-trivial work — new features, refactors, architecture changes, multi-file modifications. Generates a structured plan before any code is written."
---

# Writing Plans

You MUST use this skill before starting any non-trivial work. A task is non-trivial if it touches 3+ files, takes more than 30 minutes, or involves design decisions.

## When This Activates

- The user describes a feature, refactor, or architecture change.
- The work involves multiple files or modules.
- There are multiple valid approaches and a choice must be made.
- The scope is unclear and needs decomposition.

## Workflow

### Step 1 — Understand Before Planning

- Read relevant code, docs, and `docs/memory/long-term.md` for project context.
- Check `docs/plans/` for related past plans — extract lessons, avoid repeated mistakes.
- If requirements are ambiguous, ask the user to clarify. Batch questions into one round.

### Step 2 — Write the Plan

Create `docs/plans/YYYY-MM-DD-<slug>.md`:

```markdown
# Plan: <Title>

> Created: YYYY-MM-DD
> Status: draft | in-progress | completed | abandoned
> Trigger: <what prompted this plan>

## 1. Goal & Success Criteria
- **Goal**: One sentence — what we are achieving.
- **Success criteria**: Measurable outcomes that define "done."
- **Non-goals**: Explicitly out of scope.

## 2. Current State
- What exists today — key files, modules, dependencies.
- What problem or opportunity drives this work.
- Related past decisions (link to existing records if any).

## 3. Task Breakdown

Break into ordered, independently deliverable steps.
Each task should be completable in one focused session (2–5 min ideal, 30 min max).

| # | Task | Files/Modules | Size | Depends On |
|---|------|---------------|------|------------|
| 1 | ...  | ...           | S/M/L| —          |
| 2 | ...  | ...           | S/M/L| T1         |

Size guide: S < 30 min, M = 30 min–2 hr, L > 2 hr (split further).

## 4. Technical Design
- **Chosen approach**: 3–5 sentences describing the solution.
- **Alternatives considered**: What else was evaluated and why it was rejected.
- **Key decisions**: Architectural/technical decisions with rationale.

## 5. Risks & Mitigation

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| ...  | H/M/L     | H/M/L  | ...        |

## 6. Verification
- How each task will be tested.
- Rollback plan if things go wrong.

## 7. Milestones
- [ ] M1: <description>
- [ ] M2: <description>
- [ ] Delivery complete
```

### Step 3 — Validate the Plan

Before executing:
- Every task has clear boundaries and acceptance criteria.
- Dependencies form a valid DAG (no cycles).
- Risks are realistic and mitigations are actionable.
- Present the plan to the user and wait for approval.

### Step 4 — Execute and Maintain

- Update plan status as work progresses.
- When reality diverges from the plan, update the plan first.
- On completion, record key decisions via the `managing-memory` skill.

## Key Principles

- **Small tasks** — If a task can't be described in one sentence, split it.
- **Front-load risk** — Put uncertain work early so surprises come cheap.
- **Link, don't repeat** — Reference existing docs instead of duplicating.
- **Plans are living documents** — Update when reality changes, don't abandon silently.
