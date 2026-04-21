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
