# compound-engineering

**An agentic skills framework that makes your AI coding agent write better code over time — automatically.**

Most AI coding sessions start from zero. The agent has no memory of past mistakes, no record of what worked, no awareness of project conventions. Every session repeats the same errors and rediscovers the same solutions.

**compound-engineering** fixes this. It installs a set of skills that teach your AI agent to automatically:

- **Plan** before coding — structured task decomposition, risk assessment, technical design
- **Record** as it works — capture bugs, pitfalls, breakthroughs, and effective patterns
- **Remember** across sessions — persist durable knowledge in a local knowledge base
- **Retrospect** periodically — distill scattered experience into systematic, reusable rules

The result: a **compound interest effect** on engineering quality. Every session builds on all previous sessions. Mistakes are never repeated. Effective patterns are never forgotten.

## How It Works

```
Session 1: Agent plans → codes → records 3 errors, 2 wins → saves to memory
Session 2: Agent loads memory → avoids past mistakes → records new insights
Session 3: Agent runs retro → distills 5 rules → updates memory
Session N: Agent starts with N sessions of accumulated wisdom
```

**The skills are fully automatic.** You don't invoke them manually. The agent detects the right moments to plan, record, remember, and review — then acts on its own.

## Installation

### Claude Code (Plugin)

```bash
claude plugin add -- gh:cklxx/compound-engineering
```

Skills auto-activate on every session via the SessionStart hook.

### Codex

```bash
git clone https://github.com/cklxx/compound-engineering.git ~/.codex/compound-engineering
mkdir -p ~/.agents/skills
ln -s ~/.codex/compound-engineering/skills ~/.agents/skills/compound-engineering
```

### Manual (Any Agent)

Clone the repo and point your agent's skill discovery at the `skills/` directory:

```bash
git clone https://github.com/cklxx/compound-engineering.git
```

Then reference `skills/using-compound-engineering/SKILL.md` in your agent's system prompt or AGENTS.md.

### Update

```bash
# Claude Code
claude plugin update compound-engineering

# Codex
cd ~/.codex/compound-engineering && git pull
```

## Skills

### Core Skills (auto-triggered)

| Skill | Triggers When | What It Does |
|-------|--------------|--------------|
| **writing-plans** | Non-trivial work starts (3+ files, design decisions, new features) | Creates a structured plan with goals, task breakdown, risks, milestones |
| **recording-practices** | Bug fixed, pattern discovered, pitfall encountered, task completed | Writes a structured experience entry (error or success) with root cause and prevention rules |
| **managing-memory** | Technical decision made, durable pattern found, new session starts | Persists knowledge to `docs/memory/long-term.md`; loads context on session startup |
| **running-retros** | 10+ entries accumulated, milestone completed, 7+ days since last retro | Reviews experience, identifies patterns, distills reusable rules, updates memory |

### Meta Skill

| Skill | Purpose |
|-------|---------|
| **using-compound-engineering** | Bootstraps on session start. Loads memory, discovers skills, establishes the compound loop. |

### Optional Slash Commands

These are shortcuts for explicit invocation. The skills work automatically without them.

| Command | Invokes |
|---------|---------|
| `/write-plan <topic>` | writing-plans |
| `/record <event>` | recording-practices |
| `/retro [scope]` | running-retros |

## The Compound Loop

```
writing-plans → Execute → recording-practices → managing-memory → running-retros
      ↑                                                                    │
      └────────────────────────────────────────────────────────────────────┘
```

Each cycle feeds the next:
1. **Plans** prevent aimless coding and scope creep.
2. **Records** capture experience while context is fresh.
3. **Memory** prevents the same mistakes across sessions.
4. **Retros** compound individual lessons into systematic rules.
5. **Better plans** — because now you have memory and rules to build on.

## Directory Structure

After the skills activate, your project will contain:

```
docs/
├── plans/                        # Structured plans (writing-plans)
├── error-experience/
│   ├── entries/                  # Bug reports, pitfalls (recording-practices)
│   └── summary/                  # Consolidated patterns (running-retros)
├── good-experience/
│   ├── entries/                  # Wins, effective patterns (recording-practices)
│   └── summary/                  # Consolidated patterns (running-retros)
└── memory/
    ├── long-term.md              # 30–50 curated knowledge items (managing-memory)
    └── topics/                   # Deep-dive topic files (managing-memory)
```

Directories are created automatically when first needed.

## Philosophy

### Experience Should Compound, Not Evaporate

Every debugging session, every architectural decision, every "aha" moment is valuable. Without a system, these insights evaporate when the session ends. compound-engineering captures them in structured, queryable formats that persist forever.

### Automatic Over Manual

If the agent has to be told when to plan, record, or review, it won't happen consistently. These skills trigger automatically based on context signals — the agent recognizes when planning is needed, when an experience is worth recording, and when enough has accumulated for a retro.

### Rules From Evidence, Not Authority

Every rule in the system traces back to concrete experience entries. "Always check for nil before accessing map values" isn't a style preference — it's backed by entries showing the three times a nil map caused a crash.

### Curated Over Accumulated

Memory is not a landfill. The system actively prunes stale knowledge, archives outdated patterns, and keeps the active memory between 30–50 high-value items. Less noise, more signal.

## License

MIT
