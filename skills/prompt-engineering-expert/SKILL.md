---
name: prompt-engineering-expert
description: Analyze, generate, refine, and optimize prompts for LLMs. Use when crafting system prompts, improving weak prompts, debugging prompt failures, building prompt templates, or generating complex multi-step prompts for Claude, GPT, or any LLM. Covers techniques like chain-of-thought, few-shot, role-play, structured output, and prompt testing.
---

# Prompt Engineering Expert

Analyze, generate, and refine prompts for maximum effectiveness.

## When to Use

- Crafting system prompts for agents or bots
- Improving prompts that produce weak or inconsistent results
- Debugging why a prompt fails (hallucinations, wrong format, off-topic)
- Building reusable prompt templates
- Generating few-shot examples
- Extracting structured data from unstructured text
- Creating role-based prompts for specialized tasks

## Core Workflow

1. **Understand the goal** — What task? What output format? What constraints?
2. **Analyze current prompt** (if exists) — What's missing? What's ambiguous?
3. **Apply technique** — Pick the right prompting pattern
4. **Write the prompt** — Clear, specific, structured
5. **Add test cases** — At least 2 examples to verify

See `references/techniques.md` for detailed patterns.
See `references/templates.md` for reusable templates.
See `references/best-practices.md` for rules and anti-patterns.

## Quick Reference: Prompt Structure

```
[ROLE] You are a [specific role] who [key behavior/constraint].

[CONTEXT] Background info the model needs.

[TASK] Specific instruction: verb + object + constraints.

[FORMAT] Output format: JSON / markdown / bullet list / etc.

[EXAMPLES] (optional but powerful)
Input: ...
Output: ...

[CONSTRAINTS] What NOT to do. Length. Language. Tone.
```

## Core Techniques (Summary)

| Technique | When to Use | Key Signal |
|---|---|---|
| Zero-shot | Simple, clear tasks | Direct instruction suffices |
| Few-shot | Complex formatting / tone | Show 2-5 examples |
| Chain-of-thought | Reasoning / math / logic | Add "Think step by step" |
| Role-play | Domain expertise needed | "You are a [expert]..." |
| Structured output | JSON/XML/table required | Specify schema + examples |
| System + user split | Multi-turn agents | System = identity, user = task |
| Self-consistency | High-stakes answers | Generate N, pick consensus |
| Step-back | Broad principles first | "What general principle applies?" |

→ Full detail in `references/techniques.md`

## Anti-Patterns (Never Do These)

- Vague verbs: "write something about X" → use "write a 3-bullet summary of X"
- Contradictory constraints: asking for "formal but casual"
- Over-cramming: 500 words of context when 50 suffice
- No format spec: model guesses, inconsistently
- Sycophancy bait: "Can you please write..." → just give the instruction
- Negation-only: "Don't write X" → also say what to write instead
