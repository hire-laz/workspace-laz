# Studio Shodwe — Fitness Slide Design System

**Default style for all slides created by Laz (unless Cho overrides).**

---

## Color Palette

| Element | Color | Hex |
|---------|-------|-----|
| Background | Near-black | #080808 |
| Primary Accent | Vivid red | #E11D1D |
| Dark Red (shade) | Deep red | #B81217 |
| Primary Text | White | #FFFFFF |
| Body Text | Off-white | #F2F2F2 |
| Decorative | White | #FFFFFF |

---

## Typography

| Role | Font | Weight | Size | Style |
|------|------|--------|------|-------|
| Headline | Bebas Neue / Anton | 900 | 70–110px | All-caps, tight tracking |
| Subhead | Bebas Neue | 800 | 48–70px | All-caps |
| Body | Poppins | 400–500 | 18–24px | Sentence case, 1.75 line-height |
| Tag Label | Poppins | 600 | 16–18px | Sentence case, white on red |

**Google Fonts import:**
```html
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
```

---

## Headline Color Split Pattern

All major headlines use a **two-color split** (white line + red emphasis line):

```html
<h1 style="font-family:'Bebas Neue'; font-size:90px; line-height:1;">
  <span style="color:#FFFFFF;">BENEFITS OF A FITNESS</span><br>
  <span style="color:#E11D1D;">LIFESTYLE</span>
</h1>
```

**Examples from deck:**
- "TRANSFORM / YOUR LIFE WITH / FITNESS" (red first, white, red)
- "INTRODUCTION TO / FITNESS" (white, red)
- "BENEFITS OF A / LIFESTYLE" (white, red)
- "SETTING FITNESS / GOALS" (white, red)

---

## Key Decorative Elements

### 1. Hexagon Wireframe Network
- White thin-stroke hexagons
- Placed in top-right and bottom-left corners
- Creates a futuristic/tech grid aesthetic
- Opacity: ~55–70%

### 2. Red Dot Burst (top-left)
- Grid of red dots fading outward
- Opacity: ~60–65%
- Creates a dynamic energy corner

### 3. Connector Line (under heading)
- Thin white line with nodes (white dots on ends, small red dot in middle)
- Visually separates title from body
- Max width: ~180px

### 4. Red Divider Lines
- Thin borders around content modules
- Used in section card layouts
- Border width: 1–1.5px

---

## Slide Layout Patterns

### Cover Slide
```
┌─────────────────────────────────────┐
│ LOGO    [Hexagon net top-right]     │
│                                     │
│ TRANSFORM           [Hero photo in] │
│ YOUR LIFE WITH      [red hexagon]   │
│ FITNESS                             │
│ Subtitle text                       │
│                                     │
│ [Red ribbon]    [Hexagon net br]    │
│ Presented By    [corner]            │
│ Taylor Alonso                       │
└─────────────────────────────────────┘
```

### Content Slide (Image + Text)
```
┌─────────────────────────────────────┐
│ [Dot burst] [Heading]  [Hex corner] │
│             WHITE / RED             │
│ [Red-framed              [Connector]│
│  athlete image]          [Body text]│
│                                     │
│                          [Red line] │
└─────────────────────────────────────┘
```

### Benefits List Slide
```
┌─────────────────────────────────────┐
│ BENEFITS OF A      [Hex corner]     │
│ FITNESS LIFESTYLE                   │
│ [Intro paragraph]                   │
│                                     │
│ [Chip] [Chip] [Chip]                │
│ (red angled tags with check icons)  │
└─────────────────────────────────────┘
```

### Section Detail Slide
```
┌─────────────────────────────────────┐
│ [Red label tab]                     │
│ ─────────────────────────────────── │
│ [Body text explaining section]      │
│                                     │
│ [Red label tab]                     │
│ ─────────────────────────────────── │
│ [Body text explaining section]      │
│                                     │
│ [Red label tab]                     │
│ ─────────────────────────────────── │
│ [Body text explaining section]      │
└─────────────────────────────────────┘
```

---

## Component Styles

### Red Benefit Chip / Tag
- Shape: Angled-end hexagon (clip-path)
- Background: #E11D1D
- Text: White, Poppins 600, 16px
- Icon: White checkmark SVG (20x20)
- Padding: 10px 20px
- Gap between icon & text: 10px

### Section Card (Detail Box)
- Border: 1.5px solid #E11D1D
- Padding: 20px 24px
- Red label tab at top-left (angled end)
- Red horizontal rule line under tab
- Body text: Poppins 400, 15px, #F2F2F2

### Presenter Ribbon
- Background: #E11D1D
- Shape: Angled right end (clip-path)
- Position: Bottom-left
- Text: Poppins, white, 15px
- Padding: 10px 40px 10px 20px

### Connector Line (under heading)
- White line (~180px max)
- White dots on ends
- Red dot in center (~8px)
- Margin: 8px above, 20px below

---

## Image Treatment

### Hero Photos
- Framed in **thick red borders** (6px minimum)
- **Cover slide:** Red hexagon mask/frame
- **Content slides:** Red rectangular border
- Background: Dark or blurred gym environment
- Crop: Tight on subject (torso, facial expression)
- No drop shadows — border acts as separator

---

## Design Philosophy

**Visual Identity:**
- Aggressive, motivational, high-energy
- Black + red + white only
- Hexagon = strength, precision, structure, forward motion
- Red = intensity, effort, vitality
- Black = luxury, focus, dramatic contrast

**Emotional Tone:**
- Powerful
- Driven
- Inspirational
- Disciplined
- Slightly futuristic/tech-enhanced

---

## Fonts: Fallback Strategy

| Primary | Fallback 1 | Fallback 2 | Fallback 3 |
|---------|-----------|-----------|-----------|
| Bebas Neue | Anton | Impact | Arial Black |
| Poppins | Montserrat | Inter | Arial |

---

## CSS Quick Start

```css
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Poppins:wght@400;500;600;700&display=swap');

.page {
  width: 1122px;
  height: 794px;
  background: #080808;
  position: relative;
  overflow: hidden;
}

.heading {
  font-family: 'Bebas Neue', sans-serif;
  font-size: 80px;
  text-transform: uppercase;
  line-height: 1;
  letter-spacing: 1px;
}

.heading-white { color: #FFFFFF; }
.heading-red { color: #E11D1D; }

.body {
  font-family: 'Poppins', sans-serif;
  font-size: 18px;
  line-height: 1.75;
  color: #F2F2F2;
}

.accent-red { color: #E11D1D; }
.border-red { border: 1.5px solid #E11D1D; }
.bg-red { background: #E11D1D; }
```

---

## Usage Notes for Laz

1. **Always apply this style by default** — unless Cho says otherwise
2. **Override the colors:** If Cho wants a different brand, update `MEMORY.md` with the preference
3. **Photo requirements:** Ask for high-contrast, well-lit athlete/subject photos with clean cropping
4. **SVG icons only** — no emoji, no icon fonts (PDFs break them)
5. **Test in preview:** Always render a test slide to verify hexagons and dots display correctly
6. **Spacing:** Use generous padding; this is a presentation deck, not a social media post

---

**Last updated:** 2026-04-22 | Extracted from Studio Shodwe fitness presentation
