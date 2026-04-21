# SESSION-STATE.md — Active Working Memory (RAM)

**Purpose:** Critical details from the current session. This is your working memory — it survives context loss and manual context clearing.

**Update Pattern:** Write here IMMEDIATELY when corrections, decisions, proper nouns, preferences, or specific values appear in messages. Write BEFORE responding.

**Lifecycle:** Cleared at session end, rebuilt from memory/working-buffer.md + MEMORY.md at session start.

---

## Current Session Context

**Session Start:** [auto-filled by agent]
**Last Updated:** [auto-filled by agent]

### Active Tasks

- 

### Recent Corrections & Decisions

- 

### Preferences Stated This Session

- 

### Names, Places, Identifiers

- 

### Specific Values (dates, URLs, IDs, etc)

- 

### Ongoing Notes

- 

---

## WAL Trigger Checklist (every message)

Scan incoming message for:
- ✏️ Corrections ("It's X, not Y" / "Actually..." / "No, I meant...")
- 📍 Proper nouns (names, places, companies)
- 🎨 Preferences (colors, styles, "I like/don't like")
- 📋 Decisions ("Let's do X" / "Use Y")
- 📝 Draft changes (edits to work-in-progress)
- 🔢 Specific values (numbers, dates, IDs, URLs)

**If ANY trigger fires:** Write to this file FIRST, then respond.
