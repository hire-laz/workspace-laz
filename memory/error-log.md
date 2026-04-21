# Error Log — Auto-Captured Learnings

This is an append-only log. Every failure, correction, gotcha, and discovery gets logged here immediately — mid-conversation, in real-time.

## Legend
- 🔧 `tool-failure` — something broke
- 🧠 `wrong-assumption` — assumed wrong
- 🔄 `user-correction` — Cho said "no, do it this way"
- 💡 `discovery` — learned something useful
- ⚠️ `gotcha` — undocumented or subtle trap
- 🏗️ `architecture` — structural decision worth remembering

---

## 2026-04-21

- 💡 **Image model alias** — "Nano Banana Pro 2" = `google/gemini-3-pro-image-preview`. Always use this as the default image generation model.
- ⚠️ **agent-browser on VPS needs --no-sandbox** — Chrome exits early without it. Always set `AGENT_BROWSER_ARGS="--no-sandbox"` before launching agent-browser.
- 🧠 **agent-browser batch JSON escaping** — Single-quote JSON headers work in individual commands but break in batch mode due to shell escaping. Use individual commands, not batch.
- ⚠️ **VPS IP geolocation is Germany** — Despite setting Philippines geo/headers in agent-browser, sites like Google detect the server IP as DE. Language headers (en-PH) are applied but IP-based geolocation cannot be overridden without a PH proxy.
- 🔄 **LLM idle timeout** — Set to 300s (5 minutes). Default was 120s.
- 🏗️ **QMD memory backend** — Enabled with brain/, skills/, error-log.md indexed. Session transcripts enabled. This is the primary memory system.

- ⚠️ **GitHub PAT scope issue** — PAT token has `allows_permissionless_access=true` instead of explicit repo write scope. Pushing via git requires repo write scope. Workaround: Use `gh auth setup-git` + `gh` CLI for push, or request PAT with `repo` scope.
- ⚠️ **GitHub fine-grained PAT blocked by org policy** — The hire-laz org requires org approval for fine-grained PATs (github_pat_11...). Git push returns 403 "Permission denied to coderaven" even though API shows push:true permissions. Fix: org owner must go to Settings → Personal access tokens → Approve the pending PAT request. OR: generate a classic PAT (ghp_...) with `repo` scope instead — classic PATs bypass org approval requirement.
- 💡 **"checkpoint" command** — When Cho says "checkpoint": cd to ~/.openclaw/workspace, commit with relevant message, git push to origin.
- 🏗️ **File organization rules** — Documents/ for generated files, Projects/ for apps, Temp/ for scratch/channel delivery. Never put random files in workspace. Temp/ is in .gitignore.
- 💡 **Channel delivery workflow** — For Discord/Telegram that need file paths, copy to ~/Temp/ first, send from there. Temp not committed.
- 🏗️ **Proactive Agent System (v1.0) implemented** — Three phases: Foundation (WAL, working buffer, compaction recovery), Proactivity (reverse prompting, pattern recognition, outcome tracking), Self-Improvement (VBR, ADL/VFM scoring, relentless resourcefulness). Built from Hal Stack proactive-agent analysis.
- 💡 **SESSION-STATE.md is the RAM** — Write corrections/decisions BEFORE responding. Survives session end.
- ⚠️ **Working buffer protocol** — After 60% context, log every exchange to memory/working-buffer.md. Survives compaction.
- 💡 **Heartbeat is systematic** — Full proactive checklist in HEARTBEAT.md (outcomes, patterns, surprises, growth loops). Not optional, triggers every 2-3 days.
- 🏗️ **Upstream update checker cron** — Daily 8am Manila (midnight UTC). Checks 6 ClawHub skills + OpenClaw version for updates. Notification only, never auto-updates. Tracker file: `skills/upstream-tracker.json`. Cron ID: c40a4828-2950-44a5-b835-c687436ae4d2.
