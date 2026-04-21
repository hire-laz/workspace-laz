#!/usr/bin/env bash
# ph-browse.sh — Open a URL with Philippines locale applied
# Usage: ph-browse.sh <url> [screenshot_path]
# Requires: AGENT_BROWSER_ARGS="--no-sandbox" in env or passed here

set -e

URL="${1:?Usage: ph-browse.sh <url> [screenshot_path]}"
SCREENSHOT="${2:-}"

# Ensure no-sandbox flag is set
export AGENT_BROWSER_ARGS="${AGENT_BROWSER_ARGS:---no-sandbox}"

# Close any running session and start fresh
agent-browser close --all 2>/dev/null || true
sleep 1

# Open and configure
agent-browser open "$URL"
agent-browser set geo 14.5995 120.9842
agent-browser set headers '{"Accept-Language":"en-PH,en;q=0.9,fil;q=0.8"}'
agent-browser set viewport 1366 768

if [[ -n "$SCREENSHOT" ]]; then
  sleep 1
  agent-browser screenshot "$SCREENSHOT"
  echo "✓ Screenshot: $SCREENSHOT"
fi
