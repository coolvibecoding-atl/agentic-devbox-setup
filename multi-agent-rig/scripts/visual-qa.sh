#!/usr/bin/env bash
# scripts/visual-qa.sh 
# Enhancement #9: Visual QA via Antigravity screenshot analysis

set -e
URL="${1:-http://localhost:18789}"
OUT_FILE="/tmp/qa-screenshot-$(date +%s).png"

echo "📸 Capturing full-page screenshot of $URL ..."
# Uses playwright to snapshot the app
npx playwright screenshot --full-page "$URL" "$OUT_FILE" 2>/dev/null || {
  # Fallback if playwright isn't initialized yet
  echo "⚠️ Playwright not installed. Please initialize playwright to use visual QA."
  exit 1
}

echo "🧠 Analyzing screenshot with Antigravity (Gemini Vision)..."
# Pass the image to Antigravity 
antigravity -p "You are an elite UX/UI design director. Review this screenshot against 2026 design standards (dark mode primary, rich layered depth, modern typography). STRICTLY identify any visual bugs, poor contrast, misalignments, or WCAG 2.2 accessibility failures. Reply with a short markdown checklist of defects." -m "$OUT_FILE"

echo "✅ Visual QA Complete"
rm -f "$OUT_FILE"
