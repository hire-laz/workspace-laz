---
name: landing-page-builder
description: |
  Build SEO-optimized single-page marketing landing pages for Agency products. Covers
  opinionated section structure (hero, social proof, features, pricing, FAQ, CTA),
  SEO requirements (schema markup, OG tags, sitemap, robots.txt), layout variety
  enforcement, and AI image generation rules. Use when building a marketing landing
  page, during Market phase Step 4, when user asks to "create a landing page",
  "build a marketing page", or "make an SEO landing page". Called by market-pipeline
  as Step 4. Do NOT use for app UIs or functional pages with auth/data (use
  frontend-design or build-planning instead).
---

# Landing Page Builder

Build marketing landing pages that convert. These are standalone single-page sites
for product marketing — separate from the product app itself.

## Important

- Landing pages are **marketing pages**, not the app. No auth, no database, no user data.
- Every landing page gets its own project directory: `products/{slug}/apps/{slug}-landing/`
- Deploy via devserver for preview, Cloud Run for production.
- This skill is called by `market-pipeline` as Step 4, but can also be used standalone.
- References `frontend-design` for base quality rules — all `frontend-design` anti-patterns apply here too.

## Tech Stack

- Next.js (App Router) — single page (`src/app/page.tsx`)
- Tailwind CSS + TypeScript
- `lucide-react` for icons (NEVER emoji)
- `framer-motion` for scroll animations
- `next/font` for typography (NEVER Google Fonts CDN)

## Instructions

### Step 1: Gather Context

Before building, read from the product's artifacts:

| Source | What to Extract |
|--------|----------------|
| `design/design.yaml` | Brand colors, typography, logo path |
| `design/brand-guidelines.md` | Brand voice, personality, visual rules |
| `discovery/prd.md` | Features, value prop, target audience |
| `discovery/target-market.md` | Personas, pain points, messaging angles |
| `market/gtm-strategy.md` | Positioning, key messages (if market-pipeline already ran Steps 1-3) |

### Step 2: Scaffold Project

```bash
cd products/{slug}/apps/
npx create-next-app@latest {slug}-landing --typescript --tailwind --eslint --app --src-dir --use-npm
cd {slug}-landing
npm install lucide-react framer-motion
```

Copy brand assets:
```bash
cp ../../design/assets/logo.png ./public/logo.png
cp ../../design/assets/hero*.png ./public/ 2>/dev/null || true
```

**Logo embedding in the landing page (CRITICAL):**
Use the pre-baked b64 for the navbar logo — do NOT import from `/public/logo.png` or
re-encode the file. Read directly from the design assets:

```tsx
// In your Navbar component
import fs from 'fs'
import path from 'path'

// Read at build time (server component)
const logoB64 = fs.readFileSync(
  path.join(process.cwd(), '../../design/assets/logo.b64'), 'utf-8'
).trim()

// Render with data-aria-logo marker (enables sync-logo.py propagation)
<img
  data-aria-logo="primary"
  src={`data:image/png;base64,${logoB64}`}
  alt="{Product Name}"
  className="h-8 w-auto"
/>
```

If the landing page is a static HTML file (not Next.js):
```html
<img data-aria-logo="primary" src="data:image/png;base64,{READ_FROM_logo.b64}" alt="AppName" />
```

If `logo.b64` doesn't exist: run `sync-logo.py {product_path}` first.
If `logo.png` also missing → blocker. No SVG fallback, no placeholder.

Configure Tailwind with brand colors from `design.yaml`:
```typescript
// tailwind.config.ts
colors: {
  primary: '{from design.yaml}',
  secondary: '{from design.yaml}',
  accent: '{from design.yaml}',
  background: '{from design.yaml}',  // NOT pure white
  foreground: '{from design.yaml}',  // NOT pure black
}
```

### Step 3: Build the Page

Use this section blueprint. CRITICAL: Every section MUST use a different layout pattern.

**1. HERO** (first impression)
- Layout: Asymmetric split (60/40) or full-bleed with product screenshot
- Headline: Short, benefit-focused, conversational tone. NOT "Transform/Revolutionize your X"
- Subheadline: 1 sentence max, plain language
- CTA: One primary button (high contrast), optionally one ghost/link
- Visual: Real product screenshot in device frame, or AI-generated abstract background
- Optional: Small trust signal below CTA (rating, user count, badge)

**2. SOCIAL PROOF BAR** (immediately after hero)
- Layout: Horizontal logo strip, grayscale
- If no logos: Single stat ("500+ users") or skip entirely
- Keep subtle — single row, small logos

**3. FEATURES** (the meat)
- ALTERNATE between these patterns (never repeat):
  - a) Left image + right text (or vice versa)
  - b) Large screenshot with overlaid feature callouts
  - c) Interactive tabs or accordion
  - d) Bento grid (mixed card sizes) with icons
- Each feature: Lucide icon + short title (3-5 words) + 1-2 sentence description
- Section label: Small chip/badge above heading

**4. HOW IT WORKS** (optional, recommended for complex products)
- Layout: Numbered steps with connecting line/arrows, or timeline
- 3-4 steps max with visual progression

