# Typography — Font Selection & Sizing

## Font Families (by category)

### Sans-Serif (Most Common)

**Modern, clean (2024):**
- Inter — geometric, professional
- Outfit — rounded, friendly
- DM Sans — geometric, technical
- Plus Jakarta Sans — warm, modern
- Space Grotesk — geometric, tech-forward

**Classic:**
- Roboto — versatile, Google default
- Poppins — rounded, friendly
- Montserrat — bold, display

**Load from Google Fonts:**
```html
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
```

### Serif (Headlines, Editorial)

- Merriweather — warm, readable
- Playfair Display — elegant, luxury
- Lora — friendly, readable
- Source Serif Pro — professional
- Libre Baskerville — classic, elegant

### Monospace (Code, Data)

- JetBrains Mono — developer favorite
- Fira Code — clean, ligatures
- Geist Mono — modern, minimal
- IBM Plex Mono — professional
- Space Mono — geometric
- Courier Prime — typewriter feel

---

## Font Sizing Scale

Use a consistent scale (base = 16px):

```css
--text-xs: 0.75rem;    /* 12px */
--text-sm: 0.875rem;   /* 14px */
--text-base: 1rem;     /* 16px */
--text-lg: 1.125rem;   /* 18px */
--text-xl: 1.25rem;    /* 20px */
--text-2xl: 1.5rem;    /* 24px */
--text-3xl: 1.875rem;  /* 30px */
--text-4xl: 2.25rem;   /* 36px */
--text-5xl: 3rem;      /* 48px */
```

**Limit to 3-4 sizes** for consistency:
- Body text: 16px
- Small: 14px
- Large: 18px
- Headline: 24-36px

---

## Line Height (Readability)

```css
/* Body text: tighter line height */
body { line-height: 1.5; }

/* Headlines: looser */
h1, h2, h3 { line-height: 1.2; }

/* Code: compact */
code { line-height: 1.4; }
```

**Why?** Longer line heights = harder to scan. Headlines need tight lines. Body text needs room to breathe.

---

## Font Weight Strategy

**Stick to 2-3 weights:**

```css
--font-light: 300;     /* rarely used */
--font-normal: 400;    /* body text, default */
--font-medium: 600;    /* secondary labels */
--font-bold: 700;      /* headlines, emphasis */
```

Don't use 100, 200, 500, 800, 900. Waste of complexity.

**Common patterns:**
- Body: 400 (normal)
- Emphasis: 600 (medium)
- Headline: 700 (bold)

---

## Letter Spacing (Tracking)

```css
/* Headlines: tighter */
h1 { letter-spacing: -0.02em; }

/* Body: normal */
body { letter-spacing: 0; }

/* ALL CAPS: looser */
.uppercase { letter-spacing: 0.05em; }

/* Code: slightly looser */
code { letter-spacing: 0.01em; }
```

---

## Font Pairing Strategy

**Formula for good pairs:**
1. Pick a sans-serif for body (Inter, Outfit, DM Sans)
2. For headlines: either same sans-serif (bold), or a serif/display font
3. For code: monospace (doesn't need to pair)

**Example 1 (Modern):**
```css
--font-body: Inter, system-ui, sans-serif;
--font-heading: Outfit, sans-serif;  /* same family, diff weight */
--font-code: JetBrains Mono, monospace;
```

**Example 2 (Editorial):**
```css
--font-body: Merriweather, serif;
--font-heading: Playfair Display, serif;  /* serif + serif = classic */
--font-code: Geist Mono, monospace;
```

**Example 3 (Tech):**
```css
--font-body: DM Sans, sans-serif;
--font-heading: Space Grotesk, sans-serif;  /* both sans, diff feel */
--font-code: Fira Code, monospace;
```

---

## Using Google Fonts

```html
<!-- Multiple fonts in one call -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Playfair+Display:wght@700&family=JetBrains+Mono:wght@400&display=swap" rel="stylesheet">

<style>
  body { font-family: 'Inter', sans-serif; }
  h1 { font-family: 'Playfair Display', serif; }
  code { font-family: 'JetBrains Mono', monospace; }
</style>
```

**Performance:** Use `display=swap` to avoid blank text while fonts load.

---

## CSS Implementation

```css
/* Define font stack */
:root {
  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  --font-serif: 'Merriweather', Georgia, serif;
  --font-mono: 'JetBrains Mono', 'Courier New', monospace;
  
  --text-xs: 0.75rem;
  --text-sm: 0.875rem;
  --text-base: 1rem;
  --text-lg: 1.125rem;
  --text-xl: 1.25rem;
  --text-2xl: 1.5rem;
  --text-3xl: 1.875rem;
  --text-4xl: 2.25rem;
  
  --font-light: 300;
  --font-normal: 400;
  --font-medium: 600;
  --font-bold: 700;
}

/* Apply to elements */
body {
  font-family: var(--font-sans);
  font-size: var(--text-base);
  font-weight: var(--font-normal);
  line-height: 1.5;
}

h1, h2, h3 {
  font-family: var(--font-sans);
  font-weight: var(--font-bold);
  line-height: 1.2;
}

h1 { font-size: var(--text-4xl); }
h2 { font-size: var(--text-3xl); }
h3 { font-size: var(--text-2xl); }

code {
  font-family: var(--font-mono);
  font-size: var(--text-sm);
  letter-spacing: 0.01em;
}

.small { font-size: var(--text-sm); }
.large { font-size: var(--text-lg); }
```

---

## System Fonts (Fallback)

If you don't load custom fonts, use system defaults:

```css
/* macOS + iOS + Windows + Linux */
--font-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;

/* macOS + iOS serif */
--font-serif: 'Georgia', 'Times New Roman', serif;

/* Cross-platform monospace */
--font-mono: 'SF Mono', 'Monaco', 'Inconsolata', 'Fira Code', monospace;
```

**Benefit:** No network request, faster load. Respects user OS.

---

## Accessibility Notes

- **Font size min 16px** for body text (easier to read)
- **Line height 1.5+** for body text (readability)
- **Avoid:** Italic for long bodies (hard to read for dyslexic users)
- **Use:** Regular weight for body, bold only for emphasis
- **Contrast:** 4.5:1 color contrast minimum for text
