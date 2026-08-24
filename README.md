# Draw.io Architecture Diagrams + MCP Integration

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

## What's inside

```
SKILL.md                       # the skill (trigger, authoring rules, MCP usage)
references/
  mcp-config.md                # exact MCP config per platform + self-host + CLI fallback
  architecture-patterns.md     # worked XML: layered / microservices / client-api-db / C4
  cloud-icons.md               # AWS / Azure / GCP icon cheatsheet
  style-guide.md               # palette, typography, effects, legend
scripts/
  setup_drawio_mcp.py          # detect platform + write MCP config / generate viewer URL
  validate_drawio.py           # XML lint + readability score + PNG IEND repair
docs/
  configuration.md             # how to configure the skill & MCP
  usage.md                     # how to use the skill (workflow)
  tools.md                     # MCP tools reference
  examples.md                  # end-to-end usage examples
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
- `SKILL.md` — skill definition
- `docs/configuration.md`, `docs/usage.md`, `docs/tools.md`, `docs/examples.md` — guides
- `references/*.md` — deep reference material
- `scripts/*.py` — helpers

## License

MIT — see `LICENSE`.
