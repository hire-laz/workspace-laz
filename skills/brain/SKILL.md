---
name: brain
description: Personal knowledge management system for named entities — people, places, games, tech, events, media, ideas, organizations. Use when user asks to remember someone/something, shares information about a person/place/item, updates knowledge, or asks about something that might be in the brain. Stores structured profiles with attachments and relationships. Triggered by keywords like "remember", "met", "visited", "what do I know about", "note that".
---

# Brain Skill — 2nd Brain Knowledge Base

Capture and retrieve information about named entities: people, places, games, tech products, events, media, ideas, organizations.

## When to Use

Brain takes precedence over daily logs for **named entities**.

Trigger when:
- User asks you to **remember** someone, something, somewhere
- User **shares information** about a person, place, game, restaurant, product, event, media, idea, org
- User **expresses a preference** ("I like X at Y restaurant" → update Y's profile)
- User **asks about something** ("Who was that guy...", "What did I think about...")
- User **updates knowledge** ("Actually, she's 28 now", "I finished that game")

**Keywords:** "remember", "note that", "met this person", "visited", "played", "watched", "read", "idea:", "what do I know about", "who is", "where was"

⚠️ **IMPORTANT:** Do NOT put brain-eligible content in daily logs. Named entities belong in `brain/`, not in `memory/YYYY-MM-DD.md`. Daily logs are for session context only.

## Data Locations

All brain data lives in: `~/.openclaw/workspace/brain/`

```
brain/
├── people/          # Contacts, people you've met
├── places/          # Restaurants, landmarks, venues, locations
├── games/           # Video games and interactions
├── tech/            # Devices, products, specs
├── events/          # Conferences, meetups, gatherings
├── media/           # Books, shows, films, podcasts
├── ideas/           # Business ideas, concepts, thoughts
└── orgs/            # Companies, communities, groups
```

## Search & Retrieval

### Searching
Use `memory_search` for all brain lookups:

```
memory_search("Cho Lim")              # find a person
memory_search("Mamou Prime")           # find a place
memory_search("what games played")     # natural language
```

### Reading a File
Use `memory_get` once you know the path:

```
memory_get("brain/people/cho-lim.md")
memory_get("brain/places/mamou-prime/mamou-prime.md")
```

## Operational Rules

### Creating a New Entry

1. **Search first** — `memory_search("")` to check for existing entries
2. **No match** — Create new file using template from `skills/brain/templates/`
3. **Possible clash** — List matches and ask Cho to confirm before creating

### Updating an Existing Entry

1. **Find the file** — `memory_search` or direct path
2. **Surgical edit** — Update only relevant section
3. **Log the date** — Add timestamp to Notes or Interactions
4. **Update frontmatter** — Bump `last_updated` field

### Disambiguation

When user references something ambiguous (e.g., "John"):

- Search brain for all matches
- List them with context if multiple results
- Wait for confirmation before updating

## Attachments (MANDATORY)

When user sends media (photos, audio, video, PDF) about a brain entry:

🚨 **ALWAYS save the actual FILE to attachments/. This is non-negotiable.**

Then analyze/transcribe content into the profile. **Do BOTH.**

### Folder Structure (with attachments)

```
brain/places/mamou-prime/
├── mamou-prime.md              # Profile (keeps original name)
└── attachments/
    ├── index.md                # Describes each file
    ├── menu-page-1.jpg
    ├── menu-page-2.jpg
    ├── receipt.pdf
    └── storefront.mp4
```

### Attachments Index (attachments/index.md)

```markdown
# Attachments

| File | Description | Added |
|------|-------------|-------|
| menu-page-1.jpg | Menu first page, mains | 2026-04-21 |
| menu-page-2.jpg | Menu second page, desserts | 2026-04-21 |
| receipt.pdf | Receipt from Feb visit, ₱2,400 | 2026-04-21 |
| storefront.mp4 | Quick video of entrance | 2026-04-21 |
```

### Adding Attachments Workflow

1. Find entry — `memory_search("Mamou Prime")`
2. Convert to folder (if flat file):
   ```bash
   mkdir -p brain/places/mamou-prime/attachments
   mv brain/places/mamou-prime.md brain/places/mamou-prime/
   touch brain/places/mamou-prime/attachments/index.md
   ```
3. Save media to `attachments/` with descriptive filenames
4. Update `attachments/index.md` with descriptions
5. Transcribe content into profile (tables, text, etc.)

## Templates

Templates live in `skills/brain/templates/`. Each has YAML frontmatter and markdown body.

When creating a new entry:
- Read the appropriate template
- Fill in known fields
- Leave unknown fields empty
- Write to `brain/<category>/<slug>.md`

## Linking Entities

Use wikilink-style references to connect entities:

- `[[people/cho-lim]]` — link to a person
- `[[places/mamou-prime]]` — link to a place
- `[[orgs/lazy-lifter]]` — link to an org

## Categories Reference

| Category | Folder | Use For |
|----------|--------|---------|
| People | brain/people/ | Anyone Cho has met or wants to remember |
| Places | brain/places/ | Restaurants, landmarks, venues, locations |
| Games | brain/games/ | Video games — status, opinions, notes |
| Tech | brain/tech/ | Devices, products, specs, quirks |
| Events | brain/events/ | Conferences, meetups, gatherings |
| Media | brain/media/ | Books, shows, films, podcasts |
| Ideas | brain/ideas/ | Business ideas, concepts, random thoughts |
| Orgs | brain/orgs/ | Companies, communities, groups |

## Example Workflow

**User:** "Hey, I just met this guy Raven Duran at GeeksOnABeach PH in February. He's positioning himself as an Agentic coder."

**Agent does:**
1. `memory_search("Raven Duran")` → no results
2. Read template: `skills/brain/templates/person.md`
3. Create `brain/people/raven-duran.md` with filled template
4. Optionally: create/link `brain/events/geeksonabeach-ph-2026.md`

**User:** "Actually, Raven is 27 now"

**Agent does:**
1. `memory_search("Raven Duran")` → finds entry
2. Read via `memory_get("brain/people/raven-duran.md")`
3. Update `age: 27` in frontmatter
4. Add note: `- **2026-04-21**: Confirmed age 27`
5. Update `last_updated` field

## Rules

- ✅ Save original files in attachments/
- ✅ Transcribe/analyze content into profile
- ✅ Do BOTH (never skip file saving)
- ✅ Use wikilinks to connect entities
- ✅ Update frontmatter timestamps
- ❌ Don't discard attachments unless user says "cleanup"
- ❌ Don't put named entity info in daily logs
