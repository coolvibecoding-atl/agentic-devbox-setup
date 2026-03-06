# 🚀 Ultimate Agentic DevOps Setup (macOS)

Welcome to the **Ultimate Agentic DevOps Setup** repository! 

This repository contains a robust, one-click bash script (`install.sh`) designed to completely transform a fresh macOS installation into a state-of-the-art 2026 developer workstation, prioritizing autonomous code generation, infrastructure-as-code, and terminal productivity.

## 📦 What's Included?

This script automatically installs over **50+ CLI tools** and **800+ AI Agent Skills** across the following categories:

*   **Core Systems:** Homebrew, Node.js (via NVM), Git
*   **AI & Agentic Coding CLIs:** Gemini CLI, Claude Code, Open-Interpreter, Codex, Cline, OpenClaw, Superpowers, pi-mono
*   **600+ Agentic Skills:** Automatic provisioning of 600+ advanced skills across all CLIs (Vercel, Anthropic, Custom God-Tier).
*   **Cloud & Deployments:** AWS, Vercel, Supabase, Cloudflare Wrangler, Fly.io, Stripe
*   **Next-Gen Databases & Backends:** Convex, Turso
*   **Frontend Production & Design:** Builder.io, v0, Tailwind CLI, SVGO, ImageOptim
*   **Testing & QA:** Playwright, Vitest, Storybook, Lighthouse, Axe
*   **Terminal Power Tools:** Warp, OrbStack, yazi, btop, eza, zoxide, starship, zellij, nushell, qmd
*   **Modern Runtimes & Toolchains:** Bun, Deno, pnpm, Biome

## 🤖 Multi-Agent Coding Rig (Agent Zero + OpenClaw)

This repository now includes a fully configured **Multi-Agent Coding Rig** in the `multi-agent-rig/` directory. 

Features of the Rig:
- **7 Specialized Subagents** (Architect, Backend, Frontend, UX, MCP/Infra, QA, Docs) led by a Kimi 2.5 CEO.
- **Shared Workspace:** Real-time codebase modifications across all agents.
- **Persistent Memory:** ChromaDB vector search and a **PAI Memory Hub** (JSON sidecar) for cross-session long-term memory.
- **Dual-Lane Routing:** Combines OpenRouter's free tier with precise Claude Code Pro bounds.

## 🤕 Epic System Upgrades (2026 Edition)

The setup currently features cutting-edge system refinements:

1. **Cinematic Landing Page Engine:** `GEMINI.md` fused globally, giving Antigravity automatic design-studio output.
2. **Kimi 2.5 Apex Orchestrator:** CEO logic powered by `moonshotai/kimi-k2.5`.
3. **Local Failover:** Maps to `ollama/qwen2.5-coder:32b` or `deepseek-r1:32b` on 96GB RAM local rigs.
4. **Perplexity Sonar Pro Integration:** `web-research` skill dynamically fetching real-time citations.
5. **Universal Pre-Commit Guardian:** `scripts/install-precommit.sh` outright bans failing tests/lints from Git history.
6. **Telemetry Dashboard:** Tracks LLM API invocations.
7. **Context Squeezing:** `scripts/context-compressor.js` reclaims VRAM in multi-hour sessions.
8. **Visual QA:** `scripts/visual-qa.sh` runs Playwright screenshots through Gemini for UI defect identification.
9. **Temporal.io Durable AI:** Handles extreme refactoring sessions.
10. **Self-Healing CI/CD**: Auto-triggers the backend-senior agent to patch code if GitHub Actions fail.
11. **Voice Briefings**: ElevenLabs audio alerts trigger on critical pipeline failures.

### 🧠 Phase 15: Sentient Infrastructure
12. **Agent DNA Fingerprinting**: (`agent-dna-fingerprint.js`) Auto-generates leaderboards based on success rates and dynamically flags models for upgrades.
13. **Hot-Swap Model Routing**: (`hot-swap-router.js`) Polls OpenRouter for new Apex models (like Claude 4, GPT-5) and hot-swaps them into `openclaw.json` with zero downtime.
14. **Project-Aware Context Switching**: (`workspace-switcher.sh`) Safely pauses graph/vector memory, swaps the workspace symlink, and restarts indexers for instant multi-project context.
15. **Stakeholder Sprint Reporter**: (`sprint-reporter.js`) Auto-generates polished `SPRINT_REPORT.md` digests every Friday at 6 PM via the `docs-narrator` agent.
16. **Satellite Agents**: (`satellite-launcher.sh`) Provisions temporary GPU nodes in the cloud, runs heavy ML tasks, syncs artifacts, and terminates instances autonomously.
17. **Secret Vault Integration**: (`vault-fetch.sh`) Fetches API keys securely via 1Password CLI (`op`), preventing hardcoded credentials in files.
18. **Design-to-Code Vision Pipeline**: (`figma-to-react.sh`) Uses Anthropic Computer Use to grab Figma geometries and synthesis React components via Gemini Vision.

