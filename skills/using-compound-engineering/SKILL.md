---
name: using-compound-engineering
description: "Bootstraps compound-engineering on every session. Loads project memory, scans recent experience, and activates the plan→record→remember→review loop."
---

# Using Compound Engineering

You have **compound-engineering** installed. This is your operating protocol.

## What Each Skill Does (and Does NOT Do)

| Skill | Role | Input | Output | Does NOT do |
|-------|------|-------|--------|-------------|
| **writing-plans** | Think before coding | User request + memory | `docs/plans/*.md` | Does not record outcomes or persist knowledge |
| **recording-practices** | Log raw events | Observable engineering event | `docs/{error,good}-experience/entries/*.md` | Does not distill rules or decide what to remember |
| **managing-memory** | Persist distilled knowledge | A verified, durable insight | One line in `docs/memory/long-term.md` | Does not log raw events or analyze patterns |
| **running-retros** | Compress entries into rules | Accumulated entries + git history | Retro report + updated memory + summaries | Does not record new events or write plans |

**The key distinction:**
- `recording-practices` = **raw event log** — high volume, low curation, captures everything notable
- `managing-memory` = **distilled knowledge** — low volume, high curation, only proven durable insights
- `running-retros` = **the compression step** — turns raw entries into curated knowledge

## Session Startup Protocol

On every new session, execute these steps **before responding to the user**:

### 1. Load memory
```
Read docs/memory/long-term.md
→ If it exists, you now have 30–50 curated knowledge items
→ If it doesn't exist, this is a fresh project — create the file on first write
```

### 2. Scan recent experience
```
Read the 3 most recent files in docs/error-experience/entries/
Read the 2 most recent files in docs/good-experience/entries/
→ You now know what went wrong and right recently
```

### 3. Check active plans
```
Read docs/plans/ for any file with "Status: in-progress"
→ If found, you know what work is underway
```

### 4. Rank and retain
```
From steps 1–3, keep the top 8–12 items most relevant to the user's first message
Discard the rest from active context (you can re-read files later if needed)
```

### 5. Acknowledge silently
Do NOT announce that you loaded memory. Just use it. The user should notice better answers, not a loading message.

## Skill Interaction Flow

```
User request arrives
    │
    ├─ Non-trivial? ──→ writing-plans creates plan
    │                        │
    │                        ▼
    ├─ Execute code ◄────────┘
    │       │
    │       ├─ Bug fixed? ──────────→ recording-practices logs error entry
    │       ├─ Pattern found? ──────→ recording-practices logs good entry
    │       ├─ Decision made? ──────→ managing-memory persists to long-term.md
    │       └─ Done
    │
    └─ 10+ new entries? ──→ running-retros distills rules, updates memory
```

## Directory Structure

Create on first use. Never ask the user for permission.

```
docs/
├── plans/                        # writing-plans output
├── error-experience/entries/     # recording-practices output (errors)
├── good-experience/entries/      # recording-practices output (wins)
├── error-experience/summary/     # running-retros output
├── good-experience/summary/      # running-retros output
└── memory/
    ├── long-term.md              # managing-memory output (always loaded)
    └── topics/                   # managing-memory detail files
```
