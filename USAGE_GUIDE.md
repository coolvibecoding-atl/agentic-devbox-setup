# 🛠️ Complete CLI Tools Installation & Usage Guide
### March 2026 — Agentic Coding & Developer Productivity Tools

> **Prerequisites:** Homebrew, Node.js 20+, Python 3.10+

---

## 📦 Quick Install — All Tools At Once

```bash
# 1. Install Homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. Add brew to PATH (Intel Mac)
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile && eval "$(/usr/local/bin/brew shellenv)"

# 3. Install Node.js
brew install node

# 4. Install npm-based AI coding agents
npm install -g @google/gemini-cli
npm install -g @openai/codex
npm install -g @anthropic-ai/claude-code
npm install -g @kilocode/cli
npm install -g opencode-ai
npm install -g codebuff
npm install -g cline
npm install -g @qwen-code/qwen-code

# 5. Install brew-based tools
brew install gh ollama nushell starship eza bat zoxide httpie
brew tap charmbracelet/tap && brew install charmbracelet/tap/crush
brew tap steipete/tap && brew install steipete/tap/gogcli

# 6. Install gcloud SDK
brew install --cask google-cloud-sdk

# 7. Install Kimi Code CLI (Python-based)
pip3 install kimi-code-cli
```

---

## 🤖 Agentic Coding Tools

---

### 1. 🌟 Gemini CLI — Google's Terminal AI Agent

**Install:**
```bash
npm install -g @google/gemini-cli
```

**Auth Setup:**
```bash
gemini auth login          # Authenticates with your Google account (free tier available)
# OR set API key:
export GEMINI_API_KEY="your_key_here"
```

**Key Commands:**
```bash
gemini                          # Start interactive session
gemini "explain this codebase"  # One-shot prompt
gemini -p "refactor auth.js"    # Non-interactive with prompt
gemini --model gemini-2.5-pro   # Use specific model
```

**Usage Examples:**
```bash
# Ask about your codebase
cd my-project && gemini "what does this repo do and how is it structured?"

# Generate code
gemini "create a REST API with Express.js and Prisma for a todo app"

# Debug code
gemini "debug this error: $(cat error.log)"

# Multi-file refactoring
gemini "refactor all components to use TypeScript strict mode"
```

**Tips:**
- Free tier: 60 requests/min with personal Google account
- Use `gemini --sandbox` for safe code execution in an isolated environment
- Add `GEMINI_SANDBOX=true` to your shell env to always run sandboxed
- Supports Gemini 2.5 Pro/Flash; Flash is faster for quick questions

---

### 2. 🚀 OpenAI Codex CLI — Agent-Native Coding Platform

**Install:**
```bash
npm install -g @openai/codex
```

**Auth Setup:**
```bash
export OPENAI_API_KEY="sk-..."    # From platform.openai.com
# OR link your ChatGPT Plus subscription:
codex auth login
```

**Key Commands:**
```bash
codex                                    # Interactive REPL
codex "add unit tests for auth.ts"       # One-shot task
codex --approval-mode full-auto "..."    # Fully autonomous (no approval prompts)
codex --model o3                         # Use o3 for hard problems
codex --model codex-mini-latest "..."    # Fast & cheap
```

**Usage Examples:**
```bash
# Plan and implement a feature end-to-end
codex "implement OAuth2 login with GitHub for my Next.js app"

# Fix a bug
codex "the tests in src/__tests__ are failing, find and fix the issue"

# Understand a codebase
codex "give me an architecture overview of this repo"

# Run with full autonomy
codex --approval-mode full-auto "add Stripe payment integration"
```

**Approval Modes:**
| Mode | Description |
|------|-------------|
| `suggest` | Shows diffs, you approve each change |
| `auto-edit` | Applies file edits, asks before running commands |
| `full-auto` | Fully autonomous — runs everything |

**Tips:**
- Use `o3` model for complex multi-file tasks; `codex-mini` for quick fixes
- Set `CODEX_DISABLE_PROJECT_DOC=1` to skip reading AGENTS.md
- Create `AGENTS.md` in your repo to give Codex context about your project

---

### 3. 🧠 Claude Code — Anthropic's Terminal Agent

**Install:**
```bash
npm install -g @anthropic-ai/claude-code
```

**Auth Setup:**
```bash
export ANTHROPIC_API_KEY="sk-ant-..."   # From console.anthropic.com
# OR use interactive login:
claude auth login
```

**Key Commands:**
```bash
claude                              # Start interactive session
claude "fix all TypeScript errors"  # One-shot command
claude --continue                   # Continue previous conversation
claude --resume [session-id]        # Resume specific session
claude --model claude-opus-4-6      # Use specific model
```

