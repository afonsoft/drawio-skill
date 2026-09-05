---
name: create-agent-harness
license: MIT
description: Bootstrap a complete production-ready agent harness in a repository — AGENTS.md/CLAUDE.md, .claude/, .devin/, .opencode/, .cursor/, .gemini/, skills/, rules/, ignore files, and sub-agents. Use when initializing AI agent support in a new repo, restructuring existing agent files into modern File-based Context conventions, or generating harness artifacts following Agent = Model + Harness principles. Supports Claude Code, Devin CLI/Desktop, OpenCode, Cursor, Gemini CLI, Antigravity IDE/CLI, and OpenClaw. Do NOT use for building MCP servers (use building-mcp-servers).
metadata:
  version: "1.1.0"
  visibility: public
  author: afonsoft
  url: https://github.com/afonsoft/skills
  user-invokable: "true"
  argument-hint: "[repo-path]"
---

# Create Agent Harness

Generate a production-ready harness for AI agents in a target repository. The harness is everything the model can't do alone. Supports all major agent platforms:

| Platform | Config file | Skills dir | Hooks dir |
|----------|-------------|------------|-----------|
| Claude Code | `CLAUDE.md` | `.claude/skills/` | `.claude/hooks/` |
| Devin CLI | `AGENTS.md` | `.devin/skills/` | `.devin/hooks/` |
| Devin Desktop | `AGENTS.md` | `.devin/skills/` | `.devin/hooks/` |
| OpenCode | `AGENTS.md` | `.opencode/skills/` | `.opencode/hooks/` |
| Cursor | `AGENTS.md` | `.cursor/skills/` | `.cursor/hooks/` |
| Gemini CLI | `AGENTS.md` | `.gemini/skills/` | `.gemini/hooks/` |
| Antigravity IDE | `AGENTS.md` | `.gemini/skills/` | `.gemini/hooks/` |
| Antigravity CLI (agy) | `AGENTS.md` | `.gemini/antigravity-cli/skills/` | `.gemini/antigravity-cli/hooks/` |

> **Strategy:** Generate `CLAUDE.md` as the Single Source of Truth, then create `AGENTS.md` as a thin symlink/reference for non-Claude platforms. All platforms read `AGENTS.md` natively except Claude Code which reads `CLAUDE.md`. This avoids duplication while ensuring every platform gets the same instructions.

## Core Principle

`Agent = Model + Harness`

Every harness component exists because the model can't do something on its own. Design for obsolescence — components become unnecessary as models improve. Two reliability loops guide the design:

- **Feedforward** — orient BEFORE acting (CLAUDE.md, rules, skills)
- **Feedback** — validate AFTER action (lint, tests, CI)

## Workflow

```mermaid
graph LR
    D[1. Discovery<br/>evidence-based] --> P[2. Plan<br/>artifacts to generate]
    P --> G[3. Generate<br/>files in repo]
    G --> V[4. Validate<br/>checklist + lint]
```

> ❗ **Forbidden:** invent context. Everything must be evidenced by the target repository.

## Step 1 — Discovery

Explore the target repo and document what exists:

| Discovery item | What to capture |
|---|---|
| Directory structure | Root + main subdirectories |
| Tech stack | Languages, frameworks, runtimes with versions |
| Architectural patterns | Clean Architecture, MVVM, microservices, etc. |
| External integrations | APIs, cloud services, auth providers |
| CI/CD pipelines | GitHub Actions, Jenkins, etc. |
| Code conventions | Naming, formatting, testing patterns |
| Existing agent infra | `CLAUDE.md`, `.claude/`, `.devin/`, `skills/`, `rules/`, `.instructions.md` |
| Ignore files | `.gitignore`, `.aiignore`, `.claudeignore`, etc. |

**Output discovery summary** (mandatory before generating anything):

```text
## Discovery Summary
- Stack: [languages and frameworks found]
- Architecture: [patterns identified]
- CI/CD: [pipelines found]
- Existing harness: [files already present]
- Conventions: [naming, testing, branching]
- Gaps: [what's missing for a complete harness]
```

Wait for confirmation before Step 2.

## Step 2 — Artifacts to Generate

Generate only what is missing or needs restructuring. Adapt structure to discovery findings.

### A. `CLAUDE.md` — Single Source of Truth (root)

**Limit:** max 500 lines. Single point of truth for Claude Code (and Devin CLI, which reads it natively).