**5. TESTIMONIALS** (if available)
- ONE of: single large quote, two-column quote + metric, scrolling ticker
- Include: Real name, company, specific result. If no real testimonials: skip entirely. Never fake it.

**6. PRICING** (if applicable)
- Side-by-side cards (2-3 tiers max), highlight recommended tier
- Show actual prices, not "Contact us"

**7. FAQ** (helps SEO + reduces objections)
- Accordion or clean list, 4-6 questions max
- Write from user's perspective

**8. FINAL CTA** (close the deal)
- Full-width section with contrasting background
- Repeat core value prop (different wording from hero), single CTA button

**9. FOOTER**
- Logo + tagline, 2-3 link columns, copyright, social links
- Links to `/privacy` and `/terms` (required by `security-defaults`)

### Step 4: SEO Requirements

**Metadata** in `src/app/layout.tsx`:
```typescript
export const metadata: Metadata = {
  title: "{Product} - {Benefit}",           // 50-60 chars
  description: "{Value prop}",               // 150-160 chars
  keywords: ["{keyword1}", "{keyword2}"],
  openGraph: {
    title: "{Product}",
    description: "{Description}",
    images: ["/og-image.png"],               // 1200x630
  },
  twitter: { card: "summary_large_image" },
};
```

**Schema markup** (JSON-LD in layout):
- `SoftwareApplication` or `Service` schema with name, description, offers, creator
- `Organization` schema with Symph as parent
- `FAQPage` schema if FAQ section exists

**Static files** in `public/`:
- `robots.txt` with sitemap reference
- `sitemap.xml` with landing page URL
- `og-image.png` (1200x630)
- Favicon + apple-touch-icon

**SEO checklist (must complete before deploy):**
- Single H1 tag (main headline)
- Proper heading hierarchy (H1 > H2 > H3)
- All images have alt text
- Canonical URL set
- Schema markup included
- robots.txt + sitemap.xml created

### Step 5: AI Image Generation Rules

When product screenshots aren't available, use `gemini` or `ideogram` skill for images.

CRITICAL: **Background images ONLY — never mock UI.**

| OK to Generate | NEVER Generate |
|----------------|---------------|
| Abstract geometric compositions | Mock app screenshots |
| Brand-colored patterns/textures | Fake dashboards or interfaces |
| Conceptual abstract art | Stock-photo-style realistic scenes |

Prompt pattern:
```
Abstract geometric composition representing [concept].
Shapes: [circles/lines/grids/waves/nodes].
Colors: [brand primary] and [brand secondary] on [background].
Style: minimal, modern, NOT realistic, NOT illustrative.
```

Save generated images to `public/images/`.

### Step 6: Deploy

Use devserver for preview:
```bash
# Start via devserver pool
start_devserver(slug="{slug}-landing", workspace_path="products/{slug}/apps/{slug}-landing", start_command="npm run dev -- --host 0.0.0.0 --port $PORT")
```

For production: Deploy to Cloud Run with custom domain via `dns-management` skill.

### Step 7: Verify

Use browser tools to verify:
1. `new_page` with preview URL
2. `take_screenshot` for visual check
3. `list_console_messages` for JS errors
4. Test mobile viewport (`resize_page` to 390px width)
5. Verify all sections render, CTA buttons work, no broken images

## Design Anti-Patterns (NEVER DO)

- Emoji as icons — use `lucide-react`
- Purple/indigo gradient hero backgrounds
- 3-column feature grid with icon-title-description (vary layouts!)
- "Transform/Revolutionize/Supercharge your X" headlines
- Fake testimonial cards with stock avatars
- Perfectly centered symmetrical everything
- Generic abstract blob illustrations
- Pure white (#FFFFFF) backgrounds — use off-white from brand palette
- Google Fonts CDN — use `next/font`

## Output Artifacts

After building, save to `products/{slug}/market/`:

| File | Content |
|------|---------|
| `landing-page.md` | Documentation: URL, sections included, SEO metadata |
| `landing-page.html` | Agency UI card with preview thumbnail and "View" button |

## Examples

### Example 1: Build landing page during Market phase

market-pipeline calls this skill at Step 4.

Actions:
1. Read design.yaml + prd.md + gtm-strategy.md for context
2. Scaffold Next.js project in `apps/{slug}-landing/`
3. Build 9-section page following blueprint
4. Complete SEO checklist
5. Deploy via devserver, share preview URL
6. Save landing-page.md + landing-page.html to `market/`

### Example 2: Standalone landing page request

User says: "Build a landing page for Alignly"

Actions:
1. Check if product exists, read design/discovery artifacts
2. Scaffold and build following same blueprint
3. Deploy and share preview URL

## Troubleshooting

### Landing page looks generic
Cause: Brand colors not applied, default Tailwind palette used.
Solution: Always extract colors from `design.yaml` first. Configure Tailwind theme.

### SEO score low
Cause: Missing metadata, schema markup, or static files.
Solution: Run through SEO checklist. Most common miss: no OG image or missing schema markup.

### Layout feels repetitive
Cause: Same pattern used for multiple sections.
Solution: Cross-check each section against the blueprint — no two sections should share
a layout pattern. Alternate left-right, bento, tabs, timeline.
