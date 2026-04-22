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
      margin: 0;                  /* NEVER use margin: 20px auto — pushes slides past PDF boundary */
      page-break-after: always;  /* Ensures clean page breaks in PDF export */
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

#### 2. Fixed height, no min-height, NO MARGINS
```css
/* ✅ Correct */
.page { width: 1122px; height: 794px; overflow: hidden; }

/* ❌ Wrong — causes blank white space or overflow */
.page { width: 1122px; min-height: 794px; }              /* min-height = bad */
.page { width: 1122px; height: 794px; margin: 20px auto; } /* margin = PDF bleed-through */
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

---

## Default Design Style (Studio Shodwe Fitness Theme)

This is the **default visual style** for all slides unless Cho explicitly overrides it.

### Color Palette
```
Background:       #080808  (near-black, slightly off pure black)
Primary Accent:   #E11D1D  (vivid crimson red — headers, badges, borders, ribbons)
Dark Red:         #B81217  (shaded red for ribbon sides, gradients)
Primary Text:     #FFFFFF  (white — body copy, secondary headlines)
Off-white:        #F2F2F2  (body paragraph text, slightly softer)
Decorative:       #FFFFFF  (hexagon wireframes, node dots, connector lines)
```

### Typography
- **Headings:** `Bebas Neue` (condensed, all-caps, heavy) — or `Anton` as fallback
- **Body:** `Poppins` (clean humanist sans, 400–500 weight, sentence case) — or `Montserrat` as fallback
- **Google Fonts import:**
  ```html
  <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
  ```
- **Headline size:** 70–110px (black/900 weight), all-caps, tight tracking (`letter-spacing: -0.5px`)
- **Subhead size:** 48–70px
- **Body size:** 18–24px, line-height 1.7
- **Tag labels:** 18–22px, bold, white on red

### Headline Color Split Pattern
Titles use a **two-color alternating split** — white main line, red emphasis word:
```html
<!-- Always split headlines like this -->
<h1 style="font-family:'Bebas Neue'; font-size:90px; line-height:1; margin:0;">
  <span style="color:#FFFFFF;">BENEFITS OF A FITNESS</span><br>
  <span style="color:#E11D1D;">LIFESTYLE</span>
</h1>
```

### Slide Layouts

#### Cover Slide
- Left half: brand logo top-left, giant headline stack (red/white/red), subtitle text, presenter ribbon at bottom-left
- Right half: hero image in a **red hexagon frame** (thick `#E11D1D` border, hexagon clip-path)
- Corners: white hexagon wireframe network (top-right, bottom-right)

#### Content Slide (Image + Text)
- Left: athlete/subject image in **thick red rectangular border** (`border: 6px solid #E11D1D`)
- Right: two-color headline, connector line + nodes, body paragraph
- Top-left corner: red dot burst pattern
- Top-right: white hexagon wireframe

#### List / Benefits Slide
- Large two-color headline top-left
- Paragraph block below
- Bottom row: 2–3 **red angled-tab benefit chips** (angled ends, white check SVG icon + label)

#### Detail / Section Cards Slide
- 2–3 stacked content modules
- Each module: thin red border box (`border: 1.5px solid #E11D1D`), red angled tab label at top-left, body text inside

### Decorative Elements CSS

```css
/* Hexagon wireframe corner — top-right */
.hex-decor-tr {
  position: absolute;
  top: 0; right: 0;
  width: 220px; height: 180px;
  background-image: url("data:image/svg+xml,..."); /* see SVG below */
  opacity: 0.7;
}

/* Red dot burst — top-left */
.dot-burst-tl {
  position: absolute;
  top: 0; left: 0;
  width: 120px; height: 120px;
  background: radial-gradient(circle, #E11D1D 1.5px, transparent 1.5px) 0 0 / 10px 10px;
  opacity: 0.6;
}

/* Connector line with nodes (under headline) */
.connector {
  display: flex;
  align-items: center;
  gap: 6px;
  margin: 8px 0 20px;
}
.connector-dot-red { width:10px; height:10px; border-radius:50%; background:#E11D1D; }
.connector-line { flex:1; height:1.5px; background:#FFFFFF; max-width:180px; }
.connector-dot-white { width:10px; height:10px; border-radius:50%; background:#FFFFFF; }
```