**Usage Examples:**
```bash
# Complex debugging
claude "there's a race condition in my WebSocket handler — find and fix it"

# Full feature implementation
claude "implement a real-time collaboration feature using Yjs and WebSockets"

# Code review
claude "review my PR diff: $(git diff main)"

# Refactor
claude "refactor this codebase to use dependency injection instead of singletons"

# Create tests
claude "write comprehensive tests for all untested functions in src/"
```

**CLAUDE.md — Project Context File:**
```bash
# Create a CLAUDE.md in your project root to give Claude persistent context:
cat > CLAUDE.md << 'EOF'
# Project Context
- Stack: Next.js 15, TypeScript, PostgreSQL, Prisma
- Testing: Vitest + Playwright
- Style: ESLint + Prettier, functional components only
- Never use class components or var
EOF
```

**Tips:**
- Best for: complex reasoning, multi-file refactors, debugging hard issues
- Use `claude --no-tools` for pure Q&A without file access
- `claude /compact` in session to compress history and save tokens

---

### 4. ⚡ Kilo Code CLI — 500+ Model Support

**Install:**
```bash
npm install -g @kilocode/cli
```

**Auth Setup:**
```bash
kilo                    # Opens TUI; use /connect to configure providers
# Or set env variables:
export ANTHROPIC_API_KEY="sk-ant-..."
export OPENAI_API_KEY="sk-..."
```

**Key Commands:**
```bash
kilo                              # Start TUI
kilo "implement feature X"        # One-shot
kilo /connect                     # Configure AI provider
kilo /model claude-opus-4-6       # Switch model
kilo /history                     # View session history
```

**Usage Examples:**
```bash
# Use with 500+ models
kilo --model deepseek/deepseek-coder "optimize this SQL query"

# Multi-file editing
kilo "create a complete authentication system with JWT and refresh tokens"

# Use cheapest model for simple tasks
kilo --model groq/llama-3.1-8b "add docstrings to this function"
```

**Provider Configuration:**
Kilo Code supports: Anthropic, OpenAI, Google, Deepseek, Groq, Ollama (local), AWS Bedrock, Azure OpenAI, and 490+ more via OpenRouter.

**Tips:**
- Built on OpenCode's open-source foundation
- Use `/connect openrouter` to get access to 500+ models with one API key
- Kilo Code 1.0 launched early 2026 with workflow templates

---

### 5. 💻 OpenCode CLI — Open-Source Claude Code Alternative

**Install:**
```bash
npm install -g opencode-ai
# OR via Homebrew:
brew install opencode-ai
# OR via install script:
curl -fsSL https://opencode.ai/install | bash
```

**Auth Setup:**
```bash
opencode auth                # Configure API keys interactively
export ANTHROPIC_API_KEY=""  # Or any supported provider key
```

**Key Commands:**
```bash
opencode                           # Launch TUI
opencode run "task description"    # Non-interactive task
opencode --provider openai "..."   # Use specific provider
opencode session list              # List saved sessions
opencode session resume [id]       # Resume a session
```

**Usage Examples:**
```bash
# Understand a new codebase
opencode "I just cloned this repo. Explain the architecture to me."

# Autonomous task execution
opencode run "add pagination to all list API endpoints"

# Provider-agnostic — switch freely
opencode --provider google "generate a landing page component"
```

**Tips:**
- Fully MIT-licensed — no vendor lock-in
- Built-in LSP support for better code intelligence
- Runs locally; no telemetry or data collection

---

### 6. 🔧 Codebuff — Deep Codebase Understanding Agent

**Install:**
```bash
npm install -g codebuff
```

**Auth Setup:**
```bash
codebuff                        # First run prompts for API key setup
export CODEBUFF_API_KEY="..."   # Or set directly
```

**Key Commands:**
```bash
codebuff                              # Start in current directory
codebuff "refactor the data layer"    # Direct task
codebuff --diff                       # Show what changed
codebuff --dry-run "..."              # Preview changes only
```

**Usage Examples:**
```bash
cd my-project
codebuff "migrate from CommonJS to ES modules throughout the project"
codebuff "find all places we're not handling errors properly and fix them"
codebuff "add TypeScript strict mode and fix all resulting type errors"
```

**Tips:**
- Multi-agent architecture makes precise multi-file changes
- Great for large-scale refactors across entire repositories
- Understands project context deeply before making changes

---

### 7. 🤖 Cline CLI — Autonomous Open-Source Agent

**Install:**
```bash
npm install -g cline
```

**Auth Setup:**
```bash
cline auth            # Connect to your preferred AI provider
# Supports: Claude, GPT, Gemini, DeepSeek, Ollama (local), and more
```

**Key Commands:**
```bash
cline                           # Start interactive session
cline "build a REST API"        # Direct task
cline --model deepseek-coder    # Use specific model
cline --approve-all "..."       # Auto-approve all actions
cline history                   # View past sessions
```

