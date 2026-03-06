#!/usr/bin/env bash
# install-precommit.sh
# Installs the rig's pre-commit hook into any git repo
# Usage: bash install-precommit.sh /path/to/project

set -e
PROJECT="${1:-$(pwd)}"

if [ ! -d "$PROJECT/.git" ]; then
  echo "❌ Not a git repository: $PROJECT"
  exit 1
fi

cp /Users/coolvibecoding/agentic-devbox-setup/multi-agent-rig/scripts/pre-commit.sh "$PROJECT/.git/hooks/pre-commit"
chmod +x "$PROJECT/.git/hooks/pre-commit"
echo "✅ Pre-commit hook installed in: $PROJECT"
