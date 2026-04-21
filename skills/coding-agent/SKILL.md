---
name: coding-agent
description: Coding Agent using Claude Code + Compound Engineering workflow. Uses Sonnet 4.6 for all coding tasks. Handles planning, deepening, work execution, review, and learning capture. Supports both supervised mode (/build) and autonomous mode (/lfg). Includes log-checking debug loops and smart image generation.
---

# Coding Agent — Compound Engineering + Claude Code

AI-powered development using Sonnet 4.6, structured around the Compound Engineering philosophy: "Each unit of engineering work should make subsequent units easier."

## Architecture

```
┌───────────────────────────────────────────────────────┐
│            COMPOUND ENGINEERING WORKFLOW              │
├───────────────────────────────────────────────────────┤
│                                                       │
│  PLAN → DEEPEN → WORK → LOG CHECK → REVIEW → COMPOUND │
│   ↓       ↓        ↓        ↓          ↓         ↓   │
│ Brainstorm Parallel Execute  Verify  Multi-agent Doc  │
│ + images  skills   todos   behavior  review    lessons│
│                               ↓                      │
│                         Ralph Loop                   │
│                    (iterate until DONE)               │
└───────────────────────────────────────────────────────┘
```

## Usage Modes

### Mode 1: Supervised (`/build`)

User provides requirements → Agent plans → User approves → Agent executes

```bash
/build "Build a landing page with hero section"
# Output: plan.md (for approval)
# User approves or provides feedback
# Agent executes with log-check checkpoints
```

### Mode 2: Autonomous (`/lfg` — "Let's Go")

Full workflow, agent drives to completion via Ralph Loop

```bash
/lfg "Build a todo app with CRUD, tests, docs. Promise: DONE when tests pass, logs clean & README complete"
# Agent: plans → images → deepens → works → log-check → reviews → compounds → iterates until DONE
```

## Key Components

### 1. Model: Claude Sonnet 4.6

Always use Sonnet 4.6:
- Speed + cost efficiency
- Strong reasoning for coding tasks
- Real-time feedback loop

### 2. Compound Engineering Workflow

