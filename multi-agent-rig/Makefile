# ============================================================
# MULTI-AGENT CODING RIG — Makefile
# ============================================================

.PHONY: up down restart logs status shell-openclaw shell-a0 shell-db index-workspace clean help

# Start the full stack
up:
	@echo "🦞 Starting Multi-Agent Coding Rig..."
	@cp -n .env.example .env 2>/dev/null || true
	docker compose up -d
	@echo "✅ Stack started. OpenClaw at http://localhost:18789"
	@echo "   Agent Zero at http://localhost:8080"
	@echo "   ChromaDB at http://localhost:8001"

# Stop all services
down:
	@echo "🛑 Stopping Multi-Agent Coding Rig..."
	docker compose down

# Restart all services
restart:
	docker compose restart

# Follow logs from all services
logs:
	docker compose logs -f --tail=100

# Show status of all services
status:
	docker compose ps

# Shell into the OpenClaw container
shell-openclaw:
	docker compose exec openclaw sh

# Shell into the Agent Zero container
shell-a0:
	docker compose exec agent-zero bash

# Shell into the Postgres database
shell-db:
	docker compose exec postgres psql -U agentrig agentrig

# Trigger a fresh workspace index in ChromaDB
index-workspace:
	@echo "📚 Indexing workspace into ChromaDB..."
	docker compose restart workspace-indexer

# Backup all agent state, DB, and Chroma vectors
backup:
	@echo "📦 Backing up agent state and databases..."
	@mkdir -p backups
	@tar -czf backups/rig-backup-$$(date +%Y%m%d%H%M%S).tar.gz ~/.openclaw/agents/ postgres-data/ chromadb-data/
	@echo "✅ Backup complete in backups/"

# Restore agent state (Requires FILE=backups/...)
restore:
	@if [ -z "$$FILE" ]; then echo "❌ Error: Must specify FILE (e.g., make restore FILE=backups/rig-backup-xxx.tar.gz)"; exit 1; fi
	@echo "⚠️  Restoring will overwrite current state."
	@read -p "Are you sure? [y/N] " ans && [ "$$ans" = "y" ] || exit 1
	@tar -xzf $$FILE -C /
	@echo "✅ Restore complete. Please restart OpenClaw."

# Wipe all volumes (DESTRUCTIVE — removes all stored state)
clean:
	@echo "⚠️  This will delete ALL volumes including workspace data."
	@read -p "Are you sure? [y/N] " ans && [ "$$ans" = "y" ] || exit 1
	docker compose down -v
	@echo "✅ Volumes wiped."

# Show available commands
help:
	@echo ""
	@echo "🦞 Multi-Agent Coding Rig Commands"
	@echo "─────────────────────────────────────"
	@echo "  make up              — Start all services"
	@echo "  make down            — Stop all services"
	@echo "  make restart         — Restart all services"
	@echo "  make logs            — Follow all logs"
	@echo "  make status          — Show container status"
	@echo "  make shell-openclaw  — Shell into OpenClaw"
	@echo "  make shell-a0        — Shell into Agent Zero"
	@echo "  make shell-db        — Postgres CLI"
	@echo "  make index-workspace — Re-index codebase in ChromaDB"
	@echo "  make backup          — Backup agent configurations and databases"
	@echo "  make restore         — Restore from backup (FILE=...)"
	@echo "  make clean           — DESTROY all volumes (careful!)"
	@echo ""