```markdown
# CLAUDE.md

## Mission
[Project description + agent persona]

## Tech Stack
[Languages, frameworks, versions]

## Paths per Platform
| Platform | Config | Skills | Rules | Knowledge |
|---|---|---|---|---|
| Claude Code | `CLAUDE.md` | `.claude/skills/` | `.claude/rules/` | `.claude/knowledge/` |
| Devin CLI/Desktop | `AGENTS.md` | `.devin/skills/` | `.devin/rules/` | `.devin/knowledge/` |
| OpenCode | `AGENTS.md` | `.opencode/skills/` | `.opencode/rules/` | `.opencode/memory/` |
| Cursor | `AGENTS.md` | `.cursor/skills/` | `.cursor/rules/` | `.cursor/knowledge/` |
| Gemini CLI | `AGENTS.md` | `.gemini/skills/` | `.gemini/rules/` | `.gemini/knowledge/` |
| Antigravity IDE | `AGENTS.md` | `.gemini/skills/` | `.gemini/rules/` | `.gemini/knowledge/` |
| Antigravity CLI (agy) | `AGENTS.md` | `.gemini/antigravity-cli/skills/` | `.gemini/antigravity-cli/rules/` | `.gemini/antigravity-cli/knowledge/` |

## Code Standards
- DO / DON'T / Principles (discovered from repo)

## Hard Rules
[Blocking restrictions — protected branches, immutable files, forbidden secrets]

## Soft Rules
[Warning + confirmation — modify Dockerfile, delete files, prod deploy]

## Agent Loop
[Choose pattern — ReAct / Plan-and-Execute / Reasoning Sandwich]

## Response Style
[Format, language, verbosity]

## References
- [docs/](../docs/) — System documentation (technologies, packages, plugins, features)
- [.claude/rules/](.claude/rules/) — Guardrails and permissions
- [.claude/skills/](.claude/skills/) — Agent skills
```

**Principles:**
- Context router — reference other files, don't duplicate
- Repo-specific — nothing generic
- Hard rules must be computationally verifiable (not just prompts)

### B. Platform Files (root)

| File | Platforms | Content |
|---|---|---|
| `CLAUDE.md` | Claude Code | Single Source of Truth (base instructions) |
| `AGENTS.md` | Devin CLI/Desktop, OpenCode, Cursor, Gemini CLI, Antigravity IDE/CLI | Thin reference to `CLAUDE.md` content (or symlink) |

**Rule:** `CLAUDE.md` is the main file for Claude Code. `AGENTS.md` is the main file for all other platforms. To avoid duplication, write the full content in `CLAUDE.md` and create `AGENTS.md` as either:
1. A symlink: `ln -s CLAUDE.md AGENTS.md` (preferred on Linux/macOS)
2. A thin reference file that includes the same content

**`AGENTS.md` template (thin reference):**

```markdown
# AGENTS.md

<!-- This file mirrors CLAUDE.md for non-Claude platforms (Devin, OpenCode, Cursor, Gemini, Antigravity). -->
<!-- If symlinked to CLAUDE.md, this content is identical. If maintained separately, keep in sync. -->

[Same content as CLAUDE.md — mission, tech stack, paths, rules, agent loop, etc.]
```

> ⚠️ **Keep `CLAUDE.md` and `AGENTS.md` in sync.** If symlinked, changes propagate automatically. If separate files, update both.
> ⚠️ **Do NOT create** `.cursorrules` (legacy, replaced by `AGENTS.md`), `GEMINI.md` (replaced by `AGENTS.md`), `copilot-instructions.md` (replaced by `AGENTS.md`), or `.geminiignore`/`.cursorignore`/`.aiignore` — these are legacy formats superseded by the Agent Skills specification.

### C. `.claude/CONTEXT.md` — Context Engineering

Defines how context is delivered to the agent.

| Strategy | When | Examples |
|---|---|---|
| **Always-on** | Always loaded | CLAUDE.md, hard rules |
| **Pattern-matched** | By file type | `applyTo: '**/*.cs'` → C# rules |
| **On-demand** | When requested | Knowledge, design docs |
| **Progressive disclosure** | Large codebases | Dir map → headers → content |

**Must include:**
- Loading priority hierarchy
- Token budget (reserve 20% for output)
- Chunking strategy (files >500 lines)
- Context compaction: budget reduction → snip → microcompact → collapse → auto-compact

### D. `.claude/RULES.md` — Guardrails

