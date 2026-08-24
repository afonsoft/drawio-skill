# Draw.io Architecture Diagrams + MCP Integration

[![skills.sh](https://skills.sh/b/afonsoft/drawio-skill)](https://skills.sh/afonsoft/drawio-skill)

A comprehensive Agent Skill that merges **architecture-diagram authoring** for
draw.io/diagrams.net with **first-class integration of the official draw.io MCP
server** (`npx @drawio/mcp`). Generate correct `.drawio` XML for architecture,
network, cloud, flowchart and ER diagrams — then open them directly in the
draw.io editor through MCP tools, or export locally via the desktop CLI.

## Why

- One skill covers **both** paths: open diagrams through MCP (chat agents) *and*
  write/export `.drawio` files (headless/CI).
- Ships a **setup helper** that detects your agent/IDE and writes the correct
  MCP config (Claude, OpenCode, Devin CLI/Desktop, AGY/Antigravity, Gemini, VS
  Code, Cursor, Windsurf).
- Includes a **validator** for XML well-formedness, structural lint, and PNG
  `-e` IEND repair.
- Built from real sources: the proven authoring skills `Agents365-ai/drawio-skill`
  and `scarr05/claude-skills-pub`, plus the vendor's own `jgraph/drawio-mcp`
  reference.

## Quick start

```bash
# 1. Configure the draw.io MCP server for your agent (auto-detect)
python3 scripts/setup_drawio_mcp.py --detect
python3 scripts/setup_drawio_mcp.py --target claude-code        # or: opencode, devin, agy, ...

# 2. Ask your agent to draw something, e.g.
#    "Use the draw.io MCP to make an architecture diagram of a 3-tier web app."
```

Then, in a prompt, tell the agent to always use the MCP tools:
*"Always use the draw.io MCP tools to create diagrams."*

## Supported platforms (MCP config)

| Agent / IDE | Target | Config file |
|-------------|--------|-------------|
| Claude Desktop | `claude-desktop` | `claude_desktop_config.json` |
| Claude Code | `claude-code` | `~/.claude/settings.json` |
| OpenCode | `opencode` | `~/.config/opencode/opencode.json` |
| Devin Desktop | `devin` | `~/.devin/mcp.json` (or Devin UI) |
| Devin CLI | `devin-cli` | `~/.config/devin/mcp.json` |
| AGY (Antigravity CLI) | `agy` | `~/.gemini/antigravity-cli/mcp.json` |
| Antigravity IDE / Gemini CLI | `antigravity` / `gemini` | `~/.gemini/settings.json` |
| VS Code / Copilot | `vscode` | `.vscode/mcp.json` (`servers` key) |
| Cursor | `cursor` | `~/.cursor/mcp.json` |
| Windsurf | `windsurf` | `~/.codeium/windsurf/mcp.json` |

## CLI installation commands (use your preferred marketplace)

### Install via skills.sh (recommended)

```bash
npx skills add afonsoft/drawio-skill
```

**What it does:**
- Auto-detects your agent/IDE
- Writes the correct MCP config (`drawio` entry)
- Adds the skill to your agent's skill list
- Displays a badge: `[![skills.sh](https://skills.sh/b/afonsoft/drawio-skill)](https://skills.sh/afonsoft/drawio-skill)`

**Platform detection:** Skills.sh reads your dev directories (`.claude/skills/`, `.opencode/skills/`, `.cursor/skills/`, etc.) and adds the skill to the first one it finds.

### Install via Agent Skills (agentskills.io)

Agent Skills is a curated marketplace with quality control.

```bash
npx agent-skills add afonsoft/drawio-skill
```

**What it does:**
- Downloads the `skills/drawio-architecture/` folder from this repo
- Writes `SKILL.md` + references/scripts/docs to `.agents/skills/drawio-architecture/`
- Compatible with Claude Code, Cursor, OpenCode, Windsurf, and other supported agents
- Includes detailed documentation + MCP configuration helpers

### Install via SkillsMP (community-driven)

SkillsMP is the largest open-source skills directory with 2,000,000+ skills, API, and MCP server.

**Two ways:**

**CLI install (requires skills CLI):**
```bash
npx skillsmp add afonsoft/drawio-skill
```

**Or via API (for non-CLI agents):**
```bash
curl "https://skillsmp.com/api/v1/skills/install?repo=afonsoft/drawio-skill" \
  -H "Content-Type: application/json" \
  | jq .
```

**What it does:**
- Fetches skill metadata from SkillsMP's GitHub aggregator
- Adds to your agent's local skill cache
- Provides discoverability through categories, search, and occupation filters
- You can also use the [SkillsMP MCP Server](https://skillsmp.com/mcp) to query the catalog

### Alternative: Direct GitHub URL (CLI or MCP server)

If you have a custom MCP server or CLI that accepts GitHub URLs:

```bash
# CLI versions:
npx @your-cli add https://github.com/afonsoft/drawio-skill

# Some agents accept raw GitHub URLs directly
# Example with Claude Code:
claude mcp add drawio-skill https://github.com/afonsoft/drawio-skill
```

### Verify installation

**skills.sh:**
```bash
npx skills list
display the installed skills
```

**Agent Skills:**
```bash
ls -la ~/.agents/skills/drawio-architecture/
# Should contain SKILL.md, scripts/, references/, docs/
```

**SkillsMP:**
```bash
curl "https://skillsmp.com/api/v1/skills/search?q=drawio-architecture&repo=afonsoft/drawio-skill"
```

### Common troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| Agent doesn't see skill | Wrong skill directory for agent | Use `skills.sh add` (detect) or check `.claude/skills/` / `.opencode/skills/` |
| MCP not working | Config file not reloaded | Restart the agent/IDE |
| Skill appears broken | Frontmatter invalid | Run `npx skills lint afonsoft/drawio-skill` |
| No badge in README | Badge not updated | Run `npx skills badge afonsoft/drawio-skill >> README.md` |

### Choose your platform

- **skills.sh** → Best for: Telemetry, leaderboards, auto-detection, quick install
- **Agent Skills** → Best for: Quality control, agent compatibility, structured docs
- **SkillsMP** → Best for: Discoverability, API access, community contributions
- **Direct GitHub** → Best for: Offline installs, custom CLIs

You can mix them—install via skills.sh for quick setup, then supplement with SkillsMP discovery.

## Supported platforms (MCP config)

| Agent / IDE | Target | Config file |
|-------------|--------|-------------|
| Claude Desktop | `claude-desktop` | `claude_desktop_config.json` |
| Claude Code | `claude-code` | `~/.claude/settings.json` |
| OpenCode | `opencode` | `~/.config/opencode/opencode.json` |
| Devin Desktop | `devin` | `~/.devin/mcp.json` (or Devin UI) |
| Devin CLI | `devin-cli` | `~/.config/devin/mcp.json` |
| AGY (Antigravity CLI) | `agy` | `~/.gemini/antigravity-cli/mcp.json` |
| Antigravity IDE / Gemini CLI | `antigravity` / `gemini` | `~/.gemini/settings.json` |
| VS Code / Copilot | `vscode` | `.vscode/mcp.json` (workspace) or `~/.config/Code/User/mcp.json` (global) |
| Cursor | `cursor` | `~/.cursor/mcp.json` |
| Windsurf | `windsurf` | `~/.codeium/windsurf/mcp.json` |

## What's inside

```
SKILL.md                       # the skill (trigger, authoring rules, MCP usage)
skills.sh.json                 # skills.sh page customization
skills/
  drawio-architecture/         # agentskills.io standard layout
    SKILL.md                   # skill definition (name: drawio-architecture)
    references/                # deep reference material
      mcp-config.md            # exact MCP config per platform + self-host + CLI fallback
      architecture-patterns.md # worked XML: layered / microservices / client-api-db / C4
      cloud-icons.md           # AWS / Azure / GCP icon cheatsheet
      style-guide.md           # palette, typography, effects, legend
    scripts/                   # helpers
      setup_drawio_mcp.py      # detect platform + write MCP config / generate viewer URL
      validate_drawio.py       # XML lint + readability score + PNG IEND repair
docs/                          # guides (EN + PT-BR)
  configuration.md             # how to configure the skill & MCP
  configuration.pt-br.md
  usage.md                     # how to use the skill (workflow)
  usage.pt-br.md
  tools.md                     # MCP tools reference
  tools.pt-br.md
  examples.md                  # end-to-end usage examples
  examples.pt-br.md
```

## References

**External sources analyzed**
- draw.io MCP docs — https://www.drawio.com/docs/manual/generate/drawio-mcp-server/
- draw.io MCP repo (4 integration modes + XML reference) — https://github.com/jgraph/drawio-mcp
- MCP tool-server README (config blocks) — https://github.com/jgraph/drawio-mcp/blob/main/mcp-tool-server/README.md
- XML reference (source of truth) — https://github.com/jgraph/drawio-mcp/blob/main/shared/xml-reference.md
- Style reference — https://github.com/jgraph/drawio-mcp/blob/main/shared/style-reference.md
- Authoring skill — https://github.com/Agents365-ai/drawio-skill
- Authoring skill — https://github.com/scarr05/claude-skills-pub
- Workflow article — https://dev.to/rushier/how-to-use-claude-ai-drawio-to-create-architecture-diagrams-for-projects-17i1

**This repository**
- `SKILL.md` — skill definition (root for skills.sh, `skills/drawio-architecture/SKILL.md` for agentskills.io)
- `skills.sh.json` — skills.sh page customization
- `skills/drawio-architecture/` — agentskills.io standard layout (SKILL.md, references/, scripts/)
- `docs/` — guides in English and Portuguese
- `references/` — deep reference material (in skill folder)
- `scripts/` — helpers (in skill folder)

## License

MIT — see `LICENSE`.
