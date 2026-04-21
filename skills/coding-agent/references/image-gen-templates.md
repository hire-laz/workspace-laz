# Image Generation Templates (Nano Banana)

Prompt templates for smart image generation during PLAN phase. All use `google/gemini-3-pro-image-preview`.

## Formula

```
[STYLE] + [SUBJECT] + [COMPOSITION] + [MOOD/COLORS] + [TECHNICAL SPECS]
```

---

## Use Case: Hero Section Background

**When:** First visual element on landing/home page  
**Purpose:** Sets tone, atmospheric depth, text overlay space  
**Ratio:** 16:9 (landscape)  

### Template

```
Photorealistic abstract flowing gradient in [COLOR_1] and [COLOR_2],
atmospheric depth with soft bokeh particles,
modern tech aesthetic,
COMPOSITION: negative space on LEFT SIDE (30%) for text overlay, main visual on right (70%),
calm and focused mood,
professional ultra-high quality,
16:9 landscape format
```

### Examples

```
Photorealistic abstract flowing gradient in deep navy blue and vibrant violet,
atmospheric depth with soft bokeh particles,
modern tech aesthetic,
COMPOSITION: negative space on LEFT SIDE (30%) for text overlay, main visual on right (70%),
calm and focused mood,
professional ultra-high quality,
16:9 landscape format

---

Flat design illustration of interconnected nodes and data flow,
gradient background in indigo and cyan,
geometric composition with center focal point,
COMPOSITION: negative space on LEFT SIDE (25%) for headline, right (75%) for visual,
bright and energetic mood,
clean modern aesthetic,
16:9 landscape format
```

---

## Use Case: Feature Card Images (Set of 3-4)

**When:** Feature section highlighting different capabilities  
**Purpose:** Consistent visual set, quick recognition  
**Ratio:** 1:1 (square)  
**Count:** Generate 3-4 with same style prefix to ensure consistency

### Template (Feature Set #1 — Illustrations)

```
Flat design illustration of [CONCEPT_METAPHOR],
[SAME_COLOR_PALETTE] accents (use same colors as other feature images),
simple clean background,
centered composition,
[BRAND_COLOR] accent element,
friendly and professional tone,
square format 1:1,
high quality illustration
```

### Example Feature Set

**Feature 1: Analytics**
```
Flat design illustration of analytics dashboard with upward trending graph,
deep blue and bright cyan accents,
simple white background,
centered composition,
blue accent bars,
friendly and professional tone,
square format 1:1,
high quality illustration
```

**Feature 2: Security**
```
Flat design illustration of shield with lock icon inside,
deep blue and bright cyan accents,
simple white background,
centered composition,
blue shield outline,
friendly and professional tone,
square format 1:1,
high quality illustration
```

**Feature 3: Speed**
```
Flat design illustration of lightning bolt with motion lines,
deep blue and bright cyan accents,
simple white background,
centered composition,
cyan lightning bolt,
friendly and professional tone,
square format 1:1,
high quality illustration
```

---

## Use Case: Section Background / Texture

**When:** Subtle background for text sections  
**Purpose:** Non-distracting, texture only  
**Ratio:** 16:9 or 1:1 (depends on use)  

### Template

```
Subtle [COLOR] mesh gradient texture,
low saturation, light and airy,
seamless tiling pattern suitable for background,
no focal point,
non-distracting,
perfect for white or dark text overlay,
high quality texture
```

### Examples

```
Subtle soft blue mesh gradient texture,
low saturation, light and airy,
seamless tiling pattern,
no focal point,
non-distracting background,
perfect for white text overlay,
high quality texture

---

Subtle warm gray gradient texture with noise,
low saturation, minimalist,
seamless pattern,
no focal point,
works with both light and dark text,
professional background,
high quality texture
```

---

## Use Case: Empty State / Placeholder

**When:** Empty inbox, no results, page not ready  
**Purpose:** Friendly, clear metaphor for the state  
**Ratio:** 1:1 (square)  

### Template

```
Friendly minimalist illustration of [STATE_METAPHOR],
muted [BRAND_COLOR] palette,
simple and encouraging visual,
METAPHOR: [clear analogy for the empty state],
centered composition,
approachable and warm tone,
square format 1:1,
high quality illustration
```

### Examples