**Usage Examples:**
```bash
# Full stack feature
cline "create a complete user authentication system with email verification"

# With browser use
cline "look at the Stripe docs and implement their Payment Intents API"

# With local model (free!)
cline --model ollama/qwen2.5-coder "add unit tests for all service files"
```

**Tips:**
- Requires explicit approval for each action (file edits, terminal commands) by default
- Use `--approve-all` only in sandboxed environments
- Works great with DeepSeek for cost efficiency (~$0.001/task)
- VS Code extension available at `vscode.dev/cline`

---

### 8. 🇨🇳 Kimi Code CLI — Moonshot AI Agent

**Install:**
```bash
pip3 install kimi-code-cli
# OR with uv (faster):
uv tool install kimi-code-cli
```

**Auth Setup:**
```bash
# Get API key from platform.moonshot.cn
export MOONSHOT_API_KEY="your_key"
kimi-code setup                    # Interactive setup
```

**Key Commands:**
```bash
kimi-code                           # Start interactive chat
kimi-code "explain this codebase"   # One-shot
kimi-code --model kimi-k2.5        # Use K2.5 model
kimi-code --browser                 # Launch browser UI
```

**Usage Examples:**
```bash
# Long context tasks (K2.5 handles huge codebases)
kimi-code "analyze all files in src/ and create an architecture diagram"

# Vision-based coding (K2.5 feature)
kimi-code "look at this screenshot and implement the UI you see" --image design.png

# Multi-agent swarm
kimi-code --swarm "build a complete e-commerce backend"
```

**Tips:**
- Kimi K2.5 (open-sourced Jan 2026) has native multimodal + agent swarm capabilities
- Strong on long-context tasks (200K+ token context)
- Compatible with OpenAI API format — use in any OpenAI-compatible tool

---

### 9. 🐉 Qwen Code CLI — Alibaba's Gemini CLI Fork

**Install:**
```bash
npm install -g @qwen-code/qwen-code
# OR brew:
brew install qwen-code
# OR quick install script:
curl -fsSL https://qwen-code-assets.oss-cn-hangzhou.aliyuncs.com/installation/install-qwen.sh | bash
```

**Auth Setup:**
```bash
qwen auth               # Interactive OAuth (1000 free requests/day!)
# OR with API key:
export QWEN_API_KEY="your_alibaba_cloud_key"
```

**Key Commands:**
```bash
qwen                              # Start interactive mode
qwen "refactor this module"       # Direct task
qwen --model qwen3-coder-plus     # Specify model
qwen --version                    # Check version
```

**Usage Examples:**
```bash
# Free tier — 1000 requests/day via OAuth
qwen auth && qwen "review my code and suggest improvements"

# Multi-file changes
qwen "migrate this Express.js app to Fastify"

# Code generation with Qwen3-Coder
qwen "write a WebSocket server with rooms and real-time messaging"
```

**Tips:**
- Forked from Gemini CLI — same great UX
- OAuth gives **1000 free requests/day** without needing an API key
- Qwen3-Coder is among the top-ranked coding models on HumanEval
- Also supports OpenAI/Anthropic/Gemini APIs

---

## 🖥️ CLI & Developer Productivity Tools

---

### 10. ☁️ gcloud CLI — Google Cloud Command Line

**Install:**
```bash
brew install --cask google-cloud-sdk
# Then initialize:
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
```

**Auth Setup:**
```bash
gcloud auth login                    # Browser-based OAuth login
gcloud config set project PROJECT_ID # Set your default project
gcloud auth application-default login # For local dev credentials
```

**Key Commands:**
```bash
gcloud projects list                       # List all projects
gcloud compute instances list              # List VMs
gcloud run deploy SERVICE --image IMAGE    # Deploy to Cloud Run
gcloud functions deploy NAME --runtime nodejs20  # Deploy Cloud Function
gcloud storage ls                          # List GCS buckets
gcloud ai models list                      # List Vertex AI models
```

**Usage Examples:**
```bash
# Deploy a container to Cloud Run
gcloud run deploy my-api \
  --image gcr.io/my-project/my-api:latest \
  --region us-central1 \
  --allow-unauthenticated

# Query BigQuery
bq query --use_legacy_sql=false 'SELECT COUNT(*) FROM `project.dataset.table`'

# Deploy Cloud Function
gcloud functions deploy helloWorld \
  --runtime=nodejs20 \
  --trigger-http \
  --allow-unauthenticated

# Use Gemini AI on Vertex
gcloud ai models list --region=us-central1
```

**Tips:**
- Run `gcloud cheat-sheet` for a quick reference card
- Use `gcloud config configurations create dev/prod` to manage multiple envs
- `gcloud alpha` and `gcloud beta` have cutting-edge features

---

### 11. 🐙 GitHub CLI (`gh`) — GitHub in Your Terminal

