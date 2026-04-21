---
name: context7
description: Fetch latest, version-accurate documentation for any library or framework via Context7. Use when building apps, writing code, or needing current API references for Next.js, React, Tailwind, Remotion, Playwright, or any other library. Prevents using outdated/deprecated patterns. Always use this before writing code for a framework you haven't touched in a while.
---

# Context7 — Always-Fresh Documentation

Context7 fetches live, up-to-date docs for any library. Prevents coding against outdated APIs.

## When to Use

- Before writing code for any framework (Next.js, React, Tailwind, Remotion, etc.)
- When unsure if an API is still current
- Before creating a new app/project
- Anytime you might use deprecated patterns

## MCP Configuration

Context7 is registered as an MCP server in OpenClaw config:

```json
{
  "mcp": {
    "servers": {
      "context7": {
        "type": "http",
        "url": "https://mcp.context7.com/mcp",
        "auth": {
          "type": "bearer",
          "token": "ctx7sk-13f7b82d-aadf-41e3-989a-08ac3283a95d"
        }
      }
    }
  }
}
```

## REST API (Fallback)

If MCP is not available, use the REST API directly:

```bash
# Search for a library
curl -s -H "Authorization: Bearer ctx7sk-13f7b82d-aadf-41e3-989a-08ac3283a95d" \
  "https://context7.com/api/v1/search?q=nextjs" | python3 -m json.tool

# Get docs for a specific library
curl -s -H "Authorization: Bearer ctx7sk-13f7b82d-aadf-41e3-989a-08ac3283a95d" \
  "https://context7.com/api/v1/libraries/nextjs/docs" | python3 -m json.tool
```

## Usage Pattern

Before coding any library:

1. Check Context7 for the latest version + breaking changes
2. Use the exact API from current docs — not from training data
3. Note any deprecated patterns to avoid

## 🚨 CRITICAL — Next.js Security Rule

**ALWAYS create Next.js apps with the absolute latest version.**

```bash
# ALWAYS use latest — never omit the version flag
npx create-next-app@latest my-app

# NEVER do this (pins to potentially vulnerable version)
npx create-next-app my-app
```

**Why:** Older Next.js versions have known RCE and authorization bypass vulnerabilities (CVE-2025-29927 and others). Always use `@latest`. Always check Context7 for the current stable version before scaffolding.

**Current practice:**
- `npx create-next-app@latest` — always
- Verify version in package.json after scaffold
- Check Context7 for any breaking changes in latest version

## Common Library IDs

| Library | Context7 Search Term |
|---------|---------------------|
| Next.js | `nextjs` or `vercel/next.js` |
| React | `react` or `facebook/react` |
| Tailwind CSS | `tailwindcss` |
| Remotion | `remotion` or `remotion-dev/remotion` |
| Playwright | `playwright` or `microsoft/playwright` |
| Camoufox | `camoufox` |
| Prisma | `prisma` |
| TypeScript | `typescript` |
| shadcn/ui | `shadcn-ui` |
| Framer Motion | `framer-motion` |

## Integration Notes

- API Key: stored in OpenClaw MCP config (never hardcode in scripts)
- MCP endpoint: `https://mcp.context7.com/mcp`
- REST API: `https://context7.com/api/v1`
- If MCP tools aren't available, use REST API via exec/curl
