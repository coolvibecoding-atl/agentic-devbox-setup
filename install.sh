#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "==========================================================="
echo "🚀 Ultimate Agentic DevOps Setup Script"
echo "==========================================================="
echo "This script will transform a fresh macOS installation into"
echo "a state-of-the-art 2026 developer workstation."
echo ""
echo "It installs 50+ CLI tools across these categories:"
echo "  1. Core Systems (Homebrew, Node, Git)"
echo "  2. AI & Agentic Coding CLIs"
echo "  3. Cloud & Infrastructure"
echo "  4. Terminal Productivity & Quality of Life"
echo "  5. Next-Gen databases & Frontend CLIs"
echo "==========================================================="

echo "Press ENTER to begin or Ctrl+C to abort..."
read -r

# --- 1. CORE SYSTEM SETUP ---
echo "📦 Setting up Core Systems..."

# Check and install Xcode Command Line Tools
if ! xcode-select -p &> /dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    echo "Please finish the Xcode installation dialog, then run this script again."
    exit 1
fi

# Check and install Homebrew
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add brew to path for the rest of this script's execution
    if [ -d "/opt/homebrew/bin" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -d "/usr/local/bin" ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed. Updating..."
    brew update
fi

# Install NVM & Node.js
if [ -z "$NVM_DIR" ]; then
    echo "Installing NVM (Node Version Manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

echo "Installing latest LTS Node.js..."
nvm install --lts
nvm use --lts

# --- 2. HOMEBREW BATCH INSTALLATION ---
echo "🍺 Installing Homebrew Packages..."

brew tap supabase/tap
brew tap superfly/tap
brew tap charmbracelet/tap
brew tap steipete/tap
brew tap tursodatabase/tap

BREW_PACKAGES=(
    # Core Runtimes
    python
    bun
    deno
    # Terminal Power Tools
    zoxide
    starship
    eza
    bat
    fzf
    jq
    yq
    lazygit
    zellij
    ripgrep
    fd
    httpie
    btop
    yazi
    # Cloud CLIs
    gh
    awscli
    stripe/stripe-cli/stripe
    tursodatabase/tap/turso
    supabase/tap/supabase
    superfly/tap/flyctl
    # Misc Tools
    charmbracelet/tap/crush
    steipete/tap/gogcli
    biome
    nushell
)

brew install "${BREW_PACKAGES[@]}"

echo "🐳 Installing Casks (OrbStack, Warp, Blender)..."
# Using --force in case they were previously installed but removed
brew install --cask orbstack warp blender --force || echo "Casks may already be installed."

# --- 3. NPM BATCH INSTALLATION ---
echo "📦 Installing Global NPM Packages (AI Agents & Web Tools)..."

NPM_PACKAGES=(
    # AI & Agentic Coding
    openclaw
    @google/genai-cli
    open-interpreter
    @anthropic-ai/claude-code
    @kilo-code/cli
    @mariozechner/pi-coding-agent
    opencodecli
    codebuff
    cline-cli
    qwen-code-cli
    # Frontend & Cloud
    vercel
    wrangler
    pnpm
    convex
    @usebruno/cli
    @google/clasp
    # Design Studio
    v0
    @builder.io/cli
    tailwindcss
    svgo
    imageoptim-cli
    lighthouse
    @axe-core/cli
    # Testing & QA
    playwright
    vitest
    storybook
    # 3D Pipeline
    gltf-pipeline
)

npm install -g "${NPM_PACKAGES[@]}"

# --- 4. CUSTOM CLI INSTALLATIONS ---

echo "🦙 Installing Ollama (Local LLMs)..."
if ! command -v ollama &> /dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh
fi

echo "☁️ Installing Google Cloud SDK..."
if ! command -v gcloud &> /dev/null; then
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-darwin-x86_64.tar.gz
    tar -xf google-cloud-cli-darwin-x86_64.tar.gz
    rm google-cloud-cli-darwin-x86_64.tar.gz
    ./google-cloud-sdk/install.sh -q --path-update=true
fi

echo "🌐 Installing Ngrok..."
if ! command -v ngrok &> /dev/null; then
    curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
      | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
      && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
      | sudo tee /etc/apt/sources.list.d/ngrok.list \
      && sudo apt update && sudo apt install ngrok || brew install ngrok
fi

echo "🔍 Installing qmd (Local Semantic Search)..."
if [ ! -d "$HOME/.qmd" ]; then
    git clone https://github.com/tobi/qmd "$HOME/.qmd"
    cd "$HOME/.qmd" && npm install && npm link && cd - > /dev/null
else
    echo "qmd already cloned. Pulling latest..."
    cd "$HOME/.qmd" && git pull && npm install && npm link && cd - > /dev/null
fi

echo "🦸 Installing Agentic Skills (obra/superpowers)..."
if [ ! -d "$HOME/.superpowers" ]; then
    git clone https://github.com/obra/superpowers.git "$HOME/.superpowers"
else
    echo "Superpowers already cloned. Pulling latest..."
    cd "$HOME/.superpowers" && git pull && cd - > /dev/null
fi
# Make superpowers available to popular CLI agents
mkdir -p "$HOME/.config/cline" "$HOME/.config/claude"
ln -sf "$HOME/.superpowers" "$HOME/.config/cline/superpowers" || true
ln -sf "$HOME/.superpowers" "$HOME/.config/claude/superpowers" || true

# --- 5. AI AGENT SKILLS CONFIGURATION ---
echo "🧠 Installing 600+ Expert Agentic Skills across all CLIs..."

# Define target directories for AI Agents
SKILL_DIRS=(
    "$HOME/.gemini/antigravity/skills/"
    "$HOME/.claude/skills/"
    "$HOME/homebrew/.claude/skills/"
    "$HOME/.codex/skills/"
    "$HOME/.config/kilo/skills/"
    "$HOME/.superpowers/.opencode/plugins/"
    "$HOME/.openclaw/skills/"
)

for target in "${SKILL_DIRS[@]}"; do
    mkdir -p "$target"
done

# Function to clone and install additional skills
install_remote_skill() {
    local repo_url=$1
    local skill_name=$2
    local temp_dir="/tmp/skill_clone_$(uuidgen)"
    
    echo "Installing $skill_name..."
    git clone --depth 1 "$repo_url" "$temp_dir" > /dev/null 2>&1
    
    if [ -d "$temp_dir" ]; then
        local skill_src=""
        if [ -d "$temp_dir/skills/$skill_name" ]; then skill_src="$temp_dir/skills/$skill_name";
        elif [ -d "$temp_dir/skills" ] && [ "$skill_name" == "trailofbits-skills" ]; then skill_src="$temp_dir/skills";
        elif [ -d "$temp_dir/$skill_name" ]; then skill_src="$temp_dir/$skill_name";
        else
            local found_dir=$(find "$temp_dir" -name "SKILL.md" -exec grep -l -i "name:.*$skill_name" {} + | head -n 1 | xargs dirname 2>/dev/null)
            if [ -n "$found_dir" ] && [ -d "$found_dir" ]; then skill_src="$found_dir";
            elif [ -f "$temp_dir/SKILL.md" ]; then skill_src="$temp_dir"; fi
        fi
        
        local safe_name="${skill_name// /_}"
        if [ -n "$skill_src" ] && [ -d "$skill_src" ]; then
            for target in "${SKILL_DIRS[@]}"; do
                if [ "$skill_name" == "trailofbits-skills" ]; then cp -R "$skill_src/"* "$target/" 2>/dev/null || cp -R "$skill_src" "$target/$safe_name";
                elif [ "$skill_name" == "research-skills" ] && [ -d "$skill_src/skills" ]; then cp -R "$skill_src/skills/"* "$target/" 2>/dev/null || cp -R "$skill_src" "$target/$safe_name";
                else cp -R "$skill_src" "$target/$safe_name"; fi
            done
        fi
        rm -rf "$temp_dir"
    fi
}

echo "Cloning 563-skill base backup repository..."
git clone --depth 1 https://github.com/404kidwiz/claude-skills-backup.git /tmp/claude-skills-backup > /dev/null 2>&1
if [ -d "/tmp/claude-skills-backup" ]; then
    for target in "${SKILL_DIRS[@]}"; do cp -R /tmp/claude-skills-backup/* "$target/"; done
    rm -rf /tmp/claude-skills-backup
fi

echo "Installing community, vercel, and specialized remote skills..."
install_remote_skill "https://github.com/vercel-labs/skills" "find-skills"
install_remote_skill "https://github.com/vercel-labs/agent-skills" "vercel-react-best-practices"
install_remote_skill "https://github.com/vercel-labs/agent-skills" "web-design-guidelines"
install_remote_skill "https://github.com/remotion-dev/skills" "remotion-best-practices"
install_remote_skill "https://github.com/microsoft/github-copilot-for-azure" "azure-ai"
install_remote_skill "https://github.com/vercel-labs/agent-browser" "agent-browser"
install_remote_skill "https://github.com/vercel-labs/agent-skills" "vercel-composition-patterns"
install_remote_skill "https://github.com/anthropics/skills" "skill-creator"
install_remote_skill "https://github.com/sleekdotdesign/agent-skills" "sleek-design-mobile-apps"
install_remote_skill "https://github.com/vercel-labs/agent-skills" "vercel-react-native-skills"
install_remote_skill "https://github.com/nextlevelbuilder/ui-ux-pro-max-skill" "ui-ux-pro-max"
install_remote_skill "https://github.com/obra/superpowers" "brainstorming"
install_remote_skill "https://github.com/coreyhaines31/marketingskills" "seo-audit"
install_remote_skill "https://github.com/squirrelscan/skills" "audit-website"
install_remote_skill "https://github.com/anthropics/skills" "pdf"
install_remote_skill "https://github.com/supabase/agent-skills" "supabase-postgres-best-practices"
install_remote_skill "https://github.com/coreyhaines31/marketingskills" "copywriting"
install_remote_skill "https://github.com/obra/superpowers" "systematic-debugging"
install_remote_skill "https://github.com/anthropics/skills" "docx"
install_remote_skill "https://github.com/tul-sh/skills" "agent-tools"
install_remote_skill "https://github.com/tul-sh/skills" "twitter-automation"
install_remote_skill "https://github.com/tul-sh/skills" "remotion-render"
install_remote_skill "https://github.com/tul-sh/skills" "nano-banana-2"
install_remote_skill "https://github.com/hexiaochun/seedance2-api" "seedance2-api"
install_remote_skill "https://github.com/anthropics/skills" "theme-factory"
install_remote_skill "https://github.com/anthropics/skills" "algorithmic-art"
install_remote_skill "https://github.com/anthropics/skills" "web-artifacts-builder"
install_remote_skill "https://github.com/anthropics/skills" "brand-guidelines"
install_remote_skill "https://github.com/google-labs-code/stitch-skills" "stitch-loop"
install_remote_skill "https://github.com/anthropics/skills" "template-skill"
install_remote_skill "https://github.com/google-labs-code/stitch-skills" "enhance-prompt"
install_remote_skill "https://github.com/giuseppe-trisciuoglio/developer-kit" "shadcn-ui"
install_remote_skill "https://github.com/vercel/ai" "ai-sdk"
install_remote_skill "https://github.com/github/awesome-copilot" "git-commit"
install_remote_skill "https://github.com/madteacher/mad-agents-skills" "flutter-animations"
install_remote_skill "https://github.com/firecrawl/cli" "firecrawl"
install_remote_skill "https://github.com/am-will/codex-skills" "Frontend Responsive Design Standards"
install_remote_skill "https://github.com/hyf0/vue-skills" "vue-best-practices"
install_remote_skill "https://github.com/am-will/codex-skills" "context7"
install_remote_skill "https://github.com/am-will/codex-skills" "parallel-task"
install_remote_skill "https://github.com/am-will/codex-skills" "plan-harder"
install_remote_skill "https://github.com/am-will/codex-skills" "openai-docs-skill"
install_remote_skill "https://github.com/am-will/codex-skills" "swarm-planner"
install_remote_skill "https://github.com/am-will/codex-skills" "gemini-computer-use"
install_remote_skill "https://github.com/mvanhorn/last30days-skill" "last30days-skill"
install_remote_skill "https://github.com/skainguyen1412/social-media-research-skill" "social-media-research-skill"
install_remote_skill "https://github.com/prikotov/google-trends" "google-trends"
install_remote_skill "https://github.com/JYunth/newspaper" "newspaper"
install_remote_skill "https://github.com/xiazhefengzhi/find-products-skill" "find-products-skill"
install_remote_skill "https://github.com/K-Dense-AI/claude-scientific-skills" "claude-scientific-skills"
install_remote_skill "https://github.com/luwill/research-skills" "research-skills"
install_remote_skill "https://github.com/trailofbits/skills" "trailofbits-skills"
install_remote_skill "https://github.com/tul-sh/skills" "ai-video-generation"
install_remote_skill "https://github.com/obra/superpowers" "test-driven-developments"
install_remote_skill "https://github.com/anthropics/skills" "webapp-testing"
install_remote_skill "https://github.com/better-auth/skills" "better-auth-best-practices"
install_remote_skill "https://github.com/coreyhaines31/marketingskills" "content-strategy"
install_remote_skill "https://github.com/anthropics/skills" "mcp-builder"
install_remote_skill "https://github.com/obra/superpowers" "using-superpowers"
install_remote_skill "https://github.com/coreyhaines31/marketingskills" "pricing-strategy"
install_remote_skill "https://github.com/expo/skills" "building-native-ui"
install_remote_skill "https://github.com/obra/superpowers" "subagent-driven-development"
install_remote_skill "https://github.com/wshobson/agents" "tailwind-design-system"
install_remote_skill "https://github.com/coreyhaines31/marketingskills" "launch-strategy"
install_remote_skill "https://github.com/obra/superpowers" "using-git-worktrees"
install_remote_skill "https://github.com/obra/superpowers" "dispatching-parallel-agents"
install_remote_skill "https://github.com/coreyhaines31/marketingskills" "signup-flow-cro"
install_remote_skill "https://github.com/coreyhaines31/marketingskills" "paywall-upgrade-cro"
install_remote_skill "https://github.com/google-labs-code/stitch-skills" "design-md"

echo "Installing 5 God-Tier Infrastructure Skills..."
create_custom_skill "magentic-one-orchestrator" "Microsoft Magentic-One hierarchical multi-agent orchestration. Use for long-running tasks (>30min) with WebSurfer, FileSurfer, Coder, and ComputerTerminal subagents with guaranteed state recovery."
create_custom_skill "mcp-unified-connector" "Model Context Protocol (MCP) universal interface. Configures Anthropic/Azure MCP servers as a unified bus so all skills natively read/write to VS Code, Postgres, Redis, and cloud APIs without custom middleware."
create_custom_skill "self-healing-pipeline" "Autonomous Self-Healing CI/CD. When a build fails, triggers an AI repair cycle: downloads logs, identifies root cause, generates a fix PR, and re-runs tests without human intervention."
create_custom_skill "speckit-spec-guardian" "Specification-Driven Development Guardian (SpecKit). Enforces Spec-First workflow — agents must satisfy SPEC.md acceptance criteria before committing. Prevents AI drift from requirements."
create_custom_skill "pai-memory-hub" "Personal AI Infrastructure (PAI) Memory Hub. Replaces isolated per-agent ChromaDB with unified LangGraph Persistence so the rig remembers architectural decisions and skill effectiveness across all projects."

echo "Installing 200+ Bonus Skills from Community Repos..."
install_whole_repo "https://github.com/aaron-he-zhu/seo-geo-claude-skills" "build"
install_whole_repo "https://github.com/aaron-he-zhu/seo-geo-claude-skills" "cross-cutting"
install_whole_repo "https://github.com/aaron-he-zhu/seo-geo-claude-skills" "monitor"
install_whole_repo "https://github.com/aaron-he-zhu/seo-geo-claude-skills" "optimize"
install_whole_repo "https://github.com/aaron-he-zhu/seo-geo-claude-skills" "research"
install_whole_repo "https://github.com/Eronred/aso-skills" "skills"
install_whole_repo "https://github.com/trailofbits/skills" "plugins"
install_whole_repo "https://github.com/luwill/research-skills" ""
install_whole_repo "https://github.com/K-Dense-AI/claude-scientific-skills" ""
install_whole_repo "https://github.com/Aviatorxx/ai-hot-research-skills" ""
install_whole_repo "https://github.com/Bigdata-com/skills-financial-research-analyst" ""
install_whole_repo "https://github.com/damionrashford/RivalSearch-Plugin" ""
install_whole_repo "https://github.com/neokahu/x-research-skill" ""
install_whole_repo "https://github.com/openapexmarket/polymarket-research-toolkit" ""
install_whole_repo "https://github.com/designagentlab/skills" ""
install_remote_skill "https://github.com/luwill/research-skills" "medical-imaging-review"
install_remote_skill "https://github.com/luwill/research-skills" "paper-slide-deck"
install_remote_skill "https://github.com/luwill/research-skills" "research-proposal"

echo "Generating 12 Custom God-Tier Skills..."
BASE_DIR="/tmp/custom_god_tier_skills"
mkdir -p "$BASE_DIR"

create_custom_skill() {
    local name=$1
    local desc=$2
    local dir="$BASE_DIR/$name"
    
    mkdir -p "$dir"
    cat << EOF > "$dir/SKILL.md"
---
name: $name
description: $desc
metadata:
  author: antigravity
  version: "1.0.0"
---

# $name

## Overview
$desc

## Usage Rules
- Automatically triggered when the user asks about topics related to $name.
- Execute steps meticulously according to the industry best practices for this domain.
- Use parallel subagents when dealing with highly complex aspects of this skill.
EOF

    for target in "${SKILL_DIRS[@]}"; do
        cp -R "$dir" "$target/"
    done
}

create_custom_skill "crewai-orchestrator" "Define multi-agent SOPs and crew configurations for Autogen or CrewAI."
create_custom_skill "ollama-local-router" "Automatically fallback to local LLMs like Llama 3 when cloud APIs rate limit."
create_custom_skill "mcp-database-connectors" "Configure Model Context Protocol (MCP) servers to give the AI direct read/write access to local Postgres, SQLite, or Redis."
create_custom_skill "k8s-operator-builder" "Generate Kubernetes Custom Resource Definitions (CRDs) and Go operators."
create_custom_skill "github-actions-architect" "Generate production-ready, highly complex GitHub Actions CI/CD YAML files with caching, matrix builds, and security scanning."
create_custom_skill "databricks-snowflake-engineer" "Enterprise-level data warehouse tooling for generating complex dbt models and Airflow DAGs."
create_custom_skill "smart-contract-auditor-pro" "Find deep reentrancy vulnerabilities in Solidity using Slither and Foundry integrations."
create_custom_skill "zero-day-fuzzer" "Generate Python scripts for protocol/API fuzzing and memory corruption testing on compiled binaries."
create_custom_skill "cloud-iam-least-privilege" "Analyze AWS/GCP IAM policies and automatically refactor them to strict least-privilege standards."
create_custom_skill "elevenlabs-voice-architect" "Interface with ElevenLabs for generating dynamic Text-to-Speech assets directly from the CLI."
create_custom_skill "webgl-threejs-expert" "Write complex, mathematically intensive 3D shader code, Three.js scenes, and React-Three-Fiber models."
create_custom_skill "wasm-rust-bridge" "Compile Rust into WebAssembly and generate the exact React hooks needed to consume them for high-performance browser computing."

rm -rf "$BASE_DIR"


# --- 6. ZSH CONFIGURATION ---
echo "⚙️ Configuring Zsh..."

ZSHRC_AI="$HOME/.zshrc_ai_tools"
cat << 'EOF' > "$ZSHRC_AI"
# AI Dev Box Configuration (Auto-Generated)

# Agentic Skills Path
export SUPERPOWERS_PATH="$HOME/.superpowers"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Starship Prompt
eval "$(starship init zsh)"

# Zoxide (Better cd)
eval "$(zoxide init zsh)"
alias cd="z"

# Eza (Better ls)
alias ls="eza --icons --git"
alias ll="eza -lh --icons --git"
alias la="eza -lah --icons --git"
alias tree="eza --tree --icons"

# Bat (Better cat)
alias cat="bat"

# Git aliases
alias lg="lazygit"

# Editor
export EDITOR="nano"
EOF

# Append to .zshrc if not already there
if ! grep -q "source $ZSHRC_AI" "$HOME/.zshrc"; then
    echo "source $ZSHRC_AI" >> "$HOME/.zshrc"
fi

echo "==========================================================="
echo "✅ Installation Complete! 🎉"
echo "==========================================================="
echo "Your system is now a state-of-the-art Agentic DevOps Dev Box."
echo ""
echo "Next Steps:"
echo "1. Run 'source ~/.zshrc' to apply terminal changes."
echo "2. Open the OrbStack app from your Applications folder."
echo "3. Open the Warp terminal app from your Applications folder."
echo "4. Set up your API keys (Anthropic, OpenAI, Google) as needed."
echo "5. Consult the USAGE_GUIDE.md file in the repo for CLI commands."
echo "==========================================================="
