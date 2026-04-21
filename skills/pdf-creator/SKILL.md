---
name: pdf-creator
description: Generate professional PDF files from HTML. Use when asked to create invoices, reports, proposals, pitch decks, certificates, or any document that needs to be exported as a PDF. Handles Google Fonts, background colors, images, and multi-page layouts correctly. Triggers on "create a PDF", "generate an invoice", "export to PDF", "make a report as PDF", etc.
---

# PDF Creator

Generate pixel-perfect PDFs from HTML using Playwright + Chrome.

## Quick Usage

```bash
node ~/.openclaw/workspace/skills/pdf-creator/scripts/html_to_pdf.js <input.html> <output.pdf>
# Options:
#   --format=A4       (default: A4, also Letter, Legal, etc.)
#   --margin=12px     (default: 12px, applied to all sides)
#   --landscape       (add this flag for landscape output, e.g., slide decks)
```

**Full example — portrait document:**
```bash
node ~/.openclaw/workspace/skills/pdf-creator/scripts/html_to_pdf.js \
  ~/Documents/invoice.html \
  ~/Documents/invoice.pdf
```

**Full example — landscape (slide deck, pitch deck):**
```bash
node ~/.openclaw/workspace/skills/pdf-creator/scripts/html_to_pdf.js \
  ~/Documents/deck.html \
  ~/Documents/deck.pdf \
  --landscape --margin=0px
```

## Workflow

1. **Write the HTML** — build a self-contained HTML file (inline CSS or `<link>` Google Fonts)
2. **Save to `~/Documents/`** — always save generated files here per workspace rules
3. **Run the script** — `node ~/.openclaw/workspace/skills/pdf-creator/scripts/html_to_pdf.js input.html output.pdf`
4. **Copy to media** — copy to `~/.openclaw/media/` before sending via `message` tool
5. **Send** — use `message(filePath="/home/<user>/.openclaw/media/file.pdf")`

## Design Best Practices

### Layout
- Max page width: `780px` centered on a slightly darker background
- Use CSS Grid for columns (billing info, line items, totals)
- Keep `box-sizing: border-box` on everything
- For invoices: header → meta row → bill-to/from → line items → totals → notes → footer

### Invoices specifically
- Show original price with `text-decoration: line-through` for discounts
- Use a colored badge for discount labels
- Totals section: subtotal → discount (negative, colored) → tax → **Total Due** (large, accent color)
- Recurring billing: highlight the recurrence date clearly in a dedicated callout box

### Fonts & Styling
- Load fonts via Google Fonts `<link>` (script handles HTTP serving)
- Common pairs: Montserrat (headings) + Inter (body), or Fraunces (editorial) + Inter (body)
- Always inline CSS or use `<link>` for fonts — no external stylesheets that won't load

---

## ⚠️ Critical Gotchas

### The footer URL problem (most common issue)
**Never** use `google-chrome --print-to-pdf-no-header` — Chrome still prints the localhost URL
(e.g., `http://127.0.0.1:9876/file.html`) in the PDF footer regardless of that flag.

**Always** use `html_to_pdf.js` which sets `displayHeaderFooter: false` in Playwright's `page.pdf()`.

### Google Fonts require HTTP
`file://` protocol blocks external requests — Google Fonts won't load.
The script automatically spins up a local HTTP server to serve the HTML,
so fonts, images, and relative assets all load correctly. Never open HTML as `file://` for PDF export.

### Playwright-core location
```
~/.nvm/versions/node/<VERSION>/lib/node_modules/openclaw/node_modules/playwright-core
```
(Or wherever openclaw is installed on your system.)
Do NOT use the global `playwright` package — use openclaw's bundled `playwright-core`.

### Chrome executable
```
/usr/bin/google-chrome
```
(The system Chrome, not Playwright-managed Chromium. Must be installed.)

### Sending PDFs via `message` tool
`~/Documents/` is NOT an allowed `filePath` directory for the message tool.
Always copy to `~/.openclaw/media/` first:
```bash
cp ~/Documents/file.pdf ~/.openclaw/media/file.pdf
# then: message(filePath="/home/<user>/.openclaw/media/file.pdf")
```

---

## ⚠️ NEVER use emoji or icon fonts in PDFs

**Emoji characters** (🔴🟡🟢⚠️📊✓↑👥 etc.) do NOT render — they show as empty boxes.
**Icon fonts** (Material Symbols, FontAwesome) may not fully load before Playwright captures the page.

**Always use inline SVG icons instead:**
```html
<!-- Instead of: ✓ or <i class="icon-check"></i> -->
<!-- Use: -->
<svg viewBox="0 0 24 24" fill="none" stroke="#1A73E8" stroke-width="2" 
     stroke-linecap="round" stroke-linejoin="round" width="18" height="18">
  <polyline points="20 6 9 17 4 12"/>
</svg>
```

**Good SVG icon sources (MIT licensed):**
- Heroicons (https://heroicons.com)
- Feather Icons (https://feathericons.com)
- Lucide (https://lucide.dev)

Copy the path data inline into your HTML.