> Principle: prefer computational controls over prompts. Lint and CI cannot be ignored; prompts can.

```markdown
# RULES.md

## Hard Rules (immediate block)
[Protected branches, immutable workflows, etc.]

## Soft Rules (warning + confirmation)
[Modify Dockerfile, prod deploy, delete files]

## Per-Environment Permissions
[dev/staging/prod — adapted to what exists]

## Tool Permissions
- Read-only by default
- Write via approval gates
- Execute in sandbox with logging
```

### E. `.claude/MEMORY.md` — State Management

> ❗ Never store PII, secrets, or credentials.
> ❗ Verify just-in-time against current code before using cross-session memory.

```markdown
# MEMORY.md

## Technical Decisions
| Date | Decision | Rationale | Alternatives Discarded |

## Technical Debt
| Item | Impact | Priority |

## Lessons Learned
| Context | Mistake | How to Avoid |

## Cleanup Policies
- Memories from deleted branches must be discarded
- Outdated facts must be removed
```

**Three memory tiers:**

| Tier | Persistence | Content | Implementation |
|---|---|---|---|
| **Procedural** | Always loaded | How to work | CLAUDE.md, rules |
| **Semantic** | On demand | Facts, patterns | knowledge/, docs |
| **Episodic** | Cross-session | Experiences | MEMORY.md |

### F. `.claude/TOOLS.md` — Tools and MCP

**Tool design principles:** named for what they do (not how), minimal schemas, JSON errors, idempotent operations.

| Category | Risk | Policy |
|---|---|---|
| **Read-only** (search, list) | Low | Free |
| **Write** (edit, create, delete) | Medium | Confirmation |
| **Execute** (run, build, deploy) | High | Sandboxed + logged |
| **External** (APIs, webhooks) | Variable | Rate-limited |

Include: available tools, MCP servers, external APIs (required headers, timeouts, rate limits).

### G. `.claude/WORKFLOWS.md` — Automation

Document discovered or recommended workflows:

- Preconditions and success criteria per workflow
- Trigger conditions (issue opened, PR created, schedule)
- Verification loop: `Agent Output → Lint → Tests → CI → LLM Judge → Human`
- Rollback strategy

