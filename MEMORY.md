# MEMORY.md — Long-Term Memory

Curated learnings. Not raw logs — distilled wisdom that persists.

## 🔍 Recall Protocol (CRITICAL)

Before saying "I don't know" — exhaust all recall paths:
1. `memory_search "<keyword>"` — semantic search
2. `grep -ri "<keyword>" /home/laz/.openclaw/workspace/memory/` — raw files
3. Check `memory/projects/` subdirectories
4. Check daily logs: `memory/YYYY-MM-DD.md` (recent days)
5. `find ~/Projects -name "*.md" | xargs grep -li "<keyword>"` — codebase search
6. `sessions_list` — active sessions

One failed search ≠ no context. Keep digging. Ask Cho to remind rather than admitting defeat.

---

## Identity & Core Setup (2026-04-21)

- **Operating Timezone:** GMT+8 (Manila, Philippines) — always use this
- **Default Image Model:** `google/gemini-3-pro-image-preview` (nickname: "Nano Banana Pro 2")
- **Default Browser:** agent-browser (Vercel's agent-browser CLI)
  - Always use `AGENT_BROWSER_ARGS="--no-sandbox"` on this VPS
  - Screenshots work fine, language headers set to en-PH
  - VPS IP is German (no PH geolocation possible without proxy)
- **LLM Idle Timeout:** 300s (5 minutes)

## Memory Architecture (3-Layer)

We built a system that prevents repeating mistakes:

1. **Error Log** (`memory/error-log.md`) — append-only, every mistake logged immediately
2. **Brain** (`brain/{people,places,games,tech,events,media,ideas,orgs}/`) — named entity knowledge graph
3. **Heartbeat Maintenance** — distill daily logs into MEMORY.md periodically

QMD provides local-first semantic search across everything.

## Tools & Skills Status

- ✅ **agent-browser-ph** — Browser skill installed with Philippines locale headers + --no-sandbox wrapper
- ✅ **brain** — 2nd Brain skill installed with templates (person, place, game, tech, event, media, idea, org)
- ✅ **QMD** — Memory backend enabled, indexing workspace + brain + skills + error-log + session transcripts

## Key Gotchas to Remember

- Agent-browser on VPS needs `--no-sandbox` — Chrome exits early without it
- Agent-browser batch mode has JSON escaping quirks — use individual commands instead
- VPS IP is detected as Germany by Google/other IP-based geolocation
- Don't put named entities in daily logs — they belong in `brain/`
- Brain attachments MUST be saved to files — transcribing alone is not enough

## Commands & Shortcuts

- **checkpoint** — Go to `~/.openclaw/workspace`, commit latest changes with a relevant commit message, then `git push` to origin. Do this whenever Cho says "checkpoint".

## File & Output Rules (2026-04-21)

- **~/Documents/** — ALL generated files go here (images, videos, audio, docs, PDFs). Never in workspace.
- **~/Projects/** — Apps and websites go here, one subfolder per project.
- **~/Temp/** — Scratch pad and channel delivery staging (Discord/Telegram). In .gitignore, never committed.
- **Workspace** — Skills, memory, configs ONLY. No random files or generated output.
- **Channel delivery exception:** When Discord/Telegram requires a file path, copy to ~/Temp/ first, send from there.
- **checkpoint** — cd ~/.openclaw/workspace → git commit (relevant message) → git push to origin.

## Proactive Agent System (Laz-Proactive v1.0)

Built from analysis of the Hal Stack's proactive agent patterns. Three pillars:

### 1. Foundation: Survive Context Loss
- **SESSION-STATE.md** — Write corrections/decisions here BEFORE responding (WAL Protocol)
- **working-buffer.md** — Log every exchange after 60% context
- **Compaction Recovery** — Auto-trigger when missing context; read buffer first

### 2. Proactivity: Act Without Being Asked
- **Reverse Prompting** — Ask "What would delight Cho?" every few conversations
- **Pattern Recognition** — Track recurring requests; 3+ = propose automation
- **Outcome Tracking** — Follow up on decisions >7 days old
- **Proactive Surprise** — Build something amazing Cho didn't ask for (draft → approve → execute)

### 3. Self-Improvement: Get Better Over Time
- **VBR (Verify Before Done)** — Test behavior, not just output
- **ADL/VFM Scoring** — Score changes for leverage, stability, fit before implementing
- **Relentless Resourcefulness** — Try 10 approaches before giving up
- **Heartbeat Loops** — Curiosity, pattern recognition, outcome tracking during periodic check-ins

### Key Files
- SESSION-STATE.md — Active RAM (corrections, decisions, preferences)
- memory/working-buffer.md — Danger zone log (survives compaction)
- memory/proactive-tracker.md — Patterns, outcomes, proactive ideas
- HEARTBEAT.md — Proactive checklist every 2-3 days

### The Mindset Shift
Old: "What should I do?" → New: "What would genuinely delight Cho?"


## Upstream Update Checker (2026-04-21)

- **Cron:** Daily 8am Manila (midnight UTC), isolated agentTurn
- **What it checks:** 6 ClawHub skills + OpenClaw releases
- **Tracker:** `skills/upstream-tracker.json` — versions, sources, last checked dates
- **Rule:** NEVER auto-update. Notify Cho only.
- **Skills tracked:** youtube-watcher, humanizer, remotion-video-toolkit, prompt-engineering-expert, superdesign, brain (2nd-brain)
- **OpenClaw:** Current v2026.4.15

## Security & Monitoring (2026-04-21)

**fail2ban** — Installed & configured for SSH brute-force protection
- Config: `/etc/fail2ban/jail.local`
- Rule: 5 failed login attempts = 30min ban
- Status: `sudo fail2ban-client status sshd`
- Log: `/var/log/auth.log`

**VPS Watchdog Cron** — Every 30 minutes, isolated agentTurn
- Cron ID: `8c46cfe6-b42d-4166-b0c3-c659be5f9c7c`
- Script: `~/.openclaw/workspace/skills/vps-watchdog/scripts/watchdog.sh`
- Schedule: `*/30 * * * *` (Asia/Manila TZ)
- Checks: miners, malware, brute-force (fail2ban), CPU, RAM, load, rootkit indicators
- Alert thresholds (no false positives):
  - CPU: >85% sustained (3 samples over 15s, not spike)
  - RAM: >90% used (excludes buffer/cache)
  - Load: >3x num CPU cores (4 cores = >12)
  - SSH failures: >50 in 10min window
  - Any miner process match
  - Any unexpected SUID in /tmp or /dev/shm
- Silent on clean runs (no message unless real threat found)
- Telegram alerts to Cho when threats detected

**Watchdog false positive prevention:**
- Root process whitelist: 30+ common Ubuntu services
- CPU checked 3x (5s apart) to avoid spikes
- RAM calculated: (total - available) / total × 100 (proper method)
- fail2ban: only alerts if banned_count > 0 (not on empty "Banned IP list:")

## Coding Agent Stack (2026-04-21)

**Claude Code CLI:** v2.1.116 — `~/.local/bin/claude`
- Configured via OpenRouter (env vars in .zshrc)
- Non-interactive: `~/.local/bin/claude -p "prompt"`
- Model: Sonnet 4.6 (via OpenRouter)
- ANTHROPIC_BASE_URL = https://openrouter.ai/api

**Compound Engineering Workflow:**
- PLAN → DEEPEN → WORK → REVIEW → COMPOUND
- Supervised mode: `/build "feature"` (plan + approval gate)
- Autonomous mode: `/lfg "feature + <promise>DONE</promise>"` (Ralph Loop)
- Multi-agent review before shipping
- Document learnings in docs/solutions/

**Skills Built:**
- `skills/coding-agent/SKILL.md` — full workflow with Sonnet 4.6
- `skills/web-stack/SKILL.md` — Next.js 16+ + Tailwind + shadcn + TanStack Query
- `skills/caddy/SKILL.md` — VPS port management (62.238.6.59)
- `skills/caddy/port-registry.json` — port allocation registry (3000-3200)

**Test Results:**
- Claude Code: ✅ Non-interactive test (2+2=4), using OpenRouter
- Next.js 16.2.4: ✅ Scaffolded + built successfully via `create-next-app@latest`
- TanStack Query v5.99.2: ✅ Installed
- Port registry: ✅ Allocation + free logic working
- shadcn: requires interactive mode (runs in terminal, normal)

**VPS Deployment:**
- IP: 62.238.6.59 (same VPS we're on)
- Port range: 3000-3200
- Caddy: local (no SSH needed), `sudo systemctl reload caddy`
- Deploy: build → allocate port → start → caddy reload → verify