### 🧊 Phase 18: 3D Visualization Engines
19. **Blender Headless Pipeline**: (`blender-mcp`) A native MCP server allowing agents to write Python scripts that silently spin up Blender, procedurally generate meshes, and export `.glb` files for web.
20. **Spline React Integration**: (`spline-mcp`) An MCP server for automatically framing Spline URLs into responsive `@splinetool/react-spline` React components.

### 🎥 Phase 19: Advanced 3D Web Integration
21. **React Three Fiber Architect**: (`r3f-architect`) Code-gen tool that wraps raw `.glb` files in complex `@react-three/fiber` canvases.
22. **Luma AI NeRFs**: (`luma-mcp`) Agent-driven API integration to turn mp4 videos of real-world objects into `.glb` 3D meshes using Neural Radiance Fields.
23. **Autonomous Draco Compression**: (`gltf-draco-compressor`) Pipeline script utilizing Google's Draco engine to compress `.glb` files by 90% without losing quality.
24. **Rive Interactivity**: (`rive-mcp`) Code generator bridging the new Rive 2D state-machine animation system into React.
25. **GSAP DOM Injector**: (`gsap-animator`) Weaves `gsap.context()` scroll-triggers directly into flat React components for cinematic UX.

| Skill | Description |
|---|---|
| `magentic-one-orchestrator` | Microsoft Magentic-One multi-agent hierarchy — prevents agent loops in multi-hour tasks |
| `mcp-unified-connector` | MCP universal bus — all 800+ skills natively read/write VS Code, Postgres, Redis, cloud APIs |
| `self-healing-pipeline` | Autonomous CI/CD repair — detects failures, writes the fix, pushes a PR |
| `speckit-spec-guardian` | Spec-First enforcement — agents must satisfy SPEC.md before committing |
| `pai-memory-hub` | Centralized LangGraph memory — rig remembers decisions across all projects |

## 📚 800+ AI Agent Skills Installed

| Category | Count | Source |
|---|---|---|
| Core backup library | 563 | github.com/404kidwiz/claude-skills-backup |
| SEO & GEO optimization | 20 | aaron-he-zhu/seo-geo-claude-skills |
| Scientific Deep Research | 14 | luwill/research-skills |
| Medical/Clinical Bio-RAG | 12 | K-Dense-AI/claude-scientific-skills |
| X/Twitter & Polymarket Data | 18 | neokahu/x-research-skill & openapexmarket |
| Financial Analyst OS | 21 | Bigdata-com/skills-financial-research-analyst |
| Competitive Intelligence | 11 | damionrashford/RivalSearch-Plugin |
| Design & Agency Tooling | 19 | designagentlab/skills |
| App Store Optimization | 17 | Eronred/aso-skills |
| Trail of Bits security | 35 | trailofbits/skills |
| Scientific research | 31 | K-Dense-AI/claude-scientific-skills |
| Research & writing | 3 | luwill/research-skills |
| Vercel (React, Next.js) | 5 | vercel-labs/agent-skills |
| Custom God-Tier | 17 | Generated locally |
| Community extras | 60+ | Various |

**All skills are installed simultaneously into:** Gemini CLI, Claude Code, Codex, Kilo Code, OpenCode, and OpenClaw.

## ⚡ How to Run

1.  Clone this repository to your local machine:
    ```bash
    git clone https://github.com/yourusername/agentic-devbox-setup.git
    cd agentic-devbox-setup
    ```
2.  Make the script executable:
    ```bash
    chmod +x install.sh
    ```
3.  Run the installation script:
    ```bash
    ./install.sh
    ```
4.  Follow the interactive prompts (e.g., Xcode Command Line Tools, sudo password).

## 📖 Complete Tool Documentation

For a comprehensive guide on **how to use** each of these 53 tools, including API key configuration, installation verification, and daily command workflows, please refer to the detailed [USAGE_GUIDE.md](./USAGE_GUIDE.md) included in this repository.

## ⚙️ Post-Installation Manual Steps

While the script handles the heavy lifting, a few manual steps remain:
1.  **Restart your terminal** or run `source ~/.zshrc`.
2.  **Launch OrbStack** and **Warp** from your Applications folder to initialize them.
3.  **Configure API Keys** for the LLM providers (Anthropic, Google, OpenAI, etc.) as detailed in the Usage Guide.

## 🤝 Contributing

Feel free to open a PR if a new indispensable 2026 dev tool hits the market!
