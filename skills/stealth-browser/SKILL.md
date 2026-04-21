---
name: stealth-browser
description: Stealth browser for bypassing anti-bot systems (Cloudflare, X/Twitter, YouTube, etc). Use as fallback when agent-browser-ph gets blocked. Built on Camoufox — Firefox with C++-level fingerprint spoofing, human-like mouse movement, WebGL/WebRTC spoofing. Triggered when: page shows CAPTCHA, bot detection, access denied, or empty content when agent-browser should work. Uses Python + Playwright API.
---

# Stealth Browser — Camoufox Anti-Bot Fallback

Use when `agent-browser` gets blocked. Camoufox is a Firefox fork with fingerprint injection at the C++ level — undetectable by JS inspection.

## When to Switch to This

- agent-browser gets CAPTCHA, "Access Denied", or blank page
- X (Twitter), YouTube, Cloudflare pages returning bot errors
- Any site with aggressive anti-bot (Distil, PerimeterX, DataDome, etc)

## Setup

Camoufox is installed in a venv at `~/.camoufox-env/`.

```bash
# Verify installed
~/.camoufox-env/bin/python -c "import camoufox; print('OK')"

# Re-fetch browser if needed
~/.camoufox-env/bin/python -m camoufox fetch
```

## Basic Usage

```python
from camoufox.sync_api import Camoufox

with Camoufox(headless=True) as browser:
    page = browser.new_page()
    page.goto("https://x.com/username/status/123")
    content = page.content()
    print(content)
```

## Screenshot a URL

```python
from camoufox.sync_api import Camoufox

with Camoufox(headless=True) as browser:
    page = browser.new_page()
    page.goto("https://example.com")
    page.wait_for_load_state("networkidle")
    page.screenshot(path="/home/laz/Documents/stealth-shot.png", full_page=True)
```

## Philippines Locale (Apply Always)

```python
with Camoufox(
    headless=True,
    geoip=True,                          # auto-detect from IP
    locale="en-PH",
    timezone="Asia/Manila",
    config={
        "navigator.language": "en-PH",
        "navigator.languages": ["en-PH", "en"],
    }
) as browser:
    page = browser.new_page()
    page.goto("https://example.com")
```

## Get Page Text / Snapshot

```python
with Camoufox(headless=True) as browser:
    page = browser.new_page()
    page.goto("https://x.com/user/status/123")
    page.wait_for_load_state("networkidle")
    # Get all visible text
    text = page.evaluate("() => document.body.innerText")
    print(text)
```

## Run via Helper Script

```bash
~/.camoufox-env/bin/python \
  ~/.openclaw/workspace/skills/stealth-browser/scripts/stealth-browse.py \
  "https://x.com/user/status/123" \
  /home/laz/Documents/output.png
```

## Key Flags

| Flag | Purpose |
|---|---|
| `headless=True` | Headless mode (VPS-safe) |
| `headless="virtual"` | Virtual display (better stealth) |
| `geoip=True` | Auto-set geo from IP |
| `locale="en-PH"` | Language/locale |
| `timezone="Asia/Manila"` | Timezone spoof |
| `os="linux"` | Force OS fingerprint |
| `block_images=True` | Skip image loading (faster) |

## Camoufox vs agent-browser

| Feature | agent-browser | Camoufox |
|---|---|---|
| Protocol | CDP (Chromium) | Juggler (Firefox) |
| Fingerprint | Default Chrome | Rotated, realistic |
| Anti-bot evasion | Basic | Strong (C++ level) |
| Speed | Faster | Slightly slower |
| Bot detection | Gets blocked | Bypasses most |
| Use case | Default browsing | Fallback for blocked sites |

## Notes

- Camoufox binary: `~/.cache/camoufox/`
- Python venv: `~/.camoufox-env/`
- Current installed: v0.4.11 (browser v135.0.1-beta.24)
- 2026 note: Active redevelopment phase — may have some fingerprint inconsistencies
- Does NOT fix IP-based geolocation (still German IP) — need proxy for that