```
Friendly minimalist illustration of empty mailbox,
muted blue palette,
simple and encouraging visual,
METAPHOR: no messages waiting (empty inbox),
centered composition,
approachable and warm tone,
square format 1:1,
high quality illustration

---

Friendly minimalist illustration of magnifying glass with question mark,
muted purple palette,
simple and encouraging visual,
METAPHOR: no results found yet,
centered composition,
approachable and warm tone,
square format 1:1,
high quality illustration

---

Friendly minimalist illustration of person thinking with lightbulb,
muted orange palette,
simple and encouraging visual,
METAPHOR: no ideas yet, ready to create,
centered composition,
approachable and warm tone,
square format 1:1,
high quality illustration
```

---

## Use Case: Product Mockup / App Screenshot

**When:** Show the actual app in a device frame  
**Purpose:** Real product visualization, marketing shot  
**Ratio:** Depends on device (16:9 for monitor, portrait for phone)  

### Template

```
Clean 3D product screenshot mockup of [APP_DESCRIPTION],
device frame: [DEVICE_TYPE: MacBook / iPhone 15 Pro / iPad Pro],
white or dark studio background,
slight shadow and depth,
professional tech marketing aesthetic,
high resolution product shot
```

### Examples

```
Clean 3D product screenshot mockup of a task management dashboard with purple accents,
device frame: MacBook Pro 16-inch,
white studio background,
slight shadow and depth,
professional tech marketing aesthetic,
high resolution product shot

---

Clean 3D product screenshot mockup of a chat interface with messaging bubbles,
device frame: iPhone 15 Pro,
dark studio background,
slight shadow and depth,
professional tech marketing aesthetic,
high resolution product shot
```

---

## Use Case: Brand / Decorative Hero Illustration

**When:** Custom brand illustration, no text  
**Purpose:** Unique, ownable visual identity  
**Ratio:** 16:9 or 1:1  

### Template

```
Abstract digital art with [THEME_CONCEPT],
color palette: [PRIMARY], [SECONDARY], [ACCENT],
composition: [LAYOUT_DESCRIPTION],
mood: [EMOTIONAL_TONE],
style: modern, clean, professional,
suitable for branding,
high quality artwork
```

### Examples

```
Abstract digital art with flowing geometric shapes,
color palette: navy blue, neon cyan, white,
composition: dynamic diagonal flow from bottom-left to top-right,
mood: energetic yet professional,
style: modern, clean, tech-forward,
suitable for branding,
high quality artwork

---

Abstract digital art with interconnected circles and nodes,
color palette: deep purple, soft pink, gold,
composition: radial from center, organic flow,
mood: innovative and creative,
style: modern, minimalist, sophisticated,
suitable for branding,
high quality artwork
```

---

## Image Naming & Organization

```
public/images/
├── hero/
│   ├── hero-main-bg.jpg
│   ├── hero-gradient.jpg
├── features/
│   ├── feature-analytics.jpg
│   ├── feature-security.jpg
│   ├── feature-speed.jpg
├── sections/
│   ├── testimonials-bg.jpg
│   ├── pricing-bg.jpg
├── empty-states/
│   ├── empty-inbox.jpg
│   ├── empty-search.jpg
├── ui/
│   ├── brand-illustration.jpg
```

---

## Color Palette Quick Reference

### Tech / SaaS (Default)
- Primary: Deep Navy (`#001f3f`)
- Secondary: Bright Cyan (`#00d4ff`)
- Accent: Vibrant Violet (`#8b5cf6`)
- Neutral: Light Gray (`#f3f4f6`)

### Creative / Design
- Primary: Deep Purple (`#6d28d9`)
- Secondary: Soft Pink (`#ec4899`)
- Accent: Gold (`#f59e0b`)
- Neutral: Warm White (`#faf5f0`)

### Product / Health
- Primary: Teal (`#0d9488`)
- Secondary: Emerald (`#10b981`)
- Accent: Orange (`#f97316`)
- Neutral: Cool Gray (`#e5e7eb`)

---

## Pro Tips

1. **Consistency:** Use the SAME color palette across all feature images
2. **Negative Space:** Always leave room for text overlays (30% left for hero)
3. **Test First:** Generate 1 image, show to user, adjust, then do the rest
4. **Save Early:** Commit images to git with the components that use them
5. **Alt Text:** Every image needs `alt="description"` in the HTML
6. **Optimization:** Next.js `<Image>` component auto-optimizes at build time
7. **Metaphor Match:** Empty states should have clear visual metaphors (mailbox = no messages)
