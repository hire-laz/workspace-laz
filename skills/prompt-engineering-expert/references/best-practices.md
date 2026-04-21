# Prompt Engineering Best Practices

## Golden Rules

1. **Be specific, not vague**
   - ❌ "Write something about fitness"
   - ✅ "Write a 3-paragraph guide on habit stacking for beginners, using The Lazy Lifter's 100-day principle"

2. **Show, don't tell**
   - ❌ "Write in a funny way"
   - ✅ [provide 2 funny examples] "Write in this tone"

3. **Separate concerns**
   - System prompt = who/what you are
   - User message = the specific task
   - Constraints = what not to do
   - Format = exact output shape

4. **Constraints are features**
   - Word limits force clarity
   - Format specs enable parsing
   - Tone guidance prevents mismatches

5. **Test and iterate**
   - Try your prompt
   - Is output what you expected? If not, diagnose why
   - Refine and test again

---

## Do's ✅

- **Use imperative verbs:** Generate, write, analyze, summarize, classify
- **Specify output format:** JSON, markdown, bullet list, paragraph, etc.
- **Include examples:** 2-5 examples beats vague description
- **Set constraints:** Word count, length, tone, audience, what to avoid
- **Use system + user split:** Keep identity in system, tasks in user
- **Chain of thought for reasoning:** Add "think step-by-step"
- **Be explicit about tradeoffs:** "Prioritize X over Y if conflicted"
- **Test with multiple inputs:** Don't assume one success = always works

---

## Don'ts ❌

- **Don't use negation only:** "Don't write X" → also say what to write
- **Don't be vague:** "Write about this" → specify what, length, format, audience
- **Don't mix conflicting goals:** "Formal but casual" → pick one or clarify
- **Don't assume the model knows context:** Provide it explicitly
- **Don't cram everything:** Long prompts fail. Be concise.
- **Don't use sycophancy bait:** "Could you please" → just give the instruction
- **Don't trust hallucinations:** Ask for reasoning, sources, confidence
- **Don't put user input directly in prompt:** Sanitize and clearly separate

---

## Debugging Weak Prompts

**Symptom: Output is off-topic**
- Fix: Add explicit constraint ("Focus only on X")
- Test: Rerun with constraint

**Symptom: Format is wrong (expected JSON, got paragraphs)**
- Fix: Add example of correct format
- Test: Include the example in prompt

**Symptom: Tone is wrong (too formal, should be casual)**
- Fix: Add examples of desired tone OR specify the tone explicitly
- Test: Show good/bad examples

**Symptom: Output is too long or too short**
- Fix: Set word/bullet count explicitly
- Test: Verify it respects the constraint

**Symptom: Model makes things up (hallucinations)**
- Fix: Add "say 'I don't know' if you don't have reliable info"
- Fix: Ask for sources or reasoning
- Test: Check if model is more conservative

**Symptom: Inconsistent results on similar inputs**
- Fix: Add few-shot examples (2-5)
- Test: Run multiple times, see if consistency improves

---

## Token Efficiency

**When tokens matter (context limits, cost):**

- Cut unnecessary examples (2-5 is usually enough)
- Shorten context to essentials
- Use role-play instead of detailed background
- Trim verbose instructions
- Remove pleasantries ("Thank you", "Please")

**When tokens don't matter (one-off tasks):**

- Add 2-5 examples for clarity
- Provide full context
- Be conversational
- Include "thinking" steps

---

## Testing Checklist

- [ ] Does output match expected format?
- [ ] Is tone correct?
- [ ] Length in expected range?
- [ ] No hallucinations or made-up facts?
- [ ] Works on multiple similar inputs?
- [ ] Fails gracefully on edge cases?
- [ ] Instructions are followed completely?
- [ ] No unnecessary verbosity?

---

## Common Patterns That Work

**"Think step-by-step"** - Improves reasoning
```
Let's solve this step-by-step:
1. [identify the problem]
2. [gather relevant info]
3. [consider options]
4. [choose best approach]
```

**"Show your work"** - Gets transparency
```
Before giving your final answer, show:
- Your reasoning
- What assumptions you're making
- Your confidence level (0-100%)
```

**Few-shot + constraints** - Best results
```
[2-5 examples]
[explicit format requirement]
[specific constraints]
[actual task]
```

**Role + constraints** - Focused expertise
```
You are a [specific role] who [key behavior].
Your constraint: [what you won't do]
Task: [what to do]
```

---

## Advanced: Metaprompting

Sometimes, ask the model to write prompts for you.

```
I need a prompt that [task]. 

Create a prompt that:
- Uses role-play to improve quality
- Includes 3 examples
- Specifies output format
- Lists constraints

Goal: [what the resulting prompt should achieve]

Write the prompt.
```

Then use the generated prompt for your actual task.

---

## Red Flags

- ⚠️ Prompt longer than the task — trim it
- ⚠️ Contradictory instructions — resolve conflicts
- ⚠️ No format spec — model will guess
- ⚠️ No examples + complex task — add 2-5 examples
- ⚠️ Relying on implicit context — make it explicit
- ⚠️ Asking for things the model can't do — adjust expectations

---

## Reference: Prompt Structure Skeleton

```
[ROLE/IDENTITY]
You are [role] who [core behavior].

[CONTEXT]
Background: [relevant information]

[TASK]
Specific instruction: [verb + object]

[FORMAT]
Output format: [JSON / markdown / bullets / etc]

[CONSTRAINTS]
- Length: [limit]
- Tone: [how to sound]
- Audience: [who is this for]
- Avoid: [what not to do]

[EXAMPLES] (if task is complex)
Input: [sample input]
Output: [sample output]

[FINAL INSTRUCTION]
[actual task]
```