**Hexagon wireframe SVG (inline — use as absolute positioned element):**
```html
<!-- Top-right corner decor -->
<svg style="position:absolute;top:0;right:0;opacity:0.55;" width="230" height="200" viewBox="0 0 230 200" fill="none" xmlns="http://www.w3.org/2000/svg">
  <!-- Large hexagon -->
  <polygon points="170,10 220,40 220,100 170,130 120,100 120,40" stroke="white" stroke-width="1.5" fill="none"/>
  <!-- Medium hexagon -->
  <polygon points="110,60 145,80 145,120 110,140 75,120 75,80" stroke="white" stroke-width="1.5" fill="none"/>
  <!-- Small hexagon -->
  <polygon points="40,100 65,115 65,145 40,160 15,145 15,115" stroke="white" stroke-width="1.5" fill="none"/>
  <!-- Node dots -->
  <circle cx="220" cy="100" r="4" fill="white"/>
  <circle cx="120" cy="40" r="3" fill="white"/>
  <circle cx="75" cy="80" r="3" fill="white"/>
  <circle cx="15" cy="145" r="2.5" fill="white"/>
  <!-- Connector lines -->
  <line x1="120" y1="40" x2="75" y2="80" stroke="white" stroke-width="1" stroke-dasharray="3,3" opacity="0.5"/>
  <line x1="75" y1="120" x2="40" y2="100" stroke="white" stroke-width="1" stroke-dasharray="3,3" opacity="0.5"/>
</svg>
```

**Red dot burst SVG (top-left corner):**
```html
<!-- Top-left dot burst -->
<div style="position:absolute;top:0;left:0;width:130px;height:130px;overflow:hidden;opacity:0.65;">
  <svg width="200" height="200" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
    <!-- Dot grid that fades outward -->
    <defs>
      <radialGradient id="dotFade" cx="0" cy="0" r="70%">
        <stop offset="0%" stop-color="#E11D1D" stop-opacity="1"/>
        <stop offset="100%" stop-color="#E11D1D" stop-opacity="0"/>
      </radialGradient>
    </defs>
    <!-- Rows of red dots -->
    <circle cx="10" cy="10" r="2.5" fill="#E11D1D"/>
    <circle cx="25" cy="10" r="2" fill="#E11D1D" opacity="0.85"/>
    <circle cx="40" cy="10" r="1.5" fill="#E11D1D" opacity="0.6"/>
    <circle cx="55" cy="10" r="1" fill="#E11D1D" opacity="0.4"/>
    <circle cx="10" cy="25" r="2" fill="#E11D1D" opacity="0.85"/>
    <circle cx="25" cy="25" r="2" fill="#E11D1D" opacity="0.75"/>
    <circle cx="40" cy="25" r="1.5" fill="#E11D1D" opacity="0.5"/>
    <circle cx="55" cy="25" r="1" fill="#E11D1D" opacity="0.3"/>
    <circle cx="10" cy="40" r="1.5" fill="#E11D1D" opacity="0.6"/>
    <circle cx="25" cy="40" r="1.5" fill="#E11D1D" opacity="0.5"/>
    <circle cx="40" cy="40" r="1" fill="#E11D1D" opacity="0.35"/>
    <circle cx="10" cy="55" r="1" fill="#E11D1D" opacity="0.4"/>
    <circle cx="25" cy="55" r="1" fill="#E11D1D" opacity="0.3"/>
    <circle cx="10" cy="70" r="1" fill="#E11D1D" opacity="0.25"/>
  </svg>
</div>
```

