---
name: agent-browser-ph
description: Browser automation via agent-browser CLI (Vercel agent-browser). Use for ALL web browsing tasks — visiting websites, taking screenshots, scraping content, clicking, filling forms, navigation. Configured with Philippines locale settings (language headers, geolocation Manila, timezone GMT+8). Use this as the default browser for all web tasks. Always set AGENT_BROWSER_ARGS="--no-sandbox" on this VPS.
---

# Agent Browser (Philippines Profile)

Use `agent-browser` CLI for all browsing tasks. Default browser for all web tasks.

**Important:** Always run with `AGENT_BROWSER_ARGS="--no-sandbox"` on this VPS. The `--no-sandbox` flag is required due to Linux kernel restrictions.

## VPS Note

Server IP resolves to Germany (DE). IP-based geolocation on sites like Google will show DE regardless. We apply max Philippines signals without a proxy: Accept-Language header (en-PH), Manila coordinates, and GMT+8 timezone.

## Session Start (apply every new session)

```bash
agent-browser close --all 2>/dev/null; sleep 1
AGENT_BROWSER_ARGS="--no-sandbox" agent-browser open <url>
agent-browser set geo 14.5995 120.9842
agent-browser set headers '{"Accept-Language":"en-PH,en;q=0.9,fil;q=0.8"}'
agent-browser set viewport 1366 768
```

If browser is already running (daemon up), skip the close/open and just set headers/geo.

## Core Commands

```bash
agent-browser open <url>                      # Navigate to URL
agent-browser snapshot                         # Get accessibility tree (best for reading page)
agent-browser screenshot [path.png]            # Screenshot (saves to tmp dir if no path)
agent-browser screenshot --full [path.png]     # Full-page screenshot
agent-browser click <sel|@ref>                 # Click element
agent-browser fill <sel|@ref> <text>           # Fill input
agent-browser scroll down [px]                 # Scroll
agent-browser get text <sel>                   # Extract text
agent-browser get title                        # Get page title
agent-browser get url                          # Get current URL
agent-browser close                            # Close browser
agent-browser close --all                      # Close all sessions
```

## Screenshot & Show Workflow

```bash
# 1. Navigate (new session):
agent-browser close --all 2>/dev/null; sleep 1
AGENT_BROWSER_ARGS="--no-sandbox" agent-browser open https://example.com
agent-browser set geo 14.5995 120.9842
agent-browser set headers '{"Accept-Language":"en-PH,en;q=0.9,fil;q=0.8"}'
agent-browser set viewport 1366 768

# 2. Screenshot:
agent-browser screenshot /home/laz/.openclaw/workspace/screenshots/name.png

# 3. Show to Cho:
# MEDIA:/home/laz/.openclaw/workspace/screenshots/name.png
```

## Philippines Locale Details

| Setting | Value |
|---|---|
| Geolocation | 14.5995°N, 120.9842°E (Manila) |
| Accept-Language | en-PH,en;q=0.9,fil;q=0.8 |
| Timezone | GMT+8 (Asia/Manila) |
| Viewport | 1366x768 |

## Silent Recovery

If any browser command fails with "auto-launch failed" or connection error:
```bash
agent-browser close --all 2>/dev/null
sleep 1
AGENT_BROWSER_ARGS="--no-sandbox" agent-browser open <last-url>
agent-browser set geo 14.5995 120.9842
agent-browser set headers '{"Accept-Language":"en-PH,en;q=0.9,fil;q=0.8"}'
agent-browser set viewport 1366 768
```
Then retry the original command. Do this silently without announcing it to Cho.

## Batch Mode

```bash
# Use individual commands (not batch) for reliability — batch has JSON escaping quirks
```
