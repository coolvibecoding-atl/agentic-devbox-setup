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
)

brew install "${BREW_PACKAGES[@]}"

echo "🐳 Installing OrbStack (Docker alternative) and Warp (AI Terminal)..."
# Using --force in case they were previously installed but removed
brew install --cask orbstack warp --force || echo "Casks may already be installed."

# --- 3. NPM BATCH INSTALLATION ---
echo "📦 Installing Global NPM Packages (AI Agents & Web Tools)..."

NPM_PACKAGES=(
    # AI & Agentic Coding
    @google/genai-cli
    open-interpreter
    @anthropic-ai/claude-code
    @kilo-code/cli
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

# --- 5. ZSH CONFIGURATION ---
echo "⚙️ Configuring Zsh..."

ZSHRC_AI="$HOME/.zshrc_ai_tools"
cat << 'EOF' > "$ZSHRC_AI"
# AI Dev Box Configuration (Auto-Generated)

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