### Red Benefit Tag / Chip Component
```html
<!-- Red angled benefit chip -->
<div style="display:inline-flex;align-items:center;gap:10px;background:#E11D1D;padding:10px 20px 10px 14px;clip-path:polygon(0 0, calc(100% - 10px) 0, 100% 50%, calc(100% - 10px) 100%, 0 100%, 10px 50%);">
  <!-- White check SVG icon -->
  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
    <polyline points="20 6 9 17 4 12"/>
  </svg>
  <span style="color:#fff;font-family:'Poppins',sans-serif;font-weight:600;font-size:16px;">Label text here</span>
</div>
```

### Section Card Component (Detail Slide)
```html
<div style="border:1.5px solid #E11D1D;padding:20px 24px 20px 24px;position:relative;margin-bottom:16px;">
  <!-- Red label tab -->
  <div style="position:absolute;top:-16px;left:20px;background:#E11D1D;padding:5px 14px 5px 10px;display:flex;align-items:center;gap:8px;clip-path:polygon(0 0, calc(100% - 8px) 0, 100% 50%, calc(100% - 8px) 100%, 0 100%);">
    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
    <span style="color:white;font-family:'Poppins',sans-serif;font-size:14px;font-weight:600;">Section Label</span>
  </div>
  <!-- Red top rule line with dot -->
  <div style="position:absolute;top:0;left:60%;right:0;height:1.5px;background:#E11D1D;"></div>
  <div style="position:absolute;top:-4px;left:60%;width:8px;height:8px;border-radius:50%;background:#E11D1D;"></div>
  <!-- Body text -->
  <p style="color:#F2F2F2;font-family:'Poppins',sans-serif;font-size:15px;line-height:1.7;margin-top:10px;">Body text here.</p>
</div>
```

### Full Slide CSS Template
```css
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Poppins:wght@400;500;600;700&display=swap');

* { box-sizing: border-box; margin: 0; padding: 0; }
body { background: #1a1a1a; }

.page {
  width: 1122px;
  height: 794px;
  overflow: hidden;
  background: #080808;
  position: relative;
  margin: 20px auto;
  font-family: 'Poppins', sans-serif;
}

.slide-heading {
  font-family: 'Bebas Neue', 'Anton', Impact, sans-serif;
  font-size: 80px;
  line-height: 1.0;
  letter-spacing: 1px;
  text-transform: uppercase;
}

.heading-white { color: #FFFFFF; }
.heading-red   { color: #E11D1D; }

.body-text {
  font-family: 'Poppins', sans-serif;
  font-size: 18px;
  line-height: 1.75;
  color: #F2F2F2;
  font-weight: 400;
}

.accent-red { color: #E11D1D; }
.bg-red { background: #E11D1D; }
```

### Presenter Ribbon
```html
<div style="position:absolute;bottom:30px;left:50px;background:#E11D1D;padding:10px 40px 10px 20px;clip-path:polygon(0 0, calc(100% - 20px) 0, 100% 50%, calc(100% - 20px) 100%, 0 100%);">
  <span style="color:white;font-family:'Poppins',sans-serif;font-size:15px;font-weight:400;">Presented By </span>
  <span style="color:white;font-family:'Poppins',sans-serif;font-size:15px;font-weight:700;">Name Here</span>
</div>
```

---

> **Override rule:** This is the default style. Cho can override specific colors, fonts, or layout at any time by stating a preference. Otherwise, always apply this design language.

#### 6. **MARGIN BUG FIX (Golden Rule)**

**Root cause of 99% of slide PDF cutoff/overflow issues:** The `margin: 20px auto` on `.page` div pushes slides past the 794px A4 height boundary.

**The fix:** Always use `margin: 0` + `page-break-after: always`

**Why it happens:** PDF rendering is pixel-perfect. The Chromium PDF engine enforces the exact 1122×794 pixel boundary. Any margin outside that boundary causes content to bleed off the page or get cut off.

**How it was meant to work:** The 20px margin was added for browser preview separation only — it looked nice on screen. But it breaks PDF export because PDF doesn't care about visual separation — it cares about exact pixel boundaries.

**Lock this in:** This is now fixed in the HTML template pattern. Don't re-add margins for "visual separation" — it will break slides again.
