# Nutrition Funnel Website - Plan

## Objective
Build a nutrition-themed waitlist funnel website as a clone of https://join.cholim.ph/kaizen-waitlist-season-10a, adapted for health/nutrition content with a green color scheme.

## Original Site Structure (Kaizen Fitness)
1. **Hero** - Intro text + CTA ("SIGN ME UP FOR THE WAITLIST")
2. **Value Prop** - Description of program benefits
3. **Social Proof** - Testimonials showing transformation results
4. **How It Works** - Step-by-step enrollment/program flow
5. **About Creator** - Cho Lim bio + founder info
6. **Waitlist Form** - Email capture form (First Name + Email)
7. **Footer** - Social links, legal (T&C, Privacy), contact

## Transformation Required

### Language Swap (Fitness → Nutrition)
- "Fitness + Personal Development" → "Nutrition & Healthy Lifestyle"
- "Change your habits, mindset, beliefs" → "Optimize nutrition, build sustainable eating habits, gain nutritional knowledge"
- "100-Day Transformation Program" → "Nutrition Mastery Program" or "21-Day Nutrition Reset"
- "Level up your identity" → "Transform your relationship with food"
- "Struggle with consistency and execution" → "Struggle with nutrition planning and sustainable eating"

### Color Scheme (Blue/Dark → Green)
- Primary: Emerald green (#10b981) or Forest green (#047857)
- Secondary: Light green (#dcfce7) for accents
- Text: Dark gray on light backgrounds, white on green
- Accent: Gold/amber for CTA buttons (contrasts well with green)

### Visual Assets Needed
- Green hero background (gradient or abstract)
- Nutrition-themed imagery (fruits, healthy meals, nutrition planning)
- Testimonial/before-after images (can be generated)
- Creator photo (Cho's existing photo or generate)
- Icons for "How It Works" section

## Tech Stack
- **Framework**: Next.js 16+ (@latest)
- **Styling**: Tailwind CSS (built-in)
- **Components**: shadcn/ui
- **Forms**: Native React (no external libraries)
- **Deployment**: VPS 62.238.6.59 port 3100 (via Caddy)

## Sections Breakdown

### 1. Hero Section
- Large headline: "Transform Your Nutrition, Transform Your Life"
- Subheading: Brief value prop
- CTA button: "Sign Me Up for the Waitlist"
- Background: Green gradient or abstract image (right side)
- Form: Inline or below CTA (First Name + Email)

### 2. Value Proposition
- 3-4 benefit cards with green accents
- Icons from Lucide (nutrition-related)
- Examples:
  - "Evidence-Based Nutrition" → Learn from science-backed principles
  - "Sustainable Habits" → Build eating patterns that stick
  - "Community Support" → Connect with others on the journey
  - "Lifetime Access" → Keep resources forever

### 3. Social Proof / Testimonials
- 2-3 testimonial cards
- Before-after nutrition transformation stories
- Quotes + images + names
- Generate images if needed (healthy person, nutrition transformation)

### 4. How It Works
- 4-step progression (enrollment → modules → implementation → results)
- Timeline or step-by-step flow
- Green checkmarks/icons
- Estimated duration

### 5. About Creator
- Cho's photo (top-right or center)
- Bio: "I'm Cho Lim, founder of The Lazy Lifter..."
- Intro to nutrition program
- Trust signals (credentials, background)

### 6. Waitlist Form
- First Name input
- Email input
- "Sign Me Up" button (green with gold accent)
- Success message after submit

### 7. Footer
- Social links (Instagram, LinkedIn, TikTok, etc.)
- Legal: Terms of Service | Privacy Policy | Contact
- Copyright
- Meta disclaimer (if applicable)

## Design System (Tailwind Config)
```
Colors:
- Green-600: #16a34a (primary actions)
- Green-700: #15803d (hover states)
- Green-50: #f0fdf4 (backgrounds)
- Green-100: #dcfce7 (accents)
- Gold-500: #f59e0b (secondary CTA)
- Gray-900: #111827 (text)
- White: #ffffff (backgrounds)

Spacing: Standard Tailwind
Typography: Geist (Next.js default) or Inter
```

## Implementation Order

1. **Setup**: Next.js 16+ (@latest), Tailwind, shadcn/ui
2. **Layout**: Create `app/layout.tsx` with Navigation + Footer wrapper
3. **Pages**: Build single `app/page.tsx` with all sections
4. **Components**: Build reusable components
   - `HeroSection`
   - `BenefitCard`
   - `TestimonialCard`
   - `StepCard`
   - `WaitlistForm`
5. **API**: Create `/api/waitlist` route for form submission
6. **Styling**: Tailwind green theme + responsive design
7. **Images**: Generate or place hero, testimonial, creator images
8. **Testing**: Responsive design check, form validation, no console errors
9. **Deploy**: Build → Test locally → Deploy to port 3100 → Caddy reverse proxy

## Success Criteria
- [ ] All sections render correctly
- [ ] Hero, testimonials, form visible and styled with green theme
- [ ] Waitlist form submits without errors
- [ ] Responsive design (mobile, tablet, desktop)
- [ ] No console errors
- [ ] Page loads at http://62.238.6.59:3100

## Confidence Score
**85/100** - Clear requirements, straightforward clone with color/language swap. Image generation may need iteration for nutrition theme authenticity.

## Time Estimate
- Setup + scaffolding: 10 min
- Components + sections: 30 min
- Image generation: 15 min
- Styling + responsiveness: 20 min
- API + form handling: 10 min
- Testing + deploy: 15 min
**Total: ~100 min**

---

## Next Step
Await approval. Once approved, will proceed with:
1. Create Next.js app
2. Initialize shadcn/ui
3. Build components
4. Generate images
5. Deploy to VPS
