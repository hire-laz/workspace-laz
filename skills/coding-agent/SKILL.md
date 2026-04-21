---
name: coding-agent
description: Coding Agent using Claude Code + Compound Engineering workflow. Uses Sonnet 4.6 for all coding tasks. Handles planning, deepening, work execution, review, and learning capture. Supports both supervised mode (/build) and autonomous mode (/lfg).
---

# Coding Agent — Compound Engineering + Claude Code

AI-powered development using Sonnet 4.6, structured around the Compound Engineering philosophy: "Each unit of engineering work should make subsequent units easier."

## Architecture

```
┌─────────────────────────────────────────┐
│     COMPOUND ENGINEERING WORKFLOW       │
├─────────────────────────────────────────┤
│                                         │
│  PLAN → DEEPEN → WORK → REVIEW → COMPOUND
│   ↓       ↓        ↓       ↓         ↓
│  Brainstorm Parallel  Execute Multi-agent Document
│  + plan    skills    todos   review  learnings
│                                ↓
│                          Ralph Loop
│                     (autonomous iteration)
│
└─────────────────────────────────────────┘
```

## Usage Modes

### Mode 1: Supervised (`/build`)

User provides requirements → Agent plans → User approves → Agent executes

```bash
/build "Build a REST API with auth and tests"
# Output: plan.md (for approval)
# User approves or provides feedback
# Agent executes with checkpoints
```

### Mode 2: Autonomous (`/lfg` — "Let's Go")

Full workflow, agent drives to completion via Ralph Loop

```bash
/lfg "Build a todo app with CRUD, tests, docs. Promise: DONE when tests pass & README complete"
# Agent: plans → deepens → works → reviews → compounds → iterates until DONE
```

## Key Components

### 1. Model: Claude Sonnet 4.6

Always use Sonnet 4.6 for:
- Speed (faster than Opus)
- Cost efficiency
- Strong reasoning for coding tasks
- Real-time feedback loop capability

### 2. Compound Engineering Workflow

| Phase | What | Output | Next |
|-------|------|--------|------|
| **PLAN** | Research + structured plan | plan.md + confidence score | Approval gate (supervised) |
| **DEEPEN** | Parallel skill research (frameworks, patterns, etc) | research/* (context enrichment) | Architecture diagram |
| **WORK** | Execute work items incrementally | Code commits + tests | Review prep |
| **REVIEW** | Multi-agent code review (correctness, perf, security, style) | review.md + approval | Merge + compound |
| **COMPOUND** | Document learnings for future work | docs/solutions/* | Ralph loop (autonomous) |

### 3. Clarification Handling (Hybrid Pattern)

When agent has a question:

1. Send question + options to Telegram inline buttons
2. Wait 5 minutes for response
3. If response → feed back to agent
4. If timeout → agent picks best option, logs assumption, continues

### 4. Git Workflow

- Create feature branch per task
- Incremental commits with value-communicating messages
- PR with adaptive description
- Parallel work via git worktrees (when needed)

## Quick Reference

### Invoke Directly (for single file edits)

```bash
# Simple one-liner fix (don't use agent)
edit: Use the Edit tool directly
```

### Invoke Coding Agent

```bash
# Feature/refactor/new app
/build "Feature description"

# Overnight autonomous work
/lfg "Feature + success criteria + <promise>DONE</promise>"
```

### Web Apps

If building a web app, the agent automatically includes:
- Context from `skills/web-stack/SKILL.md`
- Latest Next.js + Tailwind + shadcn + TanStack Query
- All installed via CLI (always @latest for security)

### Deployment

If deploying to VPS (62.238.6.59), the agent includes:
- Context from `skills/caddy/SKILL.md`
- Auto-port allocation + reverse proxy config
- Live reload verification

## Configuration

Model override: `SONNET_4_6` (set by default)

Allowed tools: `Read, Edit, Write, Bash, Glob, Grep, WebSearch`

Permission mode: `acceptEdits` (agent can modify files directly)

Hooks: Clarification handler routes to Telegram + 5min timeout

## Compound Engineering Principles

1. **Plan before code** — 80% planning, 20% execution
2. **Multi-agent review** — Don't ship without structured review
3. **Document learnings** — Each solved problem compounds team knowledge
4. **Parallel research** — Spawn agents to deepen context simultaneously
5. **Confidence gating** — Only proceed when confidence > threshold
6. **Iterative refinement** — Ralph loop for autonomous polish

## Integration with Other Skills

- **web-stack**: Auto-included for web apps (Next.js + Tailwind + shadcn + TanStack Query)
- **caddy**: Auto-included for VPS deployments (port allocation + reverse proxy)
- **context7**: Auto-included for framework docs lookup

## Testing Before Ship

Before marking a task DONE:

- [ ] Run full test suite (>80% coverage)
- [ ] Manual testing in browser (if web app)
- [ ] Code review passed (all agents)
- [ ] PR description complete + linked
- [ ] README updated
- [ ] Learnings documented in docs/solutions/

The agent will verify all of these before returning <promise>DONE</promise>.