**Install:**
```bash
brew install gh
```

**Auth Setup:**
```bash
gh auth login    # Interactive — choose GitHub.com and browser auth
```

**Key Commands:**
```bash
gh repo create my-app --public        # Create repo
gh pr create --title "feat: add auth" # Create PR
gh issue create --title "Bug: crash"  # Create issue
gh pr checkout 123                     # Checkout PR locally
gh run list                            # List Actions runs
gh run watch                           # Watch running workflow
gh copilot suggest "delete all pods"   # AI command suggestions
gh copilot explain "kubectl get pods"  # Explain shell commands
```

**Usage Examples:**
```bash
# Complete PR workflow
gh pr create --fill --draft
gh pr review --approve
gh pr merge --squash

# AI-assisted commands (GitHub Copilot CLI)
gh copilot suggest "how do I undo my last commit"
gh copilot suggest "tar the src folder and exclude node_modules"
```

**Tips:**
- `gh copilot suggest` is the star feature — natural language → shell commands
- Set up aliases: `gh alias set prc 'pr create --fill'`
- Use `gh api` to hit any GitHub REST/GraphQL endpoint

---

### 12. 🦙 Ollama — Run Local LLMs

**Install:**
```bash
brew install ollama
# Then start the server:
ollama serve
```

**Key Commands:**
```bash
ollama pull qwen2.5-coder:7b        # Pull a model
ollama pull deepseek-coder-v2       # Pull DeepSeek Coder
ollama run llama3.3                 # Run interactively
ollama list                         # List downloaded models
ollama ps                           # Show running models
ollama rm model-name                # Remove a model
```

**Usage Examples:**
```bash
# Quick code help
ollama run qwen2.5-coder:7b "explain this function: $(cat utils.js)"

# Use as API (OpenAI-compatible endpoint at localhost:11434)
curl http://localhost:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"qwen2.5-coder:7b","messages":[{"role":"user","content":"Hello"}]}'

# Use with any OpenAI-compatible tool
export OPENAI_BASE_URL=http://localhost:11434/v1
export OPENAI_API_KEY=ollama
```

**Recommended Models for Coding:**
| Model | Size | Best For |
|-------|------|----------|
| `qwen2.5-coder:7b` | 4.1GB | General coding |
| `deepseek-coder-v2:16b` | 8.9GB | Complex tasks |
| `codellama:13b` | 7.4GB | Instruction following |
| `llama3.3:70b` | 43GB | Best quality (needs 64GB RAM) |

**Tips:**
- `ollama serve` must be running as a background service
- Add to `~/.zprofile`: `brew services start ollama` for auto-start
- Works as a drop-in for any tool that supports OpenAI API

---

### 13. 🐟 Nushell — Structured Data Shell

**Install:**
```bash
brew install nushell
# Start Nushell:
nu
# Set as default shell:
chsh -s $(which nu)
```

**Key Commands:**
```bash
ls | where size > 1mb | sort-by size    # Filter and sort files
ps | where name =~ "node"               # Find node processes
open data.json | get users | length     # Parse JSON natively
http get https://api.github.com/users/me # HTTP requests
sys | get cpu                           # System info
```

**Usage Examples:**
```bash
# Work with JSON APIs natively
http get https://api.github.com/repos/anthropics/claude-code \
  | select name stargazers_count forks_count

# Filter log files
open server.log | lines | where ($it | str contains "ERROR") | last 10

# Pipeline with structured data
ls src/ | where type == file | get name | each { |f| open $f | str length }

# Parse CSV
open data.csv | where age > 30 | to json
```

**Tips:**
- Everything is structured data — no more `awk`, `grep`, `sed` for parsing
- Tab completion is built-in and context-aware
- Use `explore` command for an interactive data viewer

---

### 14. ✨ Starship — Smart Terminal Prompt

**Install:**
```bash
brew install starship
# Add to ~/.zshrc:
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
source ~/.zshrc
```

**Configuration (`~/.config/starship.toml`):**
```toml
[git_branch]
symbol = "🌱 "

[nodejs]
format = "via [⬢ $version](bold green) "

[python]
symbol = "🐍 "

[aws]
symbol = "☁️  "

[kubernetes]
disabled = false
```

**Tips:**
- Shows Git status, language versions, cloud context, k8s namespace all in your prompt
- 100+ integrations: Kubernetes, AWS, GCP, Python, Node.js, Rust, Go, etc.
- `starship preset nerd-font-symbols` for a beautiful nerd fonts preset

---

### 15. 📂 eza — Modern `ls` Replacement

**Install:**
```bash
brew install eza
# Add aliases to ~/.zshrc:
echo 'alias ls="eza --icons"' >> ~/.zshrc
echo 'alias ll="eza -l --icons --git"' >> ~/.zshrc
echo 'alias la="eza -la --icons --git"' >> ~/.zshrc
echo 'alias lt="eza --tree --icons"' >> ~/.zshrc
```

