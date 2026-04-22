# NutriKaizen Landing Page Rebuild Plan (2026-04-22)

## Current State Audit

**What's wrong with current nutrition page:**
- Generic green gradient hero (no product/hero visual context)
- Same circular card pattern repeated (static testimonials, 3x identical)
- Emoji icons (🎯 🧠 ⚡ 🚀 👨⚕️) — violates landing-page-builder rules
- Missing FAQ section (SEO blocker)
- No social proof bar (trust signal gap)
- Weak headline ("Master Nutrition & Transform Your Health" — generic benefit claim)
- No schema markup / robots.txt / sitemap
- No og-image or metadata SEO
- CTA buttons not prominent enough (shouldn't blend with page)

## What Landing-Page-Builder Requires

**Sections (must be unique layouts):**
1. Hero — Asymmetric split or full-bleed with real screenshot
2. Social Proof Bar — Logo strip or stat
3. Features — ALTERNATING layouts (NOT all cards):
   - Left image + right text
   - Large screenshot + callouts
   - Interactive tabs/accordion
   - Bento grid
4. How It Works — Numbered steps or timeline
5. Testimonials — Large quote OR two-column quote+metric (NOT 3-card grid)
6. FAQ — Accordion (SEO requirement)
7. Final CTA — Full-width contrasting background
8. Footer — Links + schema

**Tech Stack:**
- Next.js App Router ✓ (already using)
- Tailwind CSS ✓
- lucide-react icons (NOT emoji) ✓ need to replace
- framer-motion for scroll animations (NOT currently used)
- next/font (current system fonts OK)

**SEO Musts:**
- Metadata (title, description, OG tags) ✓ needs work
- JSON-LD schema (SoftwareApplication + Organization)
- robots.txt + sitemap.xml (MISSING)
- og-image.png 1200x630 (MISSING)
- Single H1 tag (currently multiple)
- Proper heading hierarchy
- Alt text on all images

## Rebuild Scope

**What stays:**
- Green color palette (#10b981, #059669)
- Cho profile image
- Testimonial content + photos
- "100-day transformation" core message
- Form inputs (name, email)

**What changes:**
- Replace emoji icons with lucide-react SVG icons
- Rebuild testimonials as **single large quote** or **two-column quote + stat** (NOT 3-card grid)
- Rebuild features with **alternating layouts** (don't repeat card pattern)
- Add "How It Works" section (3-4 steps to enrollment)
- Add FAQ section (4-6 questions, accordion, schema markup)
- Add Social Proof bar under hero (stat or logo strip)
- Create og-image.png (1200x630, brand-colored)
- Add robots.txt + sitemap.xml
- Fix metadata in layout
- Add schema markup (JSON-LD) for FAQ + SoftwareApplication
- Add scroll animations with framer-motion
- Make CTA buttons more prominent (high contrast, not green-on-green)

## Estimated Effort

- Full rebuild: 2-3 hours
- QA + screenshots: 30 min
- Total: ~3 hours

## Dependencies

- lucide-react (install via npm)
- framer-motion (install via npm)
- og-image generation (via image_generate skill)
- Proper brand spec (BRAND_SPEC.md already created ✓)

## Next Step

1. **Get Raven approval** on this plan
2. **Spawn fresh session** with full token budget
3. **Follow landing-page-builder blueprint exactly**
4. **QA before delivery** (screenshot + SEO audit + mobile test)
5. **Deploy live** and share preview

---

**Status:** Waiting for Raven approval. Skill installed. Plan ready to execute.
