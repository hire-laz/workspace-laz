---
name: scrapling
description: Adaptive web scraping framework with anti-bot bypass capabilities. Uses StealthyFetcher for HTTP requests and DynamicFetcher for full browser automation. Handles Cloudflare Turnstile, cookies, proxies, and concurrent crawls.
---

# Scrapling — Advanced Web Scraping Framework

Use for scraping complex, dynamically-loaded, or bot-protected websites.

## Installation

```bash
python3 -m venv ~/.scrapling-env
source ~/.scrapling-env/bin/activate
pip install 'scrapling[all]'
python3 -m patchright install chromium
```

## Fetcher Types

### 1. StealthyFetcher (HTTP + Fingerprint Spoofing)
**Use:** Fast requests with anti-bot evasion, Cloudflare Turnstile bypass

```python
from scrapling.fetchers import StealthyFetcher

response = StealthyFetcher.fetch(
    'https://example.com',
    headless=True,
    network_idle=True,
    timeout=45000
)
title = response.css('title::text').get()
```

**Limitations:** Enterprise CF may still block. Requires valid session cookies for persistent access.

### 2. DynamicFetcher (Full Browser Automation)
**Use:** JavaScript execution, dynamic content, complex interactions

```python
from scrapling.fetchers import DynamicFetcher

response = DynamicFetcher.fetch(
    'https://example.com',
    headless=True,
    network_idle=True,
    timeout=60000
)
```

**Trade-off:** Slower than StealthyFetcher but handles complex pages.

### 3. Fetcher (HTTP requests only)
**Use:** Plain HTTP GET/POST, lightweight

```python
from scrapling.fetchers import Fetcher
response = Fetcher.fetch('https://example.com')
```

## Browser Fallback Flow

**When visiting a website:**

1. **Try Agent Browser** — Fast, lightweight, default
   - ✅ Works for most pages
   - ❌ Blocked by Cloudflare, PerimeterX, DataDome

2. **If blocked → Try Stealth Browser (Camoufox)** — Fingerprint spoofing
   - ✅ Bypasses basic anti-bot
   - ❌ Still blocked by enterprise Cloudflare

3. **If still blocked → Try Scrapling (StealthyFetcher/DynamicFetcher)** — Advanced evasion
   - ✅ Handles Cloudflare Turnstile (basic)
   - ❌ Enterprise CF (Interstitial Challenge) still requires human session or proxy

4. **If all fail → Proxy Service** (last resort)
   - Use Bright Data, Evomi, or similar for pre-validated HTTP requests

## Command-Line Usage

```bash
source ~/.scrapling-env/bin/activate

python3 << 'EOPYTHON'
from scrapling.fetchers import StealthyFetcher

response = StealthyFetcher.fetch('https://example.com', timeout=30000)
with open('output.txt', 'w') as f:
    f.write(response.text)
EOPYTHON
```

## Parsing (CSS Selectors)

```python
# Extract single element
title = response.css('title::text').get()

# Extract all matching
headings = response.css('h1::text, h2::text').getall()

# Clean text from element
body_text = '\n'.join(response.css('body *::text').getall())

# With adaptive learning
products = response.css('.product', adaptive=True)
```

## Enterprise Cloudflare Defense

**Problem:** Some sites use enterprise Cloudflare with Interstitial challenge + CAPTCHA + session validation.

**Solutions:**
1. Session Cookies — Grab cf_clearance, pass to fetcher
2. Proxy Service — Bright Data or similar handle CF server-side
3. Manual Intervention — Human visits, captures session, bot reuses it
4. Headless Proxy — Chrome behind residential proxy

**For blocked sites:** Document requirement, don't retry aggressively.

## Performance Tips

- Use StealthyFetcher before DynamicFetcher (3-5x faster)
- Set network_idle=True for dynamic pages
- timeout=45000ms for slow sites, 15000ms for fast ones
- Batch requests using Scrapling's spider concurrency
- Cache responses locally for iteration

## Known Limitations

| Blocker | StealthyFetcher | DynamicFetcher | Workaround |
|---|---|---|---|
| Basic Cloudflare | ✅ | ✅ | — |
| CF Turnstile | ✅ | ✅ | — |
| Enterprise CF | ❌ | ❌ | Proxy service |
| PerimeterX | ⚠ | ⚠ | Residential proxy |
| IP geolocation | ❌ | ❌ | Residential proxy |

## Test Results (2026-04-22)

Site: https://www.cholim.ph/b3-full-a (Cloudflare-protected)
- StealthyFetcher: ❌ Blocked (CF challenge, 307 → 403)
- DynamicFetcher: ❌ Blocked (61s load, CF challenge, no content)
- **Conclusion:** Enterprise Cloudflare Interstitial. Requires proxy or manual session.

---

## VPS Setup

Venv: `~/.scrapling-env/`
Browser: `~/.cache/ms-playwright/chromium_headless_shell-*/`

```bash
source ~/.scrapling-env/bin/activate && python3 script.py
```
