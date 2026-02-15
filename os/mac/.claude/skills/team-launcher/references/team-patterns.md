# Team Patterns Reference

## Pattern: Research / Audit

**When to suggest:** User wants to understand, evaluate, or audit something.

**Structure:**
- 2-4 agents, each investigating a different aspect
- Agents work independently, results synthesized by lead
- Model: sonnet (cost-effective for research)

**Example roles:**
- Structure/Architecture Auditor
- Security/Best Practices Reviewer
- Performance/Optimization Analyst
- Documentation/Readability Reviewer

**Example tasks for a "review my codebase" goal:**

| Agent | Role | Task |
|-------|------|------|
| auditor | Code Auditor | Audit code structure, identify anti-patterns, outdated dependencies, dead code |
| security | Security Reviewer | Check for security vulnerabilities, credential exposure, unsafe patterns |
| perf | Performance Analyst | Profile bottlenecks, identify N+1 queries, memory leaks, slow paths |

**Output format:** Each agent produces findings as a structured list. Lead synthesizes into a prioritized summary.

---

## Pattern: Debate / Perspectives

**When to suggest:** User wants to explore tradeoffs, make a design decision, or get opposing viewpoints.

**Structure:**
- 2-4 agents with deliberately opposing perspectives
- Each agent argues their position with evidence from the codebase
- Lead synthesizes a balanced recommendation

**Example roles (pairs):**
- Minimalist vs Power User
- Monolith vs Microservices
- Convention vs Configuration
- Speed vs Safety
- Build vs Buy

**Example tasks for "should I refactor to microservices?":**

| Agent | Role | Task |
|-------|------|------|
| advocate | Microservices Advocate | Argue for microservices: identify bounded contexts, scaling bottlenecks, deployment pain points |
| skeptic | Monolith Defender | Argue against: identify coupling risks, operational overhead, complexity costs |
| pragmatist | Pragmatic Reviewer | Evaluate both positions against actual codebase size, team size, traffic patterns |

**Output format:** Each agent presents their case. Lead presents a decision matrix with recommendation.

---

## Pattern: Implementation / Parallel Build

**When to suggest:** User wants to build or implement something with parallelizable work.

**Structure:**
- 2-5 agents, each working on a separate component
- Tasks have clear boundaries and minimal overlap
- May have dependency ordering (use blockedBy)
- Model: sonnet or opus depending on complexity

**Example roles:**
- Frontend Developer
- Backend/API Developer
- Test Writer
- DevOps/Infrastructure
- Documentation Writer

**Example tasks for "add user authentication":**

| Agent | Role | Task |
|-------|------|------|
| backend | Backend Dev | Implement auth API endpoints, JWT token handling, middleware |
| frontend | Frontend Dev | Build login/signup forms, token storage, route guards |
| tests | Test Writer | Write integration tests for auth flow, unit tests for token validation |

**Output format:** Each agent commits their work. Lead verifies integration and runs tests.

---

## Pattern: Explore & Plan

**When to suggest:** User has a vague goal and needs both research and a concrete plan.

**Structure:**
- Phase 1: 1-2 research agents explore the problem space
- Phase 2: 1 planning agent synthesizes findings into actionable plan
- Model: sonnet for research, sonnet or opus for planning

**Example tasks for "modernize my CI/CD pipeline":**

| Agent | Phase | Role | Task |
|-------|-------|------|------|
| researcher | 1 | Current State Analyst | Map existing CI/CD: tools, configs, pain points, build times |
| benchmarker | 1 | Industry Researcher | Research current best practices, compare tools (GitHub Actions vs GitLab CI, etc.) |
| planner | 2 | Migration Planner | Synthesize findings into phased migration plan with effort estimates |

---

## Model Selection Guide

| Model | Best for | Cost |
|-------|----------|------|
| haiku | Simple grep/read tasks, quick lookups | Lowest |
| sonnet | Research, analysis, code review, most tasks | Medium |
| opus | Complex implementation, architecture decisions, synthesis | Highest |

**Default recommendation:** sonnet for all agents unless the task clearly needs opus-level reasoning.

---

## Team Size Guide

| Goal complexity | Suggested agents | Notes |
|----------------|-----------------|-------|
| Simple review/audit | 2 | Two complementary perspectives |
| Standard project | 3-4 | Cover main concerns without overhead |
| Complex initiative | 4-5 | More perspectives, but coordinate carefully |
| Large implementation | 3-5 | Parallelize by component, not too many |

**Rule of thumb:** Fewer focused agents > many shallow agents. Each agent should have a meaningfully distinct role.
