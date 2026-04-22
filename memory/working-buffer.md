# Working Buffer — Danger Zone Log

**Purpose:** Capture EVERY exchange between 60% and full context. Survives compaction.

**Status:** INACTIVE (starts recording after 60% context threshold)
**Started:** [timestamp when 60% threshold hit]

---

## Protocol

1. **Trigger:** When `session_status` shows context ≥60%, start logging here
2. **Every Message:** Append human's message + agent's response summary (1-2 sentences + key details)
3. **After Compaction:** Read this buffer FIRST to recover context
4. **Clear:** Only after important context is extracted to SESSION-STATE.md
5. **Rule:** Once in danger zone, NO EXCEPTIONS — every exchange gets logged

---

## [DANGER ZONE EXCHANGES START HERE]

(Format: ## [timestamp] HUMAN / ## [timestamp] AGENT [summary])

## Session: 2026-04-22 (Major Setup Day)

### Key Things Built
- **Discord bot** connected to "Cho Lim" server (guild 1496363328581140542) — token in openclaw.json. requireMention=true, autoThread=true
- **GitHub skill** reset with new PAT (github_pat_11AAE2EEA0u7OjQhlj1Yf4_...) — org approval resolved, push working
- **Scrapling skill** installed at skills/scrapling/SKILL.md + venv at ~/.scrapling-env
- **Huashu-Design skill** installed at skills/huashu-design/ — use for prototypes, PPTX, motion, infographics, critiques
- **landing-page-builder skill** installed at skills/landing-page-builder/ — use for marketing landing pages
- **NutriKaizen landing page** rebuilt at /home/laz/Projects/nutrition-funnel, running on PORT=3001 via `env PORT=3001 npm run start`
- **UFW disabled** — Hetzner handles firewall. Remove UFW from future VPS setups
- **SSH hardened** — PasswordAuthentication no, PermitRootLogin no, in /etc/ssh/sshd_config
- **Watchdog fixed** — Only alerts if fail2ban is DOWN, not on normal SSH brute-force noise

### Critical Lessons Logged
- **PORT=3001 must be explicit** — Next.js defaults to 3000, always use `env PORT=3001`
- **Always QA before delivering** — screenshot + browser verify + check images load
- **PDF slides margin:0** — margin: 20px auto causes overflow in PDF (fixed in SKILL.md)
- **landing-page-builder rules**: lucide-react only (no emoji), alternating layouts (no repeated patterns), testimonials NOT 3-card grid, FAQ required (SEO), schema markup required

### Active Projects
- **NutriKaizen** waitlist page live at http://62.238.6.59:3001/ (9-section blueprint, fully rebuilt)
- **nutrition-funnel** at /home/laz/Projects/nutrition-funnel (Next.js 16.2.4)

### Browser Fallback Stack
Agent Browser → Stealth Browser (Camoufox) → Scrapling → (proxy if all fail)

### Cho's Brand
- The Lazy Lifter (umbrella brand)
- Kaizen 100-Day Transformation Program™ (Season 10: July 2026)
- NutriKaizen Season 1 (nutrition variant, Summer 2026)
- Brand knowledge at memory/cho-brand-knowledge.md
