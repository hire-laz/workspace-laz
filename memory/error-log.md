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
