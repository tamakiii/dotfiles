# Detailed Guide: Writing Claude Code Skills in Japanese

This reference contains the full research behind the recommendations in the main SKILL.md.

## Table of contents

1. [How Claude Code skills work under the hood](#how-claude-code-skills-work-under-the-hood)
2. [What makes skill instructions reliable](#what-makes-skill-instructions-reliable)
3. [Japanese prompts: performance and trade-offs](#japanese-prompts-performance-and-trade-offs)
4. [The hybrid approach in detail](#the-hybrid-approach-in-detail)
5. [Japanese community resources](#japanese-community-resources)

---

## How Claude Code skills work under the hood

Every SKILL.md file consists of two parts: a YAML frontmatter block (with `name` and `description` fields) and a markdown body containing the actual instructions. Claude Code loads skills through a three-level progressive system:

**Level 1 (Metadata)**: Name + description from all installed skills are injected into an `<available_skills>` XML block within the system prompt. This costs roughly 100 tokens per skill and happens on every session.

**Level 2 (Body)**: When a user request matches a skill's description, Claude reads the full SKILL.md body into context (recommended under 500 lines / ~5,000 words).

**Level 3 (Resources)**: Scripts and reference files are accessed only when needed — scripts are executed via bash, and only their output enters the context window.

### Frontmatter constraints

- `name`: lowercase letters, numbers, hyphens only (max 64 characters) — effectively requires English
- `description`: up to 1,024 characters in any language
- Optional fields: `disable-model-invocation`, `allowed-tools`, `context: fork`, `model`

### The description field is critical

Anthropic's skill-creator notes that Claude tends to "undertrigger" skills, and recommends making descriptions "a little bit pushy" — include specific trigger terms users would actually say, state what the skill does and when to use it, and err on the side of over-describing relevance.

For Japanese-language workflows: write descriptions in Japanese with the trigger phrases Japanese-speaking users would naturally use.

---

## What makes skill instructions reliable

### Core principle: conciseness is king

The context window is a shared resource. Only add information Claude doesn't already know. For each line, ask: "Would removing this cause Claude to make mistakes?" If not, cut it.

### Degrees of freedom

Match freedom to task sensitivity:

- **High freedom** (text instructions): context-dependent tasks like code review
- **Medium freedom** (pseudocode): tasks with a preferred pattern but acceptable variation
- **Low freedom** (deterministic scripts): fragile operations like database migrations

### Effective SKILL.md structure

- **Overview**: what problem the skill solves
- **Step-by-step instructions**: specific tool references and expected outputs
- **Output format**: what success looks like
- **Error handling**: explicit fallback actions
- **Examples**: concrete input→output pairs

### Proven patterns

- **Template pattern**: output templates with appropriate strictness
- **Feedback loop pattern**: run validator → fix errors → repeat
- **Checklist pattern**: track progress through complex multi-step workflows
- **Conditional workflow pattern**: guide through decision trees

### Common pitfalls

- Over-explaining (don't explain what PDFs are)
- Too many options (provide one default with an escape hatch)
- Deeply nested references (keep one level deep from SKILL.md)
- Time-sensitive phrasing (use "current method" / "legacy pattern" instead of dates)

### Instruction budget

Research from HumanLayer estimates Claude Code's system prompt already contains ~50 instructions, with frontier models reliably following 150–200 instructions total. The combined instruction budget across CLAUDE.md, skills, rules, and user messages is genuinely limited.

---

## Japanese prompts: performance and trade-offs

### Performance parity

Claude's latest benchmarks show Japanese at 96.9% of English performance — near parity. The gap is small enough that other factors (clarity, conciseness, domain precision) typically dominate.

### Politeness research

A peer-reviewed study from Waseda University and RIKEN (ANLP 2024) tested eight levels of Japanese politeness on LLM performance using the JMMLU benchmark:

- Rude prompts reliably degraded performance
- Excessively polite/deferential language didn't help either
- Mid-range politeness — です/ます form or plain declarative だ/である — produced the best results

For skill authoring: write in standard written Japanese (「以下の要件を満たすコードを作成してください。」) rather than casual speech or honorific-heavy keigo.

### Tokenization overhead

Analysis of 2+ million translated sentence pairs:

- Japanese averages **2.12× the token count** of equivalent English text
- Individual sentences range from fewer tokens than English to up to 8× more
- Directly impacts API costs and context window consumption
- 500-line English recommendation → ~300-line budget for Japanese content

### Native prompts for Japanese content

FacetScore research findings:

- For processing Japanese content (sentiment analysis, classification, summarization), native Japanese prompts significantly outperform English ones
- English prompts missed cultural nuances (e.g., 「まあまあでした」classified as neutral/positive instead of negative)
- Machine-translated prompts fell below 50% accuracy
- Human-written native-language prompts are essential whenever Japanese is used

---

## The hybrid approach in detail

### Why hybrid wins

Claude is fine-tuned to pay special attention to XML tags, and all official examples use English tag names (`<instructions>`, `<example>`, `<context>`). No evidence exists of anyone testing Japanese XML tags like `<指示>` systematically — English tags are the proven path.

Similarly, markdown headings in English align with the overwhelming majority of technical documentation in Claude's training data.

### Element-by-element language choice

| Element | Language | Rationale |
|---|---|---|
| `name` field | English (required) | Spec requires lowercase + hyphens |
| `description` field | Japanese | Matches Japanese user trigger phrases |
| XML tags | English | Training alignment, official examples |
| Markdown headings (`##`) | English | Token efficiency, pattern recognition |
| Body text / instructions | Japanese | Precision, domain fidelity |
| Variable names / placeholders | English | Code convention alignment |
| Code examples / commands | English | Universal programming convention |
| Domain-specific terms | Japanese | Preserves meaning (e.g., 自治体DX, 電子決裁) |

### Modular language separation

For teams unsure about language balance, separate files by language concern:

```
.claude/rules/
├── code-style.md         ← English (technical conventions)
├── testing.md            ← English (test patterns)
└── domain-context.md     ← Japanese (domain knowledge)
```

---

## Japanese community resources

### Zenn.dev

15+ substantial articles on skill authoring, including:
- Full Japanese adaptation of Anthropic's 32-page skills guide
- Tutorials on auto-generating skills from session logs
- Guides for packaging skills as distributable plugins

### GitHub repositories

- `Masa1984a/claude-skills-demo`: Four fully Japanese skills (Excel-to-JSON conversion, member lookup, etc.) with Japanese comments in accompanying scripts
- GitHub Gist by sifue: Standardized Japanese AGENTS.md/CLAUDE.md template specifying 「基本的な受け答えは、全て日本語で行うこと」while keeping variable and function names in English

### Qiita, note.com, DevelopersIO

Additional depth on Japanese skill authoring patterns and community-validated approaches.

### Key community insight

The `description` field deserves special attention for Japanese triggering. Multiple articles emphasize that description quality "determines 90% of whether a skill gets invoked." Descriptions must include the actual phrases Japanese developers would use, not formal or overly technical language.
