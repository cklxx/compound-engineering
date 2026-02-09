# compound-engineering

**Install once. Your AI coding agent automatically learns from every session — it plans before coding, records mistakes and wins, builds persistent memory, and reviews itself. Code quality compounds over time, on autopilot.**

---

## The Problem

Every AI coding session starts from zero. The agent forgets past bugs, re-discovers the same solutions, repeats the same mistakes. Session 100 is no smarter than session 1.

## The Fix

compound-engineering installs a set of skills into your AI agent. Once installed, the agent **automatically** plans, records, remembers, and reviews — building project-specific expertise that persists across sessions and sharpens over time.

```
Session  1: Agent codes → hits 3 bugs → records root causes → saves to memory
Session  5: Agent loads memory → avoids past bugs → discovers new patterns → records them
Session 10: Agent runs retro → distills 8 rules from 40 entries → updates memory
Session 50: Agent starts with 50 sessions of accumulated wisdom, codes accordingly
```

## One-Line Install

Works for **both Claude Code and Codex** on any machine:

```bash
curl -fsSL https://raw.githubusercontent.com/cklxx/compound-engineering/main/install.sh | bash
```

That's it. The script:
1. Clones the skills repo to `~/.compound-engineering/`
2. Symlinks skills into `~/.claude/skills/` (Claude Code) and `~/.agents/skills/` (Codex)
3. Registers a SessionStart hook so skills auto-load on every session
4. Links optional `/write-plan`, `/record`, `/retro` slash commands

Both Claude Code and Codex will have full access to all skills from the next session.

<details>
<summary><b>Manual install / advanced options</b></summary>

**Claude Code only:**
```bash
git clone https://github.com/cklxx/compound-engineering.git ~/.compound-engineering
ln -s ~/.compound-engineering/skills ~/.claude/skills/compound-engineering
```

**Codex only:**
```bash
git clone https://github.com/cklxx/compound-engineering.git ~/.compound-engineering
mkdir -p ~/.agents/skills
ln -s ~/.compound-engineering/skills ~/.agents/skills/compound-engineering
```

**Update:**
```bash
cd ~/.compound-engineering && git pull
```

**Uninstall:**
```bash
bash ~/.compound-engineering/uninstall.sh
```
</details>

---

## How the Automatic Learning Actually Works

This is not magic. Here is the exact technical mechanism, step by step.

### Step 1: Session starts → agent loads its "brain"

When a Claude Code or Codex session starts, the **SessionStart hook** fires (`hooks/session-start.sh`). This hook reads `skills/using-compound-engineering/SKILL.md` and injects it into the agent's context.

That skill contains explicit instructions:

```
On every new session, you MUST:
1. Read docs/memory/long-term.md if it exists.
2. Scan the 3–5 most recent entries in docs/error-experience/entries/ and docs/good-experience/entries/.
3. Check docs/plans/ for in-progress plans.
4. Rank and retain the top 8–12 most relevant items as active context.
```

The agent now has project-specific knowledge loaded. It knows what went wrong before, what decisions were made, what patterns work.

### Step 2: Work begins → agent plans automatically

The `writing-plans` skill has trigger patterns:

```yaml
triggers:
  intent_patterns:
    - "plan|design|architecture|refactor|implement|feature"
```

When the user's request matches these patterns (new feature, refactor, architecture change), the agent recognizes it should plan first. It:

1. Reads `docs/memory/long-term.md` for relevant past knowledge
2. Checks `docs/plans/` for related past plans
3. Writes a structured plan to `docs/plans/YYYY-MM-DD-<slug>.md`
4. Includes task breakdown, technical design, risks, milestones

**Why this improves over time:** On session 1, the plan has no history. By session 10, the agent references past plans, avoids approaches that failed before, and applies rules from previous retros.

### Step 3: During coding → agent records experiences

The `recording-practices` skill has trigger patterns:

```yaml
triggers:
  intent_patterns:
    - "bug|error|fix|anti.?pattern|best.?practice"
```

When the agent fixes a bug, hits a pitfall, or discovers an effective pattern, it automatically writes a structured record:

- **Error** → `docs/error-experience/entries/YYYY-MM-DD-<slug>.md` with: what happened, root cause, resolution, prevention rule
- **Win** → `docs/good-experience/entries/YYYY-MM-DD-<slug>.md` with: what worked, why it worked, how to reproduce

These are real files in your project repo. They accumulate over sessions.

### Step 4: Durable insight → agent saves to memory

The `managing-memory` skill triggers when a technical decision is made or a high-impact pattern is discovered. It evaluates:

- Will this be useful in 2+ weeks?
- Is it a pattern or decision (not a one-off fix)?
- Would forgetting it cause repeated mistakes?

If yes, it appends a one-line entry to `docs/memory/long-term.md`:

```markdown
### Known Pitfalls
- [2026-02-09] Never use sync.Mutex in hot path of request handler — use sync.RWMutex instead. Caused 3x latency spike (see error-experience/2026-02-09-mutex-latency.md)
```

This file is loaded on every session start (Step 1). That's how knowledge persists.

### Step 5: Enough accumulates → agent runs retrospective

The `running-retros` skill triggers when:
- 10+ new experience entries exist without a summary
- A plan reaches `completed` status
- 7+ days pass since the last retro

The agent:
1. Reads all recent entries and git history
2. Identifies **patterns** — what keeps recurring (good or bad)
3. Distills patterns into **executable rules** (not vague advice):
   ```
   Rule: Run go vet before every commit
   Trigger: About to commit Go code
   Evidence: error-experience entries 02-03, 02-05, 02-07 all caught by go vet
   ```
4. Writes high-value rules back to `docs/memory/long-term.md`
5. Creates summary files in `docs/{error,good}-experience/summary/`
6. Archives stale memory items (keeps active memory at 30–50 items)

### The Compound Effect

This is where "compound" happens:

```
Session 1:  memory = 0 items, entries = 0
            → agent records 5 entries, saves 2 to memory

Session 5:  memory = 8 items, entries = 20
            → agent avoids 3 known pitfalls, records 4 new entries

Session 10: memory = 12 items, entries = 40
            → retro runs: distills 8 rules, prunes 3 stale items
            → memory = 17 items (sharper, more systematic)

Session 50: memory = 40 items (curated), entries = 150, summaries = 8
            → agent has deep project expertise
            → plans reference past failures, applies proven patterns
            → new mistakes are rare, fixes are fast
```

Each session reads from all prior sessions. Each retro compresses raw data into rules. Rules make future sessions better. This is compound interest applied to engineering knowledge.

---

## Skills Reference

| Skill | Auto-triggers when | Effect |
|-------|-------------------|--------|
| `using-compound-engineering` | Every session start | Loads memory, discovers skills, bootstraps the loop |
| `writing-plans` | Non-trivial work begins | Structured plan with tasks, risks, milestones |
| `recording-practices` | Bug fixed, pattern found, pitfall hit | Experience entry with root cause and prevention rule |
| `managing-memory` | Decision made, durable insight found | Knowledge persisted to `docs/memory/long-term.md` |
| `running-retros` | 10+ entries, milestone done, 7+ days elapsed | Patterns identified, rules distilled, memory updated |

Optional slash commands (`/write-plan`, `/record`, `/retro`) exist for manual invocation, but everything works automatically without them.

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
    ├── long-term.md          # 30–50 curated items (loaded every session)
    └── topics/               # Detailed topic files (loaded on demand)
```

All directories are created automatically on first use. These are plain markdown files in your repo — version controlled, human readable, portable.

## License

MIT