**Key Commands:**
```bash
eza --icons                    # List with icons
eza -l --git                   # Long format with git status
eza --tree --level=2           # Tree view, 2 levels deep
eza -la --sort=modified        # Sort by modification time
eza --group-directories-first  # Directories first
```

---

### 16. 🦇 bat — Syntax-Highlighted `cat`

**Install:**
```bash
brew install bat
# Add alias:
echo 'alias cat="bat"' >> ~/.zshrc
```

**Key Commands:**
```bash
bat file.ts                    # View with syntax highlighting
bat --paging=never file.py     # No pager (pipe-friendly)
bat --language=json data.txt   # Force language
bat --diff file.txt            # Show diff highlighting
```

---

### 17. 🚀 Zoxide — Smart Directory Navigation

**Install:**
```bash
brew install zoxide
# Add to ~/.zshrc:
echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
```

**Key Commands:**
```bash
z projects          # Jump to best match for "projects"
z my-app            # Jump to "my-app" directory
zi                  # Interactive fuzzy finder
zoxide query -l     # List all tracked directories
```

**Tips:**
- Learns your most-used directories over time
- `zi` uses `fzf` for interactive selection if installed

---

### 18. 🌐 HTTPie — Human-Friendly HTTP Client

**Install:**
```bash
brew install httpie
```

**Key Commands:**
```bash
http GET https://api.example.com/users      # GET request
http POST api.example.com name="John"       # POST with JSON
http PUT api.example.com/1 Authorization:"Bearer token"  # With headers
http --download https://example.com/file    # Download file
https api.example.com                       # HTTPS shortcut
```

**Usage Examples:**
```bash
# Test a local API
http POST localhost:3000/api/users \
  name="Alice" \
  email="alice@example.com" \
  Authorization:"Bearer my-token"

# With JSON body
http POST api.example.com/data \
  Content-Type:application/json \
  < data.json

# Pretty-print response
http GET https://api.github.com/users/anthropics | cat
```

---

### 19. 🍭 Crush CLI — Glamorous TUI AI Agent (Charmbracelet)

**Install:**
```bash
brew tap charmbracelet/tap
brew install charmbracelet/tap/crush
```

**Auth Setup:**
```bash
crush                   # First run prompts for API key
export ANTHROPIC_API_KEY="sk-ant-..."
# Supports: Claude, OpenAI, Gemini, Ollama
```

**Key Commands:**
```bash
crush                              # Launch beautiful TUI
crush "fix all linting errors"     # Direct task
crush --model claude-opus-4-6 "..."  # Use specific model
```

**Tips:**
- Beautiful terminal UI built with Charmbracelet's Bubble Tea framework
- Perfect for developers who live in the terminal
- Supports all major LLM providers

---

### 20. 🔑 gogcli — Google Workspace CLI

**Install:**
```bash
brew tap steipete/tap
brew install steipete/tap/gogcli
```

**Auth Setup:**
```bash
gogcli auth login       # Browser-based Google OAuth
```

**Key Commands:**
```bash
gogcli gmail list                           # List recent emails
gogcli gmail read [id]                      # Read email
gogcli gmail send --to x@x.com --subject "" # Send email
gogcli calendar list                        # List events
gogcli calendar create --title "Meeting"    # Create event
gogcli drive list                           # List Drive files
gogcli drive upload file.pdf                # Upload to Drive
gogcli contacts search "Alice"              # Search contacts
```

**Usage Examples:**
```bash
# Daily standup summary
gogcli gmail list --unread --json | \
  claude "summarize these emails in a standup format"

# Create calendar event from natural language
gogcli calendar create \
  --title "Architecture Review" \
  --date "tomorrow 2pm" \
  --duration 60

# Automate file organization
gogcli drive list --json | jq '.[] | select(.name | startswith("2026"))' | \
  gogcli drive move --folder Archive/2026
```

---

### 21. ⚡ Warp — The AI Terminal

**Install:**
```bash
# Download from warp.dev (GUI app + CLI)
brew install --cask warp
```

**Key Features:**
```bash
# In Warp terminal, just type naturally:
"delete all node_modules folders recursively"
# → Warp converts to: find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +

"show me memory usage by process sorted by highest first"
# → Warp converts to: ps aux --sort=-%mem | head -20
```

**Natural Language Commands (press Ctrl+`\ `):**
```bash
"find all files modified in the last hour"
"compress the src folder without node_modules"
"set up a Python virtual environment"
"watch the docker logs for my api container"
```

**Tips:**
- Block-based terminal — each command + output is a selectable block
- `Ctrl+R` for AI-powered fuzzy command history search
- Warp Drive: share commands and environments with your team
- AI explains any command/error in plain English on hover

