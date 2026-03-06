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

This repository now includes a fully configured **Multi-Agent Coding Rig** in the `multi-agent-rig/` directory. This rig sets up a Dockerized autonomous coding team composed of **7 specialized OpenClaw subagents** (Architect, Backend, Frontend, UX, MCP/Infra, QA, Docs) orchestrated by a CEO agent, collaborating seamlessly with a sandboxed **Agent Zero** container for heavy code execution.

Features of the Rig:
- **Skill Auto-Invocation:** Agents autonomously use tools like `run-lighthouse`, `run-unit-tests`, and `spline-export`.
- **Shared Workspace:** Real-time codebase modifications across all agents.
- **Persistent Memory:** ChromaDB vector search and Postgres session storage.
- **Free-Tier LLM support:** Pre-configured for OpenRouter's free tier models.

See the `multi-agent-rig/RUNBOOK.md` for operations and testing instructions.

## 🤕 God-Tier System Upgrades

The setup now includes 5 next-generation architectural upgrades:

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