| Phase | What | Output | Gate |
|-------|------|--------|------|
| **PLAN** | Research + structured plan + identify visual assets | plan.md + confidence score | Approval (supervised) |
| **DEEPEN** | Parallel research: frameworks, patterns, docs | research/* | Architecture |
| **WORK** | Execute todos incrementally + generate images | Code + commits + images | Log check |
| **LOG CHECK** | Read backend/frontend/Caddy logs, verify behavior | Clean logs ✅ or fix loop 🔁 | Review |
| **REVIEW** | Multi-agent review (correctness, perf, security) | review.md | Compound |
| **COMPOUND** | Document learnings for future work | docs/solutions/* | Done / Ralph loop |

---

## 🪲 Log Debug Loop (Added)

After every implementation, restart, or deploy — **always check logs**. Don't mark done until logs are clean.

### Log Locations Cheatsheet

```bash
# PM2 (production process manager)
pm2 logs <app-name> --lines 100
pm2 status

# Next.js dev server (captured from stdout/stderr during exec)
# Run and watch: npm run dev 2>&1 | tail -50

# Next.js production
pm2 logs my-app --lines 50

# Caddy reverse proxy
sudo journalctl -u caddy --since "5 minutes ago"
sudo journalctl -u caddy -n 50

# System logs (unexpected crashes)
sudo journalctl -n 100 --since "10 minutes ago"

# Browser console (for frontend/hydration errors)
# Use: browser(action=console, targetId=<tab-id>)
```

### Verify-with-Logs Step (Required after every WORK item)

After each implementation task:

1. **Start/restart** the service
   ```bash
   pm2 restart my-app
   # or: npm run dev &
   ```

2. **Trigger the behavior** (hit endpoint, load page)
   ```bash
   curl http://localhost:3000/api/my-endpoint
   # or: use browser tool to load the page
   ```

3. **Read the logs**
   ```bash
   pm2 logs my-app --lines 30 --nostream
   sudo journalctl -u caddy -n 20
   ```

4. **Check browser console** (for client-side errors)
   ```
   browser(action=console, targetId=<tab-id>)
   ```

5. **If errors found** → fix → loop back to step 1
6. **If clean** → mark task ✅ → proceed to REVIEW

### Ralph Autonomous Debug Loop

In autonomous mode, after each deploy:

```
[Ralph Loop — Post-Deploy Verification]
1. Run: curl http://62.238.6.59:<port>/api/health
2. Check: pm2 logs <app> --lines 50 --nostream
3. Check: sudo journalctl -u caddy -n 20
4. Open browser tool → take snapshot → check console
5. If any ERROR/WARN in logs → treat as test failure → fix → loop
6. If logs clean + UI renders correctly → mark ✅
7. If still failing after 3 fix attempts → emit <promise>BLOCKED</promise>
```

---

## 🖼️ Image Generation (Nano Banana Integration)

Images are generated **during PLAN phase** (before building components), so components are built with the right assets from the start.

### Decision Tree — Which Visual to Use?

```
Need a visual element?
        │
        ▼
Is it a small UI icon/symbol?
        │
    YES─┤→ Use Lucide Icons (built into shadcn)
        │   Examples: <Search />, <User />, <ChevronRight />
        │   Never generate icons — Lucide has 1500+ free
        │
    NO──┤
        ▼
Is it UI texture/pattern/decorative?
        │
    YES─┤→ Use Tailwind gradients / CSS patterns
        │   Examples: gradient-to-r, backdrop-blur, bg-grid-*
        │
    NO──┤
        ▼
Is it a photo, illustration, hero, feature card image, background art?
        │
    YES─┤→ Generate with Nano Banana (image_generate tool)
        │   VPS IP: 62.238.6.59 | Model: google/gemini-3-pro-image-preview
```

### Image Generation — Prompt Engineering Formula

```
[STYLE] + [SUBJECT] + [COMPOSITION] + [MOOD/COLORS] + [TECHNICAL]
```

**Style prefixes (pick one per image):**
- `Photorealistic, professional photography,` — real-world product/people shots
- `Flat design illustration, vector art style,` — clean icon-adjacent graphics
- `Abstract digital art,` — backgrounds, textures, decorative
- `3D render, product visualization,` — mockups, app screenshots
- `Minimalist concept art,` — feature illustrations

**Composition guidance by use case:**

#### Hero Section
```
Abstract flowing gradient in [brand color 1] and [brand color 2],
atmospheric depth, soft bokeh particles, modern tech aesthetic,
negative space on LEFT SIDE for text overlay (30% left / 70% right),
wide landscape composition 16:9,
calm and focused mood, ultra-high quality
```

#### Feature Card Images (set of 3-4, consistent)
```
Flat design illustration of [concept metaphor],
[same color palette as other feature images],
simple clean background, centered composition,
[brand color] accent, friendly and professional tone,
square format, consistent visual weight
```

#### Background / Section Texture
```
Subtle [color] mesh gradient texture,
low saturation, light and airy,
seamless tiling pattern,
non-distracting, no focal point,
suitable for white text overlay
```

#### Empty State / Placeholder
```
Friendly minimalist illustration of [metaphor for empty state],
muted [brand color] palette,
simple and encouraging,
clear metaphor (e.g., empty inbox = clean mailbox icon art),
centered, square format
```

#### Landing Page Product Mockup
```
Clean product screenshot mockup of [app description],
device frame: [MacBook / iPhone 15 / iPad],
white or dark studio background,
slight shadow and depth,
professional tech marketing aesthetic
```

### Image Workflow During PLAN Phase

```markdown
## Visual Assets Plan

### Icons (Lucide — no generation needed)
- Navigation: <Menu />, <X />
- Features: <Zap />, <Shield />, <Cpu />

### Generated Images (Nano Banana)
| File | Use | Prompt Template |
|------|-----|-----------------|
| public/images/hero-bg.jpg | Hero section bg | Abstract gradient, navy/violet... |
| public/images/feature-1.jpg | Feature card 1 | Illustration, lock concept... |
| public/images/feature-2.jpg | Feature card 2 | Illustration, speed concept... |
| public/images/empty-state.jpg | Empty inbox | Friendly minimal, clean mailbox... |

### Generation Order
Generate ALL images before building any component.
```

### Generation + Saving

```typescript
// In Next.js: save to /public/images/
// Structure: public/images/{category}/{filename}.jpg
// Examples:
//   public/images/hero/hero-bg.jpg
//   public/images/features/feature-analytics.jpg
//   public/images/ui/empty-state.jpg

// Use standard <Image /> component:
import Image from "next/image";
<Image
  src="/images/hero/hero-bg.jpg"
  alt="Hero background"
  fill
  priority
  className="object-cover"
/>
```

### Image Consistency Rules

1. **Same style prefix** for all feature images in one section
2. **Same color palette** — pull brand colors from Tailwind config
3. **Generate at 4K** — Next.js `<Image>` will optimize at runtime
4. **Name files descriptively** — `hero-analytics-dashboard.jpg`, not `img1.jpg`
5. **Commit with components** that use them — don't leave dangling assets

---

## 3. Clarification Handling (Hybrid Pattern)

When agent has a question:

1. Send question + options to Telegram inline buttons
2. Wait 5 minutes for response
3. If response → feed back to agent
4. If timeout → agent picks best option, logs assumption, continues

## 4. Git Workflow

- Create feature branch per task
- Incremental commits after each meaningful unit
- PR with adaptive description
- Parallel work via git worktrees (when needed)

---

## Quick Reference

### When to Use Agent vs Direct Edit

| Task | Approach |
|------|----------|
| Fix 1 typo / 1-line change | Edit tool directly |
| Simple style tweak | Edit tool directly |
| New feature / new page | `/build "description"` |
| New app / refactor | `/build "description"` |
| Overnight autonomous | `/lfg "description + <promise>DONE</promise>"` |

### Skills Auto-Included

| Scenario | Skills loaded |
|----------|--------------|
| Web app | `web-stack` + `context7` |
| Has images | `image_generate` tool (Nano Banana) |
| Deploying to VPS | `caddy` |
| Debug needed | Log locations cheatsheet (this file) |

### Full Checklist Before DONE

- [ ] Tests pass (>80% coverage)
- [ ] `pm2 logs` clean — no ERR/WARN
- [ ] `journalctl -u caddy` clean
- [ ] Browser console clean (no JS errors, no hydration errors)
- [ ] UI manually tested in browser via browser tool snapshot
- [ ] All images committed to `public/images/`
- [ ] README updated
- [ ] PR description complete
- [ ] Learnings documented in `docs/solutions/`

The agent will check every item before returning `<promise>DONE</promise>`.

---

## Integration Summary

| Skill | When | What it provides |
|-------|------|-----------------|
| `web-stack` | Web apps | Next.js + Tailwind + shadcn + TanStack Q |
| `caddy` | VPS deploy | Port allocation + reverse proxy |
| `context7` | Framework code | Latest docs (not stale training data) |
| `image_generate` | Any image need | Nano Banana (gemini-3-pro-image-preview) |
| `stealth-browser` | Frontend verify | Screenshot + console check |

---

## Compound Engineering Principles

1. **Plan before code** — 80% planning, 20% execution
2. **Images before components** — generate assets, then build around them
3. **Log check after every work item** — behavior > syntax
4. **Multi-agent review** — never ship without structured review
5. **Document learnings** — each solved problem compounds future work
6. **Confidence gating** — only proceed when confidence > threshold
7. **Iterative refinement** — Ralph loop for autonomous polish