---

### 22. 🔍 qmd — Local Semantic Search CLI

**Install:**
```bash
# Clone and install from GitHub
git clone https://github.com/tobi/qmd ~/.qmd
cd ~/.qmd && npm install && npm link
```

**Key Commands:**
```bash
qmd index ~/Documents         # Index a folder
qmd search "authentication"    # Semantic search
qmd "how does auth work?"      # Natural language query
qmd --local                   # Force fully offline mode
```

**Tips:**
- Uses local SOTA embedding models — fully offline/private
- ⭐ 12,488 stars — trending fast in March 2026
- Index your docs, meeting notes, code repos for instant retrieval

---

---

## ☁️ Cloud & Infrastructure CLIs

---

### 23. ▲ Vercel CLI — Deploy Frontend Apps
**Install:** `npm install -g vercel`
**Auth Setup:** `vercel login`
**Key Commands:**
- `vercel` or `vc` (deploy current project)
- `vercel dev` (run local dev environment)
- `vercel env pull` (download env vars)
- `vercel logs` (tail deployment logs)

---

### 24. 🧱 Wrangler — Cloudflare Workers CLI
**Install:** `npm install -g wrangler`
**Auth Setup:** `wrangler login`
**Key Commands:**
- `wrangler init` (create new project)
- `wrangler dev` (run local server)
- `wrangler deploy` (publish worker)
- `wrangler kv:namespace create` (manage KV databases)

---

### 25. 🟢 Supabase CLI — Open Source Firebase Auth & DB
**Install:** `brew tap supabase/tap && brew install supabase`
**Auth Setup:** `supabase login`
**Key Commands:**
- `supabase init` (initialize project settings)
- `supabase start` (run full stack locally in Docker/OrbStack)
- `supabase gen types typescript` (generate DB typings)
- `supabase migration new` (create schema migrations)

---

### 26. 🚀 Fly.io CLI (`flyctl`) — Deploy Apps Close to Users
**Install:** `brew install superfly/tap/flyctl`
**Auth Setup:** `fly auth login`
**Key Commands:**
- `fly launch` (configure and deploy new app)
- `fly deploy` (deploy new version)
- `fly ssh console` (open SSH shell into app)
- `fly postgres connect` (connect to DB)

---

### 27. 💳 Stripe CLI — Build & Test Payments
**Install:** `brew install stripe/stripe-cli/stripe`
**Auth Setup:** `stripe login`
**Key Commands:**
- `stripe listen --forward-to localhost:3000/webhook` (test webhooks)
- `stripe trigger payment_intent.succeeded` (simulate events)
- `stripe customers list` (API interaction)

---

### 28. ☁️ AWS CLI — Amazon Web Services Control
**Install:** `brew install awscli`
**Auth Setup:** `aws configure` (needs Access Key ID and Secret)
**Key Commands:**
- `aws s3 ls` (list S3 buckets)
- `aws s3 sync ./dist s3://my-bucket` (deploy static site)
- `aws ec2 describe-instances` (list VMs)

---

## 🔧 Terminal Power Tools

---

### 29. 🦊 Bun — Insanely Fast JS/TS Runtime
**Install:** `npm install -g bun`
**Key Commands:**
- `bun run index.ts` (run code directly, no compilation)
- `bun install` (20x faster than npm install)
- `bun test` (built-in fast test runner)

### 30. 🦕 Deno — Secure by Default JS/TS Runtime
**Install:** `brew install deno`
**Key Commands:**
- `deno run --allow-net --allow-read app.ts` (explicit permissions)
- `deno fmt` and `deno lint` (built-in formatter/linter)
- `deno task start` (run package.json scripts natively)

### 31. 🔍 ripgrep (`rg`) & fd — Blazing Fast Searching
**Install:** `brew install ripgrep fd`
**Key Commands:**
- `rg "TODO"` (search file contents recursively, respects .gitignore)
- `rg -t ts "function"` (search only TypeScript files)
- `fd filename` (fast alternative to `find`)
- `fd -e md` (find all markdown files)

### 32. 📊 jq & yq — JSON/YAML Command Line Parsers
**Install:** `brew install jq yq`
**Key Commands:**
- `cat package.json | jq '.scripts'` (extract JSON fields)
- `yq '.services.db.image' docker-compose.yml` (parse YAML)

### 33. 💤 lazygit — The Best Terminal UI for Git
**Install:** `brew install lazygit`
**Usage:** Just type `lazygit` in any repository folder. Interactive staging, rebasing, committing, and pushing entirely via keyboard.

### 34. 🪟 Zellij — Modern Terminal Multiplexer (tmux alternative)
**Install:** `brew install zellij`
**Usage:** Run `zellij` to easily split terminal windows, detach/reattach sessions, and run complex layouts with an intuitive UI and WebAssembly plugins.

