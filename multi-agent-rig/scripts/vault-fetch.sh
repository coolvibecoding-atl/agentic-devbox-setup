#!/usr/bin/env bash
# scripts/vault-fetch.sh
# Phase 15: Sentient Infrastructure - Secret Vault Integration
#
# Prevents API keys from being hardcoded by dynamically querying 1Password CLI (op)
# Usage: ./vault-fetch.sh <secret-reference>

set -e

SECRET_REF="$1"

if [ -z "$SECRET_REF" ]; then
    echo "Usage: ./vault-fetch.sh 'op://DevWorkspace/AnthropicAPI/credential'"
    exit 1
fi

# Ensures 1Password CLI is available
if ! command -v op &> /dev/null; then
    echo "❌ Error: 1Password CLI 'op' is not installed or not in PATH."
    exit 1
fi

# Attempt to fetch the secret
# Example: op read "op://Private/Anthropic/credential"
SECRET_VAL=$(op read "$SECRET_REF" 2>/dev/null)

if [ -z "$SECRET_VAL" ]; then
    echo "❌ Error: Could not fetch secret for $SECRET_REF. Are you authenticated (eval \$(op signin))?"
    exit 1
fi

# Return the exact string (used by openclaw.json or docker-compose)
echo -n "$SECRET_VAL"
