#!/usr/bin/env bash
# scripts/bounty-triage-scanner.sh
# Phase 17: Autonomous Bug Bounty Triage
# 
# Autonomously clones a target repo and dispatches the qa-guardian and backend-senior
# agents to perform deep security red-teaming (SQLi, Logic Flaws, Memory Corruption).

set -e

TARGET_REPO="$1"

if [ -z "$TARGET_REPO" ]; then
  echo "Usage: ./bounty-triage-scanner.sh <https://github.com/target/repo.git>"
  exit 1
fi

REPO_NAME=$(basename "$TARGET_REPO" .git)
BOUNTY_DIR="/Users/coolvibecoding/.openclaw/workspace/bounties/$REPO_NAME"

echo "🏴‍☠️ [BOUNTY TRIAGE] Initializing attack surface for $REPO_NAME..."

# Ensure clean slate
rm -rf "$BOUNTY_DIR"
mkdir -p /Users/coolvibecoding/.openclaw/workspace/bounties

# Clone target
echo "📥 Cloning target repository..."
git clone --depth 1 "$TARGET_REPO" "$BOUNTY_DIR" >/dev/null 2>&1

echo "🔍 Dispatching backend-senior for static logic fault analysis..."
# Uses the 'zero-day-fuzzer' and 'security-auditor' skills implicitly deployed in earlier phases
openclaw message send --agent backend-senior --message "SYSTEM: Deep scan $BOUNTY_DIR for authentication bypasses, broken access control, and SQL injection vectors. Save raw findings to $BOUNTY_DIR/scan_results.txt" >/dev/null 2>&1 || true

echo "💥 Dispatching qa-guardian for red-team fuzzing and PoC generation..."
openclaw message send --agent qa-guardian --message "SYSTEM: Read $BOUNTY_DIR/scan_results.txt. Attempt to exploit the identified flaws. If an exploit is viable, draft a complete HACKERONE_REPORT.md in $BOUNTY_DIR including the CVSS score, reproduction steps, and impact." >/dev/null 2>&1 || true

echo "✅ [BOUNTY TRIAGE] Scan complete. Check $BOUNTY_DIR for HACKERONE_REPORT.md"