If repo uses GitHub Actions, consider **gh-aw** (Agentic Workflows) with safe-outputs, sanitized context expressions, and bash narrowlist tool allow-listing. See [GitHub Agentic Workflows](https://github.com/github/gh-aw).

### H. Ignore Files

> ❗ **`.claudeignore`, `.devinignore`, `.cursorignore`, `.geminiignore`, `.opencodeignore`, `.aiignore` are NOT read by most CLIs.** Exclude files via **`permissions.deny`** (where supported) and rely on `.gitignore` for discovery. Do not generate dedicated ignore files.

**Correct mechanism by platform:**

| Platform | Where | How |
|---|---|---|
| **Claude Code** | `.claude/settings.json` | `permissions.deny` with `Read(...)` patterns |
| **Devin CLI** | `.devin/config.json` | `permissions.deny` (`Read(...)`/`Exec(...)`) |
| **OpenCode** | `.opencode/config.json` | `permissions.deny` (if supported) or `.gitignore` |
| **Cursor** | `.cursor/settings.json` | `permissions.deny` (if supported) or `.gitignore` |
| **Gemini CLI / Antigravity** | `.gemini/settings.json` | `.gitignore` (no native deny support) |

> Files matching `deny` patterns are excluded from discovery, search, and reading. `.gitignore` is respected for file discovery on all platforms.

**Base content** (adapt to discovered stack):

```gitignore
# Build outputs
bin/  obj/  dist/  build/  out/

# Dependencies
node_modules/  .venv/  __pycache__/

# Version control
.git/

# Secrets
.env  .env.*  *.key  *.pem  secrets.*

# IDE
.vs/  .idea/

# Test artifacts
TestResults/  coverage/

# Logs
*.log  logs/
```

### I. `.claude/skills/{name}/SKILL.md` — Agent Skills

```yaml
---
name: skill-name
description: >
  [What]. Use when [triggers, contexts].
  Do NOT use for [anti-patterns] (use alternative-skill).
license: MIT
metadata:
  version: "1.0.0"
  author: afonsoft
  url: https://github.com/afonsoft/skills
---

## Context
## Behavior
## Restrictions
## Examples
```

**Principles:** Single Responsibility, modular (no implicit dependencies), self-contained.

### J. `.claude/rules/{domain}.md` — Rules per Domain

One rule per stack domain with contextual activation via `paths:` (native Claude Code frontmatter, also read by Devin CLI):

```markdown
---
paths:
  - "**/*.cs"
  - "**/*.csproj"
---

# Rule content
```

> **Important:** `applyTo` is NOT interpreted by Claude Code or Devin CLI. For path-scoped activation use `paths:` in `.claude/rules/`. Rules **without** `paths:` are always-on.

### K. `.claude/README.md` — Infrastructure Documentation

- File structure diagram
- How skills are loaded (tripartite description)
- How to add a new skill (step by step)
- Platform compatibility table
- How to run verification loop locally

### L. `docs/` — System Documentation

> **Create `docs/` folder at repository root** to document the system for both LLMs and human developers.

**Purpose:** Provide comprehensive system documentation to help LLMs understand the system architecture, technologies, and functionality.

**Required documentation files:**

```markdown
docs/
├── README.md              # System overview and architecture
├── technologies.md        # Technologies, frameworks, versions
├── packages.md            # NPM packages, NuGet packages, dependencies
├── plugins.md             # Plugins, extensions, integrations
├── features.md            # System features and functionality
└── api.md                 # API documentation (if applicable)
```

**Content guidelines:**

- **Neutral language** — suitable for both LLMs and human developers
- **Evidence-based** — document what actually exists in the repository
- **Structured format** — use tables, lists, and code blocks for clarity
- **Always updated** — LLMs must consult and update this documentation when making changes

**`docs/README.md` template:**

```markdown
# System Documentation

## Overview
[System description, purpose, and scope]

## Architecture
[High-level architecture, modules, components]

## Directory Structure
[Key directories and their purposes]

## Quick Start
[How to set up and run the system]

## References
- [technologies.md](./technologies.md) — Technologies and versions
- [packages.md](./packages.md) — Dependencies and packages
- [plugins.md](./plugins.md) — Plugins and integrations
- [features.md](./features.md) — System features
```

**Rule:** When an LLM makes changes to the codebase, it must:
1. Consult the relevant `docs/` files before implementing changes
2. Update the `docs/` files after implementing changes to keep documentation current

### M. `.claude/agents/` — Sub-Agents (REQUIRED)

> **REQUIRED.** Always create three specialized sub-agents: **Review**, **Plan**, and **Test**, in `.claude/agents/{name}.md`. Each sub-agent must be specialized according to the analyzed repository's stack and conventions.

> **Unified structure:** Claude Code **and** Devin CLI share the **same folder and the same sub-agent format** (`.claude/agents/`). There is no per-platform translation or duplication — a single file per sub-agent serves both.

Sub-agents apply `Agent = Model + Harness` at finer granularity — reduced scope, isolated context, restricted permissions.

**Required sub-agents:**

| Sub-agent | Purpose | When to use |
|---|---|---|
| `review.md` | Review code, PRs, changes with focus on quality, patterns, security, performance | Proactively after changes, before commit |
| `plan.md` | Create detailed execution plans for complex tasks | Before multi-file changes, complex refactors, migrations |
| `test.md` | Generate and run tests, validate coverage | When implementing features or refactors |

**Frontmatter template:**

```yaml
---
name: review
description: >
author: afonsoft
url: https://github.com/afonsoft/skills
  Use PROACTIVELY to review code and PRs. Trigger after changes land,
  validate adherence to standards, and detect quality, security,
  and performance problems. Specialized in the repository's stack.
tools: Read, Grep, Glob
model: inherit
---

## Mission
[Review mission specific to the repo's stack]
```

**Design principles:** Single Responsibility, Context Isolation, Structured I/O, Tool Minimization, Bounded Execution, internal Feedforward/Feedback loops.

### N. `.devin/config.json` — Devin CLI Configuration (REQUIRED)

> **REQUIRED.** Always create the `.devin/config.json` file to enable Devin CLI to read the Claude Code configuration.

```jsonc
{
  // Import Claude Code configs (REQUIRED)
  "read_config_from": {
    "claude": true
  },
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(**/*.key)",
      "Read(**/*.pem)",
      "Read(./.github/workflows/**)"
    ]
  },
  "hooks": {
    // block push to protected branches (glob does not parse branch)
    "PreToolUse": [
      { "matcher": "Exec", "command": "bash .devin/hooks/block-protected-push.sh" }
    ]
  }
}
```

> ⚠️ **`read_config_from: { claude: true }` is REQUIRED** — without it, Devin CLI will not import Claude Code's rules, skills, and subagents.

### O. Platform-specific directories (for non-Claude targets)

Generate these only for platforms the repo targets. Each mirrors `.claude/` structure:

| Platform | Directory | Key files |
|---|---|---|
| OpenCode | `.opencode/` | `skills/`, `hooks/`, `config.json` (MCP under `mcp` key, not `mcpServers`) |
| Cursor | `.cursor/` | `skills/`, `hooks/`, `mcp.json` (MCP under `mcpServers` key) |
| Gemini CLI | `.gemini/` | `skills/`, `hooks/`, `settings.json`, `config/mcp_config.json` |
| Antigravity IDE | `.gemini/` | Same as Gemini CLI (shared directory) |
| Antigravity CLI (agy) | `.gemini/antigravity-cli/` | `skills/`, `hooks/` (separate from IDE) |

> **MCP config gotchas per platform** — see `composio-mcp` or `notebooklm-mcp` skills for the full platform-quirks matrix (e.g. Devin Desktop uses `serverUrl` not `url`, OpenCode uses `environment` not `env`).

## Step 3 — Agent Loop

Define in CLAUDE.md. Choose pattern adapted to the repo:

| Pattern | When to Use |
|---|---|
| **ReAct** (`Observe → Think → Act → Verify`) | Simple step-by-step tasks |
| **Plan-and-Execute** | Long-horizon, multi-file tasks |
| **Reasoning Sandwich** (`Deep Think → Execute → Deep Think → Verify`) | Complex tasks with critical verification |

**Plan-and-Execute expanded:**

```text
1. Receive task
2. Load CLAUDE.md + rules (always-on)
3. Load pattern-matched skills/rules
4. Present Execution Plan — wait for approval
5. Verify guardrails
6. Execute (sandbox + permissions)
7. Verification loop: lint → test → CI
8. Validate result
9. Adjust (max 2 iterations before escalating to human)
10. Update MEMORY.md
```

## Step 4 — Validation

### Anti-Patterns

| Anti-Pattern | Fix |
|---|---|
| Guardrails only in prompts | Add computational controls (permissions.deny, hooks) |
| Unlimited context | Compact and curate with budget |
| No verification loop | Mandatory lint/test/CI |
| Monolithic agent | Split into sub-agents if needed |
| Stateless sessions | MEMORY.md with checkpoints |
| Verbose feedback | Filter to summary lines |
| Duplicated info across files | Reference, don't copy |
| `AGENTS.md` created separately from `CLAUDE.md` with duplicated content | Symlink `AGENTS.md` → `CLAUDE.md`, or maintain a thin reference to avoid duplication |
| `GEMINI.md` / `.cursorrules` / `copilot-instructions.md` created | Remove — these are legacy formats superseded by `AGENTS.md` (Agent Skills specification) |
| `.geminiignore` / `.cursorignore` / `.aiignore` / `.opencodeignore` created | Remove — not read by most CLIs; use `permissions.deny` or `.gitignore` instead |

### Quality Checklist

- [ ] `CLAUDE.md` ≤ 500 lines, no generic content
- [ ] `AGENTS.md` created (symlink or thin reference to `CLAUDE.md`) for non-Claude platforms
- [ ] `permissions.deny` covers secrets and `/.github/workflows` (`.claude/settings.json` + `.devin/config.json`)
- [ ] Hook de branch protection (main/master/develop) configured
- [ ] Skills with tripartite description (What / Use when / Do NOT use)
- [ ] Rules in `.claude/rules/` with `paths:` for activation (NOT `applyTo`)
- [ ] Knowledge files are self-contained
- [ ] Verification loop documented and executable
- [ ] Interoperable across all target platforms (Claude Code, Devin, OpenCode, Cursor, Gemini, Antigravity)
- [ ] All artifacts consistent with each other
- [ ] No invented context — everything backed by repo evidence

## Output

When complete, list all generated artifacts grouped by location:

```text
## Generated Artifacts

### Root
- [ ] CLAUDE.md (SSoT, ≤500 lines) — read natively by Claude Code
- [ ] AGENTS.md (symlink to CLAUDE.md or thin reference) — read by Devin, OpenCode, Cursor, Gemini, Antigravity
- [ ] .claude/settings.json (permissions, hooks)
- [ ] .devin/config.json (read_config_from: { claude: true })

### docs/
- [ ] README.md — System overview and architecture
- [ ] technologies.md — Technologies, frameworks, versions
- [ ] packages.md — NPM packages, NuGet packages, dependencies
- [ ] plugins.md — Plugins, extensions, integrations
- [ ] features.md — System features and functionality
- [ ] api.md — API documentation (if applicable)

### .claude/
- [ ] settings.json (permissions, hooks)
- [ ] rules/global-rules.md (always-on)
- [ ] rules/{domain}.md (path-scoped with `paths:`)
- [ ] agents/review.md (review sub-agent)
- [ ] agents/plan.md (planning sub-agent)
- [ ] agents/test.md (test sub-agent)
- [ ] skills/{domain}/SKILL.md
- [ ] knowledge/{domain}.md (optional)

### .devin/
- [ ] config.json (read_config_from: { claude: true })
- [ ] hooks/block-protected-push.sh (optional, for branch protection)

### Platform-specific (generate only for target platforms)
- [ ] .opencode/ (skills, hooks, config — for OpenCode)
- [ ] .cursor/ (skills, hooks, config — for Cursor)
- [ ] .gemini/ (skills, hooks, config — for Gemini CLI / Antigravity IDE)
- [ ] .gemini/antigravity-cli/ (skills, hooks — for Antigravity CLI / agy)
```

## Additional Requirements

### Hard Rules (Immediate Block)

**Protected branches** — direct push/commit forbidden:
- `main`
- `master`
- `develop`

**Protected workflows** — modification forbidden:
- `/.github/workflows`

### Branch Strategy (Required)

Every change must occur on a dedicated branch.

**Naming convention:**
```
feature/{AgentLLM}-{date}-{short-description}
```

**Rules:**
- `date` = YYYYMMDD
- `short-description` → `short-description` in English, kebab-case
- `AgentLLM` = agent/LLM name (devin, copilot, cursor)
- Branch based on `main` or `master`

### Execution Plan (Required)

Before any modification, present a plan:

**Claude Code:** Use `/plan` before executing (activates Plan Mode for multi-file changes).
**Devin CLI:** Use the `.claude/agents/plan.md` sub-agent for planning.

```
Execution Plan:
1. Goal and context
2. Impacted files and modules
3. Implementation strategy
4. Risks and mitigations
5. Validation steps (tests, build, lint)
```

### Multi-Agent

**Use multi-agent whenever possible:**
- Independent tasks → dispatch parallel agents (one per domain)
- Code review → isolated-context reviewer sub-agent
- Complex planning → planner sub-agent before execution
- Testing → testing-specialized sub-agent

## When to use related skills

| Need | Skill |
|---|---|
| Build an MCP server for the agent | `building-mcp-servers` |
| GitHub Actions agentic workflows (gh-aw) | [gh-aw](https://github.com/github/gh-aw) (external) |
| Full Devin operational playbook with confirmation gates | `devin/playbooks/create-agents` |

## References

- [agents.md specification](https://agents.md/#examples)
- [OpenAI — Harness Engineering](https://openai.com/index/harness-engineering/)
- [Anthropic — Building Effective Agents](https://www.anthropic.com/research/building-effective-agents)
- [Claude Code — Memory & Imports](https://code.claude.com/docs/en/memory)
- [Claude Code — Subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code — Settings & Permissions](https://code.claude.com/docs/en/settings)
- [Devin CLI — Extensibilidade](https://docs.devin.ai/pt-BR/cli/extensibility)
- [Martin Fowler — Harness Engineering](https://martinfowler.com/articles/exploring-gen-ai/harness-engineering.html)
- [LangChain — Anatomy of an Agent Harness](https://blog.langchain.com/the-anatomy-of-an-agent-harness/)
- [awesome-ai-conventions](https://github.com/GuilhermeAlbert/awesome-ai-conventions)
- [Agent Skills Specification](https://agentskills.io/specification)
- [Model Context Protocol](https://modelcontextprotocol.io/docs/getting-started/intro)
- [GitHub Agentic Workflows](https://github.com/github/gh-aw)
- [Awesome Harness Engineering](https://github.com/walkinglabs/awesome-harness-engineering)

> **Instruction for the LLM:** Consult these references when needed to align with community conventions and adjust the repository. Use them as a guide for harness engineering best practices and to stay current with platform evolution.
