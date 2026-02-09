# compound-engineering

**Install once. Your AI agent automatically learns from every session — plans before coding, records mistakes and wins, builds persistent memory, and reviews itself. Code quality compounds over time, on autopilot.**

---

## The Problem

Every AI coding session starts from zero. The agent forgets past bugs, re-discovers the same solutions, repeats the same mistakes. Session 100 is no smarter than session 1.

## The Fix

compound-engineering is a set of skills you install into your AI coding agent (Claude Code, Codex, or any agent). Once installed, the agent **automatically**:

1. **Plans** before writing code — no more diving in blind
2. **Records** every bug fix, pitfall, and breakthrough — while context is fresh
3. **Remembers** across sessions — loads a curated knowledge base on startup
4. **Reviews** itself periodically — distills scattered notes into systematic rules

You do nothing. The agent handles it all. Every session builds on every previous session.

```
Session  1: Agent codes → records 3 bugs, 2 wins → saves to memory
Session  5: Agent loads memory → skips known pitfalls → finds new patterns
Session 10: Agent runs retro → distills 8 rules from 40 entries
Session 50: Agent starts with 50 sessions of accumulated project wisdom
```

## Install

**Claude Code:**
```bash
claude plugin add -- gh:cklxx/compound-engineering
```

**Codex:**
```bash
git clone https://github.com/cklxx/compound-engineering.git ~/.codex/compound-engineering
mkdir -p ~/.agents/skills
ln -s ~/.codex/compound-engineering/skills ~/.agents/skills/compound-engineering
```

**Any agent** — clone the repo and load `skills/using-compound-engineering/SKILL.md` into your agent's system prompt.

**Update:**
```bash
# Claude Code
claude plugin update compound-engineering
# Codex
cd ~/.codex/compound-engineering && git pull
```

## What Happens After Install

The agent does all of this on its own. No commands needed.

### 1. Before non-trivial work — the agent writes a plan

Triggers: new feature, refactor, architecture change, 3+ file modification.

Creates `docs/plans/YYYY-MM-DD-<slug>.md` with goals, task breakdown, technical design, risks, and milestones. References past plans and memory to avoid repeating known mistakes.

### 2. During work — the agent records what happens

Triggers: bug fixed, debugging breakthrough, effective pattern found, pitfall discovered.

Writes structured entries to `docs/error-experience/entries/` (mistakes) or `docs/good-experience/entries/` (wins). Each entry includes root cause, impact, resolution, and a prevention rule.

### 3. After key decisions — the agent saves to memory

Triggers: technical decision made, recurring pattern noticed, high-impact lesson learned.

Persists durable knowledge to `docs/memory/long-term.md` — a curated list of 30-50 items that gets loaded at the start of every session. Details go into topic files under `docs/memory/topics/`.

### 4. When enough accumulates — the agent runs a retro

Triggers: 10+ new entries, milestone completed, 7+ days since last review.

Reads all recent experience, identifies patterns (what keeps going right, what keeps going wrong), distills them into executable rules, and feeds those rules back into memory. Outputs a retro report to `docs/plans/`.

## The Compound Loop

```
  Plan ──→ Code ──→ Record ──→ Remember ──→ Review
   ↑                                          │
   └──────── better plans, fewer mistakes ────┘
```

This is the core mechanism. Each cycle:
- **Plans** get better because memory contains past decisions and pitfalls
- **Records** build the evidence base for future rules
- **Memory** prevents the same mistake from happening twice
- **Reviews** compress raw experience into systematic knowledge

Over time, the agent develops deep, project-specific expertise — automatically.

## Skills Reference

| Skill | Auto-triggers when | Effect |
|-------|-------------------|--------|
| `writing-plans` | Non-trivial work begins | Structured plan with tasks, risks, milestones |
| `recording-practices` | Bug fixed, pattern found, pitfall hit | Experience entry with root cause and prevention rule |
| `managing-memory` | Decision made, durable insight found, session starts | Knowledge persisted to local knowledge base |
| `running-retros` | 10+ entries, milestone done, 7+ days elapsed | Patterns identified, rules distilled, memory updated |
| `using-compound-engineering` | Every session start | Loads memory, discovers skills, bootstraps the loop |

Optional slash commands (`/write-plan`, `/record`, `/retro`) exist for manual invocation, but the skills work fully automatically without them.

## What Gets Created in Your Project

```
docs/
├── plans/                    # Plans and retro reports
├── error-experience/
│   ├── entries/              # Individual bug/pitfall records
│   └── summary/              # Consolidated patterns
├── good-experience/
│   ├── entries/              # Individual win/pattern records
│   └── summary/              # Consolidated patterns
└── memory/
    ├── long-term.md          # 30–50 curated knowledge items (loaded every session)
    └── topics/               # Detailed topic files (loaded on demand)
```

All directories are created automatically on first use.

## Design Principles

- **Fully automatic** — The agent plans, records, remembers, and reviews without being told. If it requires manual effort, it won't happen consistently.
- **Compound, not accumulate** — Raw entries get distilled into rules, rules get loaded into memory, memory gets pruned. Knowledge sharpens over time, not just grows.
- **Evidence-backed rules** — Every rule traces back to concrete experience entries. No arbitrary style preferences.
- **Curated memory** — Active memory stays between 30-50 high-value items. Stale knowledge is archived. Less noise, more signal.

## License

MIT
