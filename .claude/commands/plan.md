---
description: "Create a structured plan for project planning, task decomposition, or technical design. Usage: /plan <brief description of what to plan>"
---

# Plan — Project Planning & Technical Design

You are now in **planning mode**. Create a structured plan based on: **$ARGUMENTS**

## Workflow

### Step 1 — Understand Context
- Read relevant existing code, docs, and `docs/memory/long-term.md` for project context.
- If `docs/plans/` has related past plans, review them for patterns and lessons.
- Clarify ambiguous requirements with the user before proceeding.

### Step 2 — Write the Plan
Create a plan file at `docs/plans/YYYY-MM-DD-<slug>.md` using this template:

```markdown
# Plan: <Title>

> Created: YYYY-MM-DD
> Status: draft | in-progress | completed | abandoned
> Author: <who initiated>

## 1. Goal & Success Criteria
- **Goal**: One sentence — what we're trying to achieve.
- **Success criteria**: Measurable outcomes that define "done".
- **Non-goals**: Explicitly out of scope.

## 2. Context & Current State
- What exists today? Key files, modules, dependencies involved.
- What problem or opportunity motivates this work?
- Related past decisions or plans (link if exists).

## 3. Task Decomposition
Break into ordered, independently deliverable steps:

| # | Task | Files/Modules | Estimate | Dependencies |
|---|------|---------------|----------|--------------|
| 1 | ...  | ...           | S/M/L    | none         |
| 2 | ...  | ...           | S/M/L    | Task 1       |
| 3 | ...  | ...           | S/M/L    | Task 1       |

Estimation guide: S = < 30 min, M = 30 min–2 hr, L = 2+ hr.

## 4. Technical Design
- **Approach**: Describe the chosen solution in 3–5 sentences.
- **Alternatives considered**: What else was evaluated and why it was rejected.
- **Key decisions**: List architectural/technical decisions with rationale.
- **Data flow / Architecture** (optional): ASCII diagram or description.

## 5. Risk & Mitigation
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| ...  | H/M/L     | H/M/L  | ...        |

## 6. Verification Plan
- How to test/validate each task.
- Integration/regression test strategy.
- Rollback plan if things go wrong.

## 7. Milestones & Checkpoints
- [ ] Milestone 1: <description> — target date
- [ ] Milestone 2: <description> — target date
- [ ] Final delivery — target date
```

### Step 3 — Review & Refine
- Ensure every task has clear boundaries and acceptance criteria.
- Check that dependencies form a valid DAG (no circular deps).
- Validate that risks are realistic and mitigations are actionable.
- Present the plan to the user for feedback before finalizing.

### Step 4 — Activate
- Set plan status to `in-progress`.
- If relevant, record key decisions in `docs/memory/long-term.md` using `/memory`.

## Guidelines
- **Prefer small tasks**: Each task should be completable in one focused session.
- **Front-load risk**: Put uncertain or risky tasks early in the sequence.
- **Link, don't repeat**: Reference existing docs instead of duplicating content.
- **Update as you go**: Revisit the plan when reality diverges from expectations.
