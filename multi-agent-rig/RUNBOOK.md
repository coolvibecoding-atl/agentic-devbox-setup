# Multi-Agent Coding Rig — Operations Runbook

> Your complete guide to running, using, extending, and debugging the OpenClaw + Agent Zero multi-agent stack.

---

## Quick Start

```bash
# 1. Clone/enter the rig directory
cd /Users/coolvibecoding/agentic-devbox-setup/multi-agent-rig

# 2. Copy and fill in environment variables
cp .env.example .env
# → Edit .env: add your OPENROUTER_API_KEY (free at openrouter.ai)

# 3. Start the full stack
make up

# 4. Watch the logs
make logs
```

When ready, OpenClaw (the CEO) will be listening at `http://localhost:18789`.

---

## Architecture Overview

```
YOU (Telegram / CLI)
       │
       ▼
  [OpenClaw CEO]           ← Routes tasks, enforces quality gates
       │
   ┌───┴──────────────────────────────────────────────────┐
   │                                                       │
   ▼                                                       ▼
arch-director         ←── writes ADRs ──→ docs-narrator
backend-senior        ←── delegates  ──→ agent-zero-coder
frontend-lead         ←── delegates  ──→ agent-zero-coder
ux-creative           ←── specs      ──→ mcp-integrations
mcp-integrations      ←── assets     ──→ frontend-lead
qa-guardian           ←── triggered by every git-commit ──→
docs-narrator         ←── triggered on every feature completion ──→
```

All agents share `/workspace/project` via a Docker volume.  
ChromaDB provides semantic code search (`code-search` skill).  
Postgres stores task history and session logs.

---

## How to Add a New Feature

1. **Send task to CEO (OpenClaw main agent):**
   > "Build a user authentication module with email/password login, JWT tokens, and a protected `/me` endpoint"

2. **CEO auto-orchestrates:**
   - → `arch-director`: produces ADR
   - → `ux-creative`: produces design spec (if UI involved)
   - → `mcp-integrations`: prepares assets (if 3D/media involved)
   - → `backend-senior`: implements API (delegates to Agent Zero if complex)
   - → `frontend-lead`: implements UI
   - → `qa-guardian`: runs full quality gate (auto-triggered on every commit)
   - → `docs-narrator`: updates all docs (auto-triggered on completion)

3. **No manual intervention needed** — skill triggers fire automatically.

---

## How to Add a New Skill

1. **Add the skill definition to `skills/registry.yml`:**
```yaml
my-new-skill:
  type: cli           # or: http, filesystem, vector_db
  command: "npx my-tool {input}"
  description: "What this skill does"
  bound_to: [backend-senior, qa-guardian]  # which agents can call it
```

2. **Create a wrapper script** in `skills/scripts/` if needed:
```bash
#!/usr/bin/env bash
# skills/scripts/my-new-skill.sh
npx my-tool "$@"
```

3. **Update the relevant subagent's system prompt** (in OpenClaw UI) to include the new skill in its BOUND SKILLS list.

4. **Restart OpenClaw:**
```bash
make restart
# or: openclaw gateway restart
```

---

## How to Add a New Subagent

```bash
# Register the new agent in OpenClaw
openclaw agents add my-new-agent \
  --non-interactive \
  --model "openrouter/deepseek/deepseek-coder-v2:free" \
  --workspace ~/.openclaw/workspace

# Open OpenClaw UI to set the system prompt
openclaw configure
```

Then in `skills/registry.yml`, add your agent's name to the `bound_to` lists for the skills it needs.

---

## How to Swap Models

Edit `.env` and change the relevant model variable:

```bash
# Example: switch backend-senior to a better free model
BACKEND_LLM_MODEL=qwen/qwen-2.5-coder-32b-instruct:free
```

Then restart:
```bash
make restart
```

Or swap a specific agent at runtime via OpenClaw config:
```bash
openclaw config set agents.backend-senior.model.primary "openrouter/qwen/qwen-2.5-coder-32b-instruct:free"
openclaw gateway restart
```

---

## How to Debug a Skill Failure

1. **Check OpenClaw logs:**
```bash
openclaw logs --follow
# or
make logs
```

2. **Identify the failing skill** in the log output (look for `skill invocation failed`).

3. **Test the skill directly:**
```bash
# For CLI skills — run the command manually in the container
make shell-openclaw
npx biome check src/modules/auth/service.ts
```

4. **Check Agent Zero:**
```bash
make shell-a0
curl http://localhost:8080/health
```

5. **Check ChromaDB:**
```bash
curl http://localhost:8001/api/v1/heartbeat
```

6. **Check rate limits:**
```bash
openclaw message send --channel telegram --target YOUR_ID --message "/openrouter-status"
# Or query directly:
curl -H "Authorization: Bearer $OPENROUTER_API_KEY" https://openrouter.ai/api/v1/auth/key
```

---

## How to Evolve the Architecture

As the project grows, the skill registry and agent prompts are the two levers:

| Growth scenario | What to change |
|---|---|
| New language/framework needed | Update agent system prompts with new conventions |
| New tool (Docker, k8s, etc.) | Add skill to `registry.yml` + wire to mcp-integrations |
| New quality gate | Add skill to qa-guardian's system prompt + trigger rules |
| Larger codebase, slower search | Add more ChromaDB collections, split by domain |
| Need persistent memory | Configure `agents.defaults.memorySearch` in `openclaw.json` |
| Better free models released | Update `.env` model vars + `make restart` |

---

## Service URLs (Local Dev)

| Service | URL |
|---|---|
| OpenClaw Gateway | http://localhost:18789 |
| Agent Zero API | http://localhost:8080 |
| ChromaDB | http://localhost:8001 |
| Postgres | localhost:5433 |

---

## Directory Layout

```
multi-agent-rig/
├── docker-compose.yml      ← Full stack definition
├── .env.example            ← Environment template (copy to .env)
├── Makefile                ← Operational commands
├── skills/
│   ├── registry.yml        ← Master skill registry
│   └── scripts/            ← CLI skill wrapper scripts
├── workspace-indexer/      ← ChromaDB sync service
│   ├── index.js
│   └── package.json
├── scripts/
│   └── init-db.sql         ← Postgres schema
└── workspace/
    └── project/            ← Shared code workspace (Docker volume)
        ├── src/
        │   ├── modules/    ← Backend modules (Feature-Sliced)
        │   ├── app/        ← Next.js app directory
        │   ├── components/ ← Shared UI components
        │   └── lib/        ← Shared utilities
        ├── assets/
        │   ├── spline/     ← Spline 3D scenes
        │   ├── blender/    ← Blender source files
        │   └── exports/    ← Web-ready exports
        ├── docs/
        │   ├── adr/        ← Architecture Decision Records
        │   ├── api/        ← Auto-generated API docs
        │   └── design/     ← Design specs (ux-creative)
        └── tests/          ← All test files
```
