---
name: superdesign
description: Frontend UI/UX design patterns and implementation. Use when designing landing pages, dashboards, dashboards, components, or any web interfaces. Covers layout design, modern color systems (oklch), typography, animations, responsive design, accessibility, and hands-on component patterns.
---

# SuperDesign — Modern Frontend Design

Build beautiful, accessible web interfaces. From wireframes to production code.

## Design Workflow

1. **Layout Design** — Sketch structure (ASCII wireframe)
2. **Theme Design** — Define colors, fonts, spacing
3. **Animation Design** — Plan micro-interactions
4. **Implementation** — Generate actual code

See `references/layout.md` for wireframe patterns.
See `references/colors.md` for color systems and variables.
See `references/typography.md` for font selection and sizing.
See `references/animations.md` for animation guidelines.
See `references/accessibility.md` for a11y rules.

## Quick Start: Layout

Sketch before coding (ASCII):

```
┌─────────────────────────────────┐
│ HEADER / NAV                    │
├─────────────────────────────────┤
│ HERO (Title + CTA)              │
├─────────────────────────────────┤
│ FEATURE │ FEATURE │ FEATURE     │
│ CARD    │ CARD    │ CARD        │
├─────────────────────────────────┤
│ FOOTER                          │
└─────────────────────────────────┘
```

## Quick Start: Colors

Modern approach uses `oklch()` for perceptual color space:

```css
:root {
  --bg: oklch(1 0 0);           /* white */
  --fg: oklch(0.145 0 0);        /* dark gray */
  --primary: oklch(0.58 0.18 25); /* vibrant orange */
  --muted: oklch(0.97 0 0);      /* light gray */
  --border: oklch(0.92 0 0);     /* very light gray */
}
```

**Why oklch?** Perceptually uniform. Same lightness = same perceived brightness across hues. Way better than HSL or hex.

## Quick Start: Fonts

**Sans-serif:** Inter, Outfit, DM Sans, Plus Jakarta Sans
**Monospace:** JetBrains Mono, Fira Code, Geist Mono
**Serif:** Merriweather, Lora, Playfair Display

Load from Google Fonts or system fonts:
```html
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
```

## Quick Start: Spacing

Use a consistent spacing scale (base = 0.25rem = 4px):

```css
/* Spacing scale */
--space-1: 0.25rem;   /* 4px */
--space-2: 0.5rem;    /* 8px */
--space-3: 1rem;      /* 16px */
--space-4: 1.5rem;    /* 24px */
--space-5: 2rem;      /* 32px */
--space-6: 3rem;      /* 48px */

/* Usage */
padding: var(--space-3);
margin-bottom: var(--space-4);
gap: var(--space-2);
```

## Quick Start: Animations

Plan animations with micro-syntax:

```
button-press: 150ms [S0.95→1] ease-out
hover: 200ms [Y0→-2px, shadow↗] ease-out
fade-in: 400ms [α0→1] ease-out
slide-in: 350ms [X-100→0px, α0→1] ease-out
```

**Timing guide:**
- Entry: 300-500ms, ease-out
- Hover: 150-200ms
- Press: 100-150ms
- Transitions: 300-400ms

## Core Rules

✅ **DO:**
- Mobile-first responsive design
- Semantic HTML (header, main, nav, section, article)
- Proper heading hierarchy (h1 → h2 → h3)
- Color contrast 4.5:1 minimum
- Touch targets min 44x44px
- Keyboard navigation support
- aria-labels on interactive elements
- Subtle shadows, not heavy drop shadows

❌ **DON'T:**
- Use generic bootstrap blue (#007bff) — dated
- Heavy drop shadows
- Align to edge (leave padding/breathing room)
- Complex nested grids
- Too many font sizes (stick to 3-4)
- Auto-play audio/video
- Flashing content (seizure risk)

## Component Checklist

**Cards:**
- Subtle shadow + hover state
- Consistent padding (p-4 to p-6)
- Hover: slight lift + shadow increase

**Buttons:**
- Clear hierarchy (primary, secondary, ghost)
- Adequate click targets (44x44px min)
- Loading and disabled states
- Consistent spacing around text

**Forms:**
- Clear labels above inputs
- Visible focus states
- Inline validation
- Good spacing between fields

**Navigation:**
- Sticky header on long pages
- Clear active state
- Mobile hamburger menu
- Logical grouping

## Responsive Design

Mobile-first approach:

```css
/* Mobile (base) */
.container { padding: 1rem; }

/* Tablet: 768px+ */
@media (min-width: 768px) {
  .container { padding: 2rem; }
}

/* Desktop: 1024px+ */
@media (min-width: 1024px) {
  .container { max-width: 1200px; margin: 0 auto; }
}
```

## Implementation

Use **Tailwind CSS** for rapid prototyping:

```html
<link href="https://cdn.tailwindcss.com" rel="stylesheet">
```

Or **Flowbite** for pre-built components:

```html
<link href="https://cdn.jsdelivr.net/npm/flowbite@2.0.0/dist/flowbite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/flowbite@2.0.0/dist/flowbite.min.js"></script>
```

Icons via **Lucide**:

```html
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
```

## Workflow: Design System in Code

```css
:root {
  /* Colors */
  --primary: oklch(0.58 0.18 25);
  --secondary: oklch(0.75 0.15 280);
  
  /* Fonts */
  --font-sans: Inter, system-ui, sans-serif;
  --font-mono: JetBrains Mono, monospace;
  
  /* Spacing */
  --space: 0.25rem;
  
  /* Timing */
  --duration-fast: 150ms;
  --duration-normal: 300ms;
  
  /* Radius */
  --radius: 0.5rem;
}
```

Then use throughout:

```css
.button {
  background: var(--primary);
  padding: calc(var(--space) * 3);
  border-radius: var(--radius);
  transition: all var(--duration-fast);
}

.button:hover {
  transform: translateY(-2px);
}
```

## See Also

- oklch color space: https://oklch.com
- Google Fonts: https://fonts.google.com
- Tailwind CSS: https://tailwindcss.com
- Flowbite: https://flowbite.com
- Lucide icons: https://lucide.dev
- Web Accessibility (A11y): https://www.a11y-101.com
