---
name: slides
description: Create presentation slide decks — either as a shareable PDF (default) or as a live hosted Reveal.js presentation. Use when asked to create slides, a pitch deck, a presentation, or any multi-slide visual content. Default output is PDF (landscape) unless the user explicitly says "web" or "host it". Triggers on "create a slide deck", "make a presentation", "build a pitch deck", "franchise slides", "keynote", etc.
---

# Slides Skill

Creates professional slide decks in two modes:

- **`pdf` (default)** — HTML → landscape PDF, sendable via Telegram
- **`web`** — Reveal.js presentation (hosted or delivered as a folder)

## When to Use Which Mode

| Situation | Mode |
|-----------|------|
| "Create slides" / "make a deck" | **pdf** (default) |
| "Send me the slides" / "share the deck" | **pdf** |
| "Host it" / "I want to present live" / "put it on the site" | **web** |
| Explicit: "web mode" / "Reveal.js" | **web** |

---

## Mode: PDF (Default)

### How It Works
Build a self-contained HTML file with fixed-size slides, then render via `pdf-creator`.

### Slide Dimensions
- **Canvas:** `1122px × 794px` per slide (A4 landscape)
- Each slide is a `.page` div with `width: 1122px; height: 794px; overflow: hidden`
- **Critical:** Use `height: 794px` (fixed), NEVER `min-height` — `min-height` causes blank white space at the bottom of every slide

### HTML Template Pattern
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700;900&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { background: #f0f0f0; }
    .page {
      width: 1122px;
      height: 794px;
      overflow: hidden;
      background: #ffffff;
      position: relative;
      /* Add margin for visual separation when previewing */
      margin: 20px auto;
    }
  </style>
</head>
<body>
  <div class="page">
    <!-- Slide 1 content — fills exactly 794px tall -->
  </div>
  <div class="page">
    <!-- Slide 2 content -->
  </div>
</body>
</html>
```

### Rendering Command
```bash
node ~/.openclaw/workspace/skills/pdf-creator/scripts/html_to_pdf.js \
  ~/Documents/<deck>.html \
  ~/Documents/<deck>.pdf \
  --format=A4 --landscape --margin=0px
```

Always use `--landscape --margin=0px` for slide decks.

### Sending the PDF
```bash
cp ~/Documents/<deck>.pdf ~/.openclaw/media/<deck>.pdf
# then use: message(filePath="/home/<user>/.openclaw/media/<deck>.pdf")
```

---

### ⚠️ Critical Gotchas — PDF Slides

#### 1. NEVER use emojis as icons
Emojis do NOT render in Chrome's PDF engine on Linux — they show as blank boxes.

**Always use inline SVG icons instead:**
```html
<!-- ✅ Correct — inline SVG -->
<svg viewBox="0 0 24 24" fill="none" stroke="#1A73E8" stroke-width="2"
     stroke-linecap="round" stroke-linejoin="round" width="20" height="20">
  <polyline points="20 6 9 17 4 12"/>
</svg>

<!-- ❌ Wrong — emoji -->
✅ ⚡ 🎯
```

Good SVG icon sources: **Heroicons**, **Feather Icons**, **Lucide** — all MIT licensed, copy path data inline.

**Also never use icon fonts** (Material Symbols, FontAwesome) in PDFs — they may not fully load before Playwright captures the page. Always inline SVG.

#### 2. Fixed height, no min-height
```css
/* ✅ Correct */
.page { width: 1122px; height: 794px; overflow: hidden; }

/* ❌ Wrong — causes blank white space at bottom */
.page { width: 1122px; min-height: 794px; }
```

#### 3. No `justify-content: space-between` on full-height flex columns
It stretches sections apart and creates dead space. Use `gap` or `justify-content: center` instead.

#### 4. Always pass `--landscape`
Without `--landscape`, the PDF renders portrait (595×842px) — slides get cut in half with a blank bottom.

#### 5. Google Fonts load fine
The pdf-creator script spins up a local HTTP server — Google Fonts, images, and relative assets all load correctly. Never use `file://` directly.

---

### Layout Best Practices

**Split layout (two columns):**
```css
.page {
  display: grid;
  grid-template-columns: 45% 55%;
  height: 794px;
}
```

**Content-heavy single-column slide:**
```css
.page {
  padding: 50px 60px;
  display: flex;
  flex-direction: column;
  height: 794px;
}
.content { flex: 1; } /* middle section stretches to fill */
```

**Recommended font pairings:**
- Montserrat (headings, bold) + Inter (body) — clean and professional
- Fraunces (editorial headings) + Inter (body) — premium feel

---

## Mode: Web (Reveal.js)

### Quick Start Template
```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js/dist/reveal.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js/dist/theme/white.css">
  <link href="https://fonts.googleapis.com/css2?family=Fraunces:wght@700;900&family=Inter:wght@400;600&family=Caveat:wght@600&display=swap" rel="stylesheet">
  <style>
    .reveal h1, .reveal h2 { font-family: 'Fraunces', serif; }
    .reveal p, .reveal li { font-family: 'Inter', sans-serif; }
  </style>
</head>
<body>
  <div class="reveal">
    <div class="slides">
      <section>
        <h1>Slide Title</h1>
        <p>Subtitle or content</p>
      </section>
      <section>
        <h2>Second Slide</h2>
        <ul>
          <li>Point one</li>
          <li>Point two</li>
        </ul>
      </section>
    </div>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/reveal.js/dist/reveal.js"></script>
  <script>
    Reveal.initialize({
      width: 1920,
      height: 1080,
      hash: true,
      transition: 'slide'
    });
  </script>
</body>
</html>
```

### Hosting Options
- Serve the folder as a static site (Caddy, Nginx, Vercel, GitHub Pages)
- Or just zip the folder and send as a file — recipients open `index.html` in browser

### Reveal.js Design Tips
- Use `<section data-background-color="#1A73E8">` for colored slides
- Nest `<section>` inside `<section>` for vertical slide groups
- `data-auto-animate` on consecutive sections for smooth element transitions
- Speaker notes: `<aside class="notes">Your notes here</aside>`

---

## Branding Note

This skill is **branding-agnostic**. Layout patterns, technical gotchas, and output modes are captured here — not brand palettes. Always source brand colors, logos, and fonts from the client brief or existing site before building.