### 35. 🐳 OrbStack — Fast, Light Docker Alternative
**Install:** `brew install --cask orbstack`
**Usage:** Drop-in replacement for Docker Desktop on Mac. Boot times <2s, extremely low CPU/RAM usage. Commands remain the same (e.g. `docker ps`, `docker-compose up`).

---

### 36. 🔺 Convex CLI — Modern Reactive Backend
**Install:** `npm install -g convex`
**Auth Setup:** `npx convex login`
**Key Commands:**
- `npx convex dev` (run local database+functions sync)
- `npx convex deploy` (push backend code to production)

### 37. 🛢️ Turso CLI — SQLite at the Edge
**Install:** `brew tap tursodatabase/tap && brew install turso`
**Auth Setup:** `turso auth login`
**Key Commands:**
- `turso db create my-db` (spin up a new SQLite database)
- `turso db shell my-db` (open interactive SQL shell)
- `turso db replicate my-db syd` (replicate database globally)

---

## 🛠️ Modern Toolchains & Workflows

---

### 38. 📦 pnpm — Fast, Disk-Efficient Package Manager
**Install:** `npm install -g pnpm`
**Key Commands:**
- `pnpm install` (installs node_modules instantly using hard links)
- `pnpm add react` (add dependency)
- `pnpm create next-app` (bootstraps exactly like npm/npx)

### 39. ⚡ Biome — Ultra-Fast Formatter & Linter (Prettier/ESLint Replacement)
**Install:** `brew install biome`
**Key Commands:**
- `biome format --write ./src` (format files in < 1s)
- `biome lint ./src` (type-aware fast linting)
- `biome check --apply ./src` (do both and auto-fix)

### 40. 🐶 Bruno — Local-first, Open Source Postman Alternative
**Install:** `npm install -g @usebruno/cli`
**Usage:** Keep API collections as plain text files in your repo (Git-friendly). Run collections from the CLI natively.
**Key Commands:**
- `bru run folder-name` (run an API collection)
- `bru run request.bru --env dev` (run specific request)

### 41. 📊 btop — Beautiful System Resource Monitor
**Install:** `brew install btop`
**Usage:** Simply type `btop` in the terminal for a gorgeous, interactive, mouse-supported C++ system monitor. Top-tier `htop` successor.

### 42. 📂 yazi — Blazing Fast Terminal File Manager
**Install:** `brew install yazi`
**Usage:** Type `yazi`. Written in Rust, asynchronous I/O, rich media previews directly in your terminal, vim-like navigation. Integrates with `rg` and `fd`.

### 43. 📁 clasp — Google Apps Script CLI
**Install:** `npm install -g @google/clasp`
**Auth Setup:** `clasp login`
**Key Commands:**
- `clasp clone <scriptId>` (pull Google Scripts code locally)
- `clasp push` (upload local TS/JS to Google Workspace)

### 44. 🏗️ v0 CLI (Vercel) — AI React/Tailwind Generator
**Install:** `npm install -g v0`
**Auth Setup:** `v0 login`
**Key Commands:**
- `v0 init` (setup project for v0)
- `v0 add "a responsive dashboard layout"` (generate a component via CLI)
- `v0 update Dashboard "make the sidebar darker"` (iterate on existing)

### 45. 🧱 Builder.io CLI — Design-to-Code Sync
**Install:** `npm install -g @builder.io/cli`
**Usage:** Pull Figma designs directly into your codebase as clean, production-ready React/Vue/Svelte components.
**Key Commands:**
- `builder init`
- `builder generate component "Hero Section"` (surgical code generation)
- `builder index-repo` (teach the AI your component structure)

### 46. 💨 Tailwind CSS CLI — The Styling Engine
**Install:** `npm install -g tailwindcss`
**Key Commands:**
- `tailwindcss init` (create tailwind.config.js)
- `tailwindcss -i ./src/input.css -o ./dist/output.css --watch` (build CSS)

### 47. ✂️ SVGO — SVG Asset Optimizer
**Install:** `npm install -g svgo`
**Usage:** Minifies SVG files for production.
**Key Commands:**
- `svgo logo.svg` (optimizes in place)
- `svgo -f ./svg-folder -o ./compressed-folder` (batch optimization)

### 48. 🖼️ ImageOptim CLI — PNG/JPG/WebP/AVIF Compression
**Install:** `npm install -g imageoptim-cli`
**Usage:** Automates the macOS ImageOptim app from the terminal to crush asset sizes without losing visual quality.
**Key Commands:**
- `imageoptim --directory ./public/images` (batch compress)
- `imageoptim --imageoptim --jpegmini file.jpg` (use specific engines)

