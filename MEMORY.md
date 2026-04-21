# MEMORY.md — Long-Term Memory

Curated learnings. Not raw logs — distilled wisdom that persists.

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
