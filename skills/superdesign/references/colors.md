# Color Systems & Modern Color Space

## oklch() — The Future of Web Colors

`oklch()` is a perceptually uniform color space. Same lightness = same perceived brightness.

**Syntax:** `oklch(L C H)`
- **L (Lightness):** 0-1 (0 = black, 1 = white)
- **C (Chroma):** 0-0.4 (saturation strength)
- **H (Hue):** 0-360 (color angle)

**Why oklch over HSL/hex?**
- Perceptually uniform (consistent across hues)
- Better for accessibility (easier to manage contrast)
- Better for dark/light mode (swap lightness, keep color)

### oklch() by Lightness

```
oklch(0 0 0)       → black (pure dark)
oklch(0.2 0 0)     → very dark gray
oklch(0.4 0 0)     → dark gray
oklch(0.6 0 0)     → medium gray
oklch(0.8 0 0)     → light gray
oklch(1 0 0)       → white (pure light)
```

### oklch() by Hue (Color Wheel)

```
oklch(0.5 0.2 0)    → red
oklch(0.5 0.2 30)   → orange
oklch(0.5 0.2 60)   → yellow
oklch(0.5 0.2 120)  → green
oklch(0.5 0.2 180)  → cyan
oklch(0.5 0.2 240)  → blue
oklch(0.5 0.2 300)  → magenta
```

### oklch() Chroma (Saturation)

```
oklch(0.5 0 180)    → desaturated (gray)
oklch(0.5 0.1 180)  → muted blue
oklch(0.5 0.2 180)  → vibrant blue
oklch(0.5 0.3 180)  → very saturated blue
```

---

## Modern Design System Example

### Dark Mode (Vercel/Linear style)

```css
:root {
  /* Backgrounds */
  --bg-primary: oklch(1 0 0);           /* white */
  --bg-secondary: oklch(0.97 0 0);      /* off-white */
  --bg-tertiary: oklch(0.94 0 0);       /* light gray */
  
  /* Text */
  --text-primary: oklch(0.145 0 0);     /* almost black */
  --text-secondary: oklch(0.48 0 0);    /* medium gray */
  --text-tertiary: oklch(0.68 0 0);     /* light gray */
  
  /* Accents */
  --primary: oklch(0.58 0.18 25);       /* vibrant orange */
  --primary-hover: oklch(0.52 0.18 25); /* darker orange */
  --secondary: oklch(0.75 0.12 280);    /* soft purple */
  
  /* Borders & dividers */
  --border: oklch(0.92 0 0);            /* very light gray */
  --border-strong: oklch(0.88 0 0);     /* light gray */
  
  /* Status colors */
  --success: oklch(0.65 0.19 142);      /* green */
  --warning: oklch(0.70 0.18 60);       /* amber */
  --error: oklch(0.62 0.22 20);         /* red */
  --info: oklch(0.62 0.18 240);         /* blue */
}

/* Dark mode variant */
@media (prefers-color-scheme: dark) {
  :root {
    --bg-primary: oklch(0.145 0 0);     /* almost black */
    --bg-secondary: oklch(0.18 0 0);    /* dark gray */
    --text-primary: oklch(0.98 0 0);    /* almost white */
    --text-secondary: oklch(0.72 0 0);  /* light gray */
  }
}
```

---

## Color Accessibility (WCAG)

**Text + Background contrast ratio:**
- Normal text: **4.5:1** minimum (AA)
- Large text: **3:1** minimum (AA)
- AAA (strictest): **7:1** for normal text

**Test with:** https://webaim.org/resources/contrastchecker/

**Example checks:**
```
Text: oklch(0.145 0 0) (dark gray) on bg oklch(1 0 0) (white)
→ Ratio: 15:1 ✅ PASS (AAA)

Text: oklch(0.48 0 0) (medium gray) on bg oklch(1 0 0)
→ Ratio: 7:1 ✅ PASS (AA)

Text: oklch(0.68 0 0) (light gray) on bg oklch(1 0 0)
→ Ratio: 3.5:1 ❌ FAIL (use for large text only)
```

---

## Brand-Specific Palettes

### Bold & Vibrant (Startup style)

```css
--primary: oklch(0.6 0.25 30);     /* vibrant orange */
--secondary: oklch(0.55 0.25 280); /* vibrant purple */
--accent: oklch(0.65 0.22 200);    /* vibrant cyan */
```

### Minimalist (Apple/Stripe style)

```css
--primary: oklch(0.5 0.08 200);    /* muted blue */
--secondary: oklch(0.45 0.08 0);   /* muted red */
--accent: oklch(0.65 0.08 120);    /* muted green */
```

### Neo-Brutalism (90s web revival)

```css
--primary: oklch(0.649 0.237 26.97);   /* warm orange */
--secondary: oklch(0.968 0.211 109.77); /* yellow */
--accent: oklch(0.564 0.241 260.82);   /* deep purple */
--text: oklch(0 0 0);                   /* pure black */
--bg: oklch(1 0 0);                     /* pure white */
```

### Soft & Warm (SaaS friendly)

```css
--primary: oklch(0.58 0.12 45);    /* warm amber */
--secondary: oklch(0.65 0.1 145);  /* soft green */
--accent: oklch(0.62 0.1 25);      /* warm rose */
```

---

## Semantic Color Usage

```css
/* Actions */
--success: oklch(0.65 0.19 142);   /* positive action */
--warning: oklch(0.70 0.18 60);    /* caution action */
--error: oklch(0.62 0.22 20);      /* destructive action */
--info: oklch(0.62 0.18 240);      /* informational */

/* UI Elements */
--bg: oklch(1 0 0);                /* primary background */
--surface: oklch(0.97 0 0);        /* elevated surface */
--border: oklch(0.92 0 0);         /* dividers & outlines */
--text: oklch(0.145 0 0);          /* body text */
--text-muted: oklch(0.48 0 0);     /* secondary text */

/* Interactive */
--primary: oklch(0.58 0.18 25);    /* primary action (button, link) */
--primary-hover: oklch(0.52 0.18 25);
--primary-active: oklch(0.48 0.18 25);
--primary-disabled: oklch(0.72 0.08 25);
```

---

## Shadows in oklch()

Instead of black shadows, use your primary color darkened:

```css
/* Traditional (low quality) */
box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);

/* Better (color-based) */
box-shadow: 0 4px 12px oklch(0.15 0.1 25 / 0.15);
```

The hue (25 = orange) ties shadow color to your brand.

---

## Converting from Hex to oklch()

Use https://oklch.com to convert:

1. Paste hex color (#FF6B35)
2. Copy oklch value: `oklch(0.62 0.19 25)`
3. Use in CSS

Or use online converter: https://www.colorhexa.com/
