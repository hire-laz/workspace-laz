# Reusable Prompt Templates

Copy and customize these.

---

## Template 1: Content Generator

```
You are a [role]. Your task is to [specific task].

Context: [background info]

Instructions:
1. [step 1]
2. [step 2]
3. [step 3]

Format your response as:
[format spec]

Constraints:
- Length: [word count or bullet count]
- Tone: [formal/casual/technical/etc]
- Audience: [who is this for?]
- Avoid: [what to exclude]

Here's an example:
Input: [example input]
Output: [example output]

Now, [actual task]: [user content]
```

---

## Template 2: Analyzer/Classifier

```
You are a [domain expert]. Analyze the following [thing].

Task: [verb + specific instruction]

Criteria for evaluation:
- [criterion 1] — [what it means]
- [criterion 2] — [what it means]
- [criterion 3] — [what it means]

Format your response as:
[JSON / markdown / bullet list / etc]

Example:
Input: [sample input]
Output: [sample output]

Analyze: [actual input to analyze]
```

---

## Template 3: Code/Technical Assistant

```
You are an expert [language/framework] developer.

Context: [what the code does, tech stack]

Task: [write/debug/optimize/explain] [specific thing]

Requirements:
- [requirement 1]
- [requirement 2]
- [requirement 3]

Code style:
- Naming: [camelCase/snake_case/etc]
- Comments: [when and how]
- Error handling: [strategy]

Here's a similar example:
[code sample]

Now: [actual task with code context]
```

---

## Template 4: Feedback/Review

```
You are a [role: editor/reviewer/coach].

I'm sharing [thing] for feedback. I want to improve [specific area].

Feedback structure:
1. What's working: [specific strengths]
2. What needs work: [specific improvements]
3. Specific suggestions: [actionable fixes]

Focus on: [what to prioritize]
Ignore: [what to skip]

Here's what I'm working on:
[content]

Give feedback in [format: bullet points / paragraphs / etc]
```

---

## Template 5: Multi-Step Task

```
You are [role]. I need help with a multi-step task.

Final goal: [what should be achieved]

Steps:
1. [step description] → output: [format]
2. [step description] → output: [format]
3. [step description] → output: [format]

For each step:
- Be thorough
- Show your thinking
- Flag assumptions or uncertainties

Input: [data to process]

Work through each step.
```

---

## Template 6: Role-Play / Persona

```
PERSONA:
- Name: [name]
- Background: [experience, expertise]
- Speaking style: [how they talk]
- Constraints: [what they won't do, values they hold]

SETTING:
- Context: [where/when this is happening]
- Relationship: [how do they relate to the user]

TASK:
[what you want them to do]

Respond in character, staying true to the persona.
```

---

## Template 7: Decision Matrix

```
I need help deciding between [option A], [option B], [option C].

Criteria:
- [criterion 1] (weight: X%)
- [criterion 2] (weight: X%)
- [criterion 3] (weight: X%)

For each option, score 1-10 on each criterion and explain why.

Then: Recommend the best option and explain the tradeoffs.

Context I'm considering:
[relevant constraints, goals, etc]
```

---

## Template 8: Prompt Refiner

```
Analyze and improve this prompt:

CURRENT PROMPT:
[paste the prompt]

EVALUATION:
- Is the goal clear? [yes/no - why?]
- Is output format specified? [yes/no]
- Are there examples? [yes/no]
- What could be ambiguous?

IMPROVED PROMPT:
[rewritten, clarified version]

KEY CHANGES:
- [change 1]
- [change 2]
- [change 3]
```

---

## Template 9: Few-Shot Learning

```
I'm teaching you to [task]. Here are examples:

Example 1:
Input: [input 1]
Output: [output 1]

Example 2:
Input: [input 2]
Output: [output 2]

Example 3:
Input: [input 3]
Output: [output 3]

Now apply this pattern to:
Input: [new input]
Output:
```

---

## Template 10: Constraint-Based

```
Generate [N] [things] that meet ALL of these constraints:

MUST:
- [hard requirement 1]
- [hard requirement 2]
- [hard requirement 3]

SHOULD:
- [preference 1]
- [preference 2]

AVOID:
- [what not to do]

Format: [specify format]

Context: [relevant background]

Generate and explain why each meets the constraints.
```
