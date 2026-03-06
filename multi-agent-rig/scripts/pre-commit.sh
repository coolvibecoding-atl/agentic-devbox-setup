#!/usr/bin/env bash
# Pre-commit hook: runs type-check and unit tests before allowing a commit
set -e

echo "🛡️ Pre-commit: Running quality gates..."

# Run TypeScript type check if tsconfig exists
if [ -f tsconfig.json ]; then
  echo "⚙️  Type check..."
  npx tsc --noEmit --skipLibCheck 2>&1 || { echo "❌ Type errors found. Fix before committing."; exit 1; }
  echo "✅ Types OK"
fi

# Run unit tests if a test config exists
if [ -f vitest.config.ts ] || [ -f vitest.config.js ]; then
  echo "⚙️  Unit tests..."
  npx vitest run --reporter=verbose 2>&1 || { echo "❌ Tests failed. Fix before committing."; exit 1; }
  echo "✅ Tests passed"
elif [ -f jest.config.js ] || [ -f jest.config.ts ]; then
  echo "⚙️  Tests (Jest)..."
  npx jest --passWithNoTests 2>&1 || { echo "❌ Tests failed."; exit 1; }
  echo "✅ Tests passed"
fi

# Biome lint check (fast)
if [ -f biome.json ]; then
  echo "⚙️  Linting (Biome)..."
  npx biome check --no-errors-on-unmatched . 2>&1 || { echo "❌ Lint errors. Run 'biome check --apply' to fix."; exit 1; }
  echo "✅ Lint passed"
elif [ -f .eslintrc* ] || [ -f eslint.config* ]; then
  echo "⚙️  Linting (ESLint)..."
  npx eslint . --max-warnings=20 2>&1 || { echo "❌ ESLint errors."; exit 1; }
  echo "✅ Lint passed"
fi

echo "✅ Pre-commit gate passed — committing!"
