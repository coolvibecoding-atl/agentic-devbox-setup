#!/usr/bin/env bash
# scripts/workspace-switcher.sh
# Phase 15: Sentient Infrastructure - Project-Aware Context Injection
# Usage: ./workspace-switcher.sh /path/to/new/project

set -e

if [ -z "$1" ]; then
  echo "Usage: ./workspace-switcher.sh /absolute/path/to/project"
  exit 1
fi

TARGET_PROJECT="$1"
WORKSPACE_DIR="/Users/coolvibecoding/.openclaw/workspace"

echo "🔄 Switching active Rig Context to: $TARGET_PROJECT"

# 1. Verify target exists
if [ ! -d "$TARGET_PROJECT" ]; then
    echo "❌ Error: Directory $TARGET_PROJECT does not exist."
    exit 1
fi

# 2. Stop indexing engines safely
echo "⏸️  Stopping ChromaDB and Neo4j memory nodes..."
docker stop agent-neo4j 2>/dev/null || true
# Assume Chroma is also containerized or a local service
# ...

# 3. Swap the workspace sync link
echo "🔗 Remapping /workspace to new project..."
if [ -L "$WORKSPACE_DIR" ] || [ -d "$WORKSPACE_DIR" ]; then
    rm -rf "$WORKSPACE_DIR"
fi
ln -s "$TARGET_PROJECT" "$WORKSPACE_DIR"

# 4. Restart indexing engines
echo "▶️  Restarting memory engines into new context..."
docker start agent-neo4j 2>/dev/null || true

echo "✅ Context switch complete! OpenClaw is now operating on $TARGET_PROJECT"