### 49. 🚥 Lighthouse CLI — CI/CD Performance Audits
**Install:** `npm install -g lighthouse`
**Usage:** Run Google Lighthouse audits directly from the terminal.
**Key Commands:**
- `lighthouse https://example.com --view` (run audit and open HTML report)
- `lighthouse https://example.com --output json` (for CI/CD pipelines)

### 50. ♿ Axe CLI — Studio-Grade Accessibility Testing
**Install:** `npm install -g @axe-core/cli`
**Usage:** Ensure your studio sites meet WCAG 2.1 AA compliance before shipping.
**Key Commands:**
- `axe https://example.com` (run accessibility audit)
- `axe --rules color-contrast,image-alt https://example.com` (specific rules)

---

## 🧪 Testing & Quality Assurance

---

### 51. 🎭 Playwright CLI — Next-Gen E2E Browser Testing
**Install:** `npm install -g playwright` 
*(Note: Per-project setup is usually `npm init playwright@latest`)*
**Auth Setup:** No auth required.
**Key Commands:**
- `playwright test` (run tests across all browsers)
- `playwright test --ui` (open interactive UI mode for visual debugging)
- `playwright codegen wikipedia.org` (open browser and auto-generate test scripts by clicking around)

### 52. ⚡ Vitest CLI — Blazing Fast Unit Testing
**Install:** `npm install -g vitest`
**Usage:** The Vite-native drop-in replacement for Jest. Impossibly fast unit testing with out-of-the-box native TypeScript support.
**Key Commands:**
- `vitest` (run all tests in watch mode by default)
- `vitest run` (run once for CI/CD)
- `vitest --ui` (launch gorgeous web interface to view test results)

### 53. 📖 Storybook CLI — UI Component Explorer
**Install:** `npm install -g storybook`
**Usage:** Industry standard for UI component development, testing, and documentation.
**Key Commands:**
- `sb init` (auto-detects React/Vue/Svelte and scaffolds Storybook)
- `storybook dev -p 6006` (run the component explorer server)
- `storybook build` (compile static build for deployment)

---

## 🧠 Agentic Frameworks

---

### 54. 🦅 OpenClaw — Agentic AI Framework
**Install:** `npm install -g openclaw`
**Usage:** A self-hosted open-source framework for building agentic AI, capable of executing tasks on your local machine and integrating with messaging platforms.
**Team Access:** Securely share with partners via `openclaw pairing approve telegram <CODE>`. See `OPENCLAW_SETUP.md` for full details on multi-user configuration.
**Key Commands:**
- `openclaw init` (scaffold a new agent project)
- `openclaw start` (launch the openclaw agent server)

### 55. 🦸 Obra Superpowers — Global Agentic Skills
**Install:** Included via GitHub clone into `~/.superpowers`.
**Usage:** Provides a suite of "skills" and instructions (TDD, DRY, architecture planning) for your AI agents (Claude, Cline, Cursor, etc.). It acts as a standardized workflow enhancer that your other CLIs can read from.
**Configuration:**
- It is globally available via the `SUPERPOWERS_PATH` environment variable.
- Symlinked into `~/.config/cline/superpowers` and `~/.config/claude/superpowers` for seamless zero-config access.

### 56. 🥧 Pi-Mono (pi-coding-agent) — AI Agent Toolkit
**Install:** `npm install -g @mariozechner/pi-coding-agent`
**Usage:** The command-line client for the badlogic monorepo agent. An extensible AI toolkit featuring a terminal UI, Slack bot capabilities, and general purpose coding assistance.
**Key Commands:**
- `pi` (launch the terminal interface)

---

## 🔑 API Keys Reference

| Tool | Where to Get Key |
|------|-----------------|
| Claude Code | [console.anthropic.com](https://console.anthropic.com) |
| Gemini CLI | [aistudio.google.com](https://aistudio.google.com) (free!) |
| Codex CLI | [platform.openai.com](https://platform.openai.com) |
| Qwen Code | OAuth (free 1K/day) or [alibabacloud.com](https://alibabacloud.com) |
| Kilo Code | Via `/connect` (uses your existing keys) |
| Kimi Code | [platform.moonshot.cn](https://platform.moonshot.cn) |
| gcloud | [console.cloud.google.com](https://console.cloud.google.com) |
| Ollama | None needed — 100% local! |

---

## 💡 Recommended Tool Combos

| Use Case | Stack |
|----------|-------|
| **Daily dev AI** | Claude Code + Gemini CLI (fallback) + Ollama (free tasks) |
| **Full autonomy** | Codex CLI `--full-auto` or Cline `--approve-all` |
| **Budget** | Qwen Code (free OAuth) + Cline with Ollama |
| **Google Cloud** | gcloud + Gemini CLI + gogcli |
| **Terminal aesthetics** | Warp + Starship + eza + bat + Nushell |
| **Open source only** | OpenCode + Cline + Ollama + gh |
