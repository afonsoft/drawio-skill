# Draw.io Architecture Diagrams + MCP Integration (pt-BR)

Um Agent Skill completo que une a **criação de diagramas de arquitetura** para
o draw.io/diagrams.net com a **integração de primeira classe ao servidor MCP
oficial do draw.io** (`npx @drawio/mcp`). Gere XML `.drawio` correto para
diagramas de arquitetura, rede, nuvem, fluxograma e ER — e abra-os diretamente
no editor do draw.io por meio das ferramentas MCP, ou exporte localmente via
CLI desktop.

## Por quê

- Uma única skill cobre **ambos** os caminhos: abrir diagramas via MCP (agentes
  de chat) *e* escrever/exportar arquivos `.drawio` (headless/CI).
- Inclui um **helper de setup** que detecta seu agente/IDE e escreve a
  configuração MCP correta (Claude, OpenCode, Devin CLI/Desktop, AGY/Antigravity,
  Gemini, VS Code, Cursor, Windsurf).
- Inclui um **validador** de bem-formação XML, lint estrutural e reparo do IEND
  em PNG `-e`.
- Construído a partir de fontes reais: as skills de authoring `Agents365-ai/drawio-skill`
  e `scarr05/claude-skills-pub`, mais a referência oficial `jgraph/drawio-mcp`.

## Início rápido

```bash
# 1. Configure o servidor MCP do draw.io para seu agente (auto-detecta)
python3 scripts/setup_drawio_mcp.py --detect
python3 scripts/setup_drawio_mcp.py --target claude-code        # ou: opencode, devin, agy, ...

# 2. Peça ao seu agente para desenhar, ex.:
#    "Use o MCP do draw.io para criar um diagrama de arquitetura de um app web de 3 camadas."
```

Em seguida, diga ao agente para sempre usar as ferramentas MCP:
*"Always use the draw.io MCP tools to create diagrams."* (use sempre as
ferramentas MCP do draw.io para criar diagramas).

## Plataformas suportadas (config MCP)

| Agente / IDE | Target | Arquivo de config |
|--------------|--------|-------------------|
| Claude Desktop | `claude-desktop` | `claude_desktop_config.json` |
| Claude Code | `claude-code` | `~/.claude/settings.json` |
| OpenCode | `opencode` | `~/.config/opencode/opencode.json` |
| Devin Desktop | `devin` | `~/.devin/mcp.json` (ou UI do Devin) |
| Devin CLI | `devin-cli` | `~/.config/devin/mcp.json` |
| AGY (Antigravity CLI) | `agy` | `~/.gemini/antigravity-cli/mcp.json` |
| Antigravity IDE / Gemini CLI | `antigravity` / `gemini` | `~/.gemini/settings.json` |
| VS Code / Copilot | `vscode` | `.vscode/mcp.json` (chave `servers`) |
| Cursor | `cursor` | `~/.cursor/mcp.json` |
| Windsurf | `windsurf` | `~/.codeium/windsurf/mcp.json` |

## O que há dentro

```
SKILL.md                       # a skill (gatilho, regras de authoring, uso do MCP)
references/
  mcp-config.md                # config MCP exata por plataforma + self-host + fallback CLI
  architecture-patterns.md     # XML pronto: layered / microservices / client-api-db / C4
  cloud-icons.md               # cheatsheet de ícones AWS / Azure / GCP
  style-guide.md               # paleta, tipografia, efeitos, legenda
scripts/
  setup_drawio_mcp.py          # detecta plataforma + escreve config MCP / gera viewer URL
  validate_drawio.py           # lint XML + score de legibilidade + reparo IEND de PNG
docs/
  configuration.pt-br.md       # como configurar a skill e o MCP
  usage.pt-br.md               # como usar a skill (fluxo de trabalho)
  tools.pt-br.md               # referência das ferramentas MCP
  examples.pt-br.md            # exemplos de uso ponta a ponta
```

## Referências

**Fontes externas analisadas**
- Docs do MCP do draw.io — https://www.drawio.com/docs/manual/generate/drawio-mcp-server/
- Repo do MCP do draw.io (4 modos + referência XML) — https://github.com/jgraph/drawio-mcp
- README do tool-server MCP (blocos de config) — https://github.com/jgraph/drawio-mcp/blob/main/mcp-tool-server/README.md
- Referência XML (fonte da verdade) — https://github.com/jgraph/drawio-mcp/blob/main/shared/xml-reference.md
- Referência de estilos — https://github.com/jgraph/drawio-mcp/blob/main/shared/style-reference.md
- Skill de authoring — https://github.com/Agents365-ai/drawio-skill
- Skill de authoring — https://github.com/scarr05/claude-skills-pub
- Artigo de fluxo de trabalho — https://dev.to/rushier/how-to-use-claude-ai-drawio-to-create-architecture-diagrams-for-projects-17i1

**Este repositório**
- `SKILL.md` — definição da skill
- `docs/configuration.pt-br.md`, `docs/usage.pt-br.md`, `docs/tools.pt-br.md`, `docs/examples.pt-br.md` — guias
- `references/*.md` — material de referência profunda
- `scripts/*.py` — helpers

## Licença

MIT — veja `LICENSE`.
