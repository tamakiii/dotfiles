---
name: team-launcher
description: Interactively design and launch Claude Code agent teams from a simple goal. Use when the user wants to create a team of agents, launch a swarm, coordinate multiple Claude sessions, or says things like "use teams to...", "launch agents for...", "I want a team to...", or "/team-launcher". Helps users avoid writing long team prompts by guiding them through team design with smart suggestions, then executing the team.
---

# Team Launcher

Design and launch Claude Code agent teams from a simple goal through interactive conversation.

## Workflow

### Phase 1: Gather the Goal

Ask the user what they want to accomplish. If they gave a goal already, acknowledge it and move to Phase 2.

Keep it simple: "What do you want the team to accomplish?"

### Phase 2: Design the Team

Based on the goal, suggest a team pattern and structure. Read `references/team-patterns.md` for pattern templates.

Use AskUserQuestion to present the design interactively:

1. **Suggest a pattern** — Pick the best-fit pattern (Research/Audit, Debate/Perspectives, Implementation, Explore & Plan) and explain why. Let the user override.

2. **Propose agent roles** — Suggest 2-4 agents with:
   - Name (short, lowercase, hyphenated)
   - Role title
   - One-line task description
   - Model (default: sonnet)

   Ask the user to confirm, modify, or add/remove agents.

3. **Clarify the deliverable** — Ask what output format they want:
   - Summary with recommendations (default for research/audit)
   - Decision matrix (default for debate)
   - Working code (default for implementation)
   - Actionable plan (default for explore & plan)

### Phase 3: Show the Plan

Present the final team design in a clear visual format:

```
Team: {team-name} ({N} agents, {model})
├── {agent-1-name}: {Role} — {task summary}
├── {agent-2-name}: {Role} — {task summary}
├── {agent-3-name}: {Role} — {task summary}
└── {agent-4-name}: {Role} — {task summary}
Deliverable: {output description}
```

Ask: "Launch this team?" with options to proceed, edit, or cancel.

### Phase 4: Execute

On confirmation, execute the team:

1. **TeamCreate** — Create the team with a descriptive name
2. **TaskCreate** — Create one task per agent with:
   - Clear, specific subject (imperative form)
   - Detailed description with context, scope, and expected output format
   - activeForm in present continuous
3. **Spawn agents** — Use the Task tool with `team_name` and `name` parameters:
   - Set `subagent_type` to `general-purpose` for implementation tasks
   - Set `subagent_type` to `Explore` for research-only tasks (no file edits needed)
   - Set `model` per the agreed plan
   - Write a thorough prompt for each agent including:
     - Their specific role and perspective
     - What to investigate/build
     - Expected output format
     - Any constraints or focus areas
4. **Assign tasks** — Use TaskUpdate to assign each task to its agent

### Guidelines

- **Default to sonnet** unless the user requests otherwise or the task clearly needs opus
- **Prefer 3-4 agents** for most tasks. Fewer focused agents beat many shallow ones
- **Give agents distinct, non-overlapping scopes** to avoid duplicate work
- **Include the deliverable format** in each agent's prompt so they know what to produce
- **For debate patterns**, explicitly tell each agent their perspective/stance to argue from
- **For implementation patterns**, define clear boundaries between agents' work areas
