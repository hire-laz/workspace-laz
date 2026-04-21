#!/usr/bin/env python3
"""
stealth-browse.py — Camoufox stealth browser for anti-bot bypass
Usage: python3 stealth-browse.py <url> [screenshot_path]

Uses Camoufox (Firefox + C++-level fingerprint spoofing) to bypass
bot detection on X, YouTube, Cloudflare, etc.
"""

import sys
import time
from camoufox.sync_api import Camoufox

def stealth_browse(url: str, screenshot_path: str = None, text_only: bool = False):
    print(f"[stealth] Opening: {url}", file=sys.stderr)

    with Camoufox(headless=True) as browser:
        page = browser.new_page()

        # Navigate
        page.goto(url, timeout=30000)

        # Wait for content
        try:
            page.wait_for_load_state("networkidle", timeout=10000)
        except Exception:
            # Timeout is okay — grab what we have
            time.sleep(2)

        # Get page title to verify
        title = page.title()
        current_url = page.url
        print(f"[stealth] Title: {title}", file=sys.stderr)
        print(f"[stealth] URL: {current_url}", file=sys.stderr)

        # Screenshot
        if screenshot_path:
            page.screenshot(path=screenshot_path, full_page=False)
            print(f"[stealth] Screenshot: {screenshot_path}", file=sys.stderr)

        # Text content
        if text_only:
            text = page.evaluate("() => document.body.innerText")
            print(text)
        else:
            # Print page title + URL to stdout
            print(f"Title: {title}")
            print(f"URL: {current_url}")

        return title, current_url


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: stealth-browse.py <url> [screenshot_path]")
        sys.exit(1)

    url = sys.argv[1]
    screenshot = sys.argv[2] if len(sys.argv) > 2 else None

    stealth_browse(url, screenshot_path=screenshot)
