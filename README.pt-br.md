# Draw.io Architecture Diagrams + MCP Integration (pt-BR)

[![skills.sh](https://skills.sh/b/afonsoft/drawio-skill)](https://skills.sh/afonsoft/drawio-skill)

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

## Instalação via CLI (use seu marketplace preferido)

### Instale via skills.sh (recomendado)

```bash
npx skills add afonsoft/drawio-skill
```

**O que faz:**
- Detecta automaticamente seu agente/IDE
- Escreve a config MCP correta (`drawio` entry)
- Adiciona a skill à lista de skills do seu agente
- Exibe um badge: `[![skills.sh](https://skills.sh/b/afonsoft/drawio-skill)](https://skills.sh/afonsoft/drawio-skill)`

**Detecção de plataforma:** O skills.sh lê seus diretórios dev (`.claude/skills/`, `.opencode/skills/`, `.cursor/skills/`, etc.) e adiciona a skill ao primeiro que encontrar.

### Instale via Agent Skills (agentskills.io)

Agent Skills é um marketplace curado com controle de qualidade.

```bash
npx agent-skills add afonsoft/drawio-skill
```

**O que faz:**
- Baixa a pasta `skills/drawio-architecture/` deste repo
- Escreve SKILL.md + references/scripts/docs para `.agents/skills/drawio-architecture/`
- Compatível com Claude Code, Cursor, OpenCode, Windsurf e outros agentes suportados
- Inclui documentação detalhada + helpers de configuração MCP

### Instale via SkillsMP (comunidade orientada)

SkillsMP é o maior marketplace de habilidades open-source com 2,000,000+ de habilidades, API e MCP server.

**Duas maneiras:**

**Install CLI (requer skills CLI):**
```bash
npx skillsmp add afonsoft/drawio-skill
```

**Ou via API (para agentes não-CLI):**
```bash
curl "https://skillsmp.com/api/v1/skills/install?repo=afonsoft/drawio-skill" \
  -H "Content-Type: application/json" \
  | jq .
```

**O que faz:**
- Busca metadados da habilidade do agregador GitHub do SkillsMP
- Adiciona à cache local da habilidade do seu agente
- Oferece descoberta através de categorias, busca e filtros de ocupação
- Você também pode usar o [SkillsMP MCP Server](https://skillsmp.com/mcp) para consultar o catálogo

### Alternativa: URL GitHub direta (CLI ou MCP server)

Se você tem um servidor MCP ou CLI customizado que aceita URLs GitHub:

```bash
# CLI versions:
npx @your-cli add https://github.com/afonsoft/drawio-skill

# Alguns agentes aceitam URLs GitHub diretamente
# Exemplo com Claude Code:
claude mcp add drawio-skill https://github.com/afonsoft/drawio-skill
```

### Verifique a instalação

**skills.sh:**
```bash
npx skills list
exibe as habilidades instaladas
```

**Agent Skills:**
```bash
ls -la ~/.agents/skills/drawio-architecture/
# Deve conter SKILL.md, scripts/, references/, docs/
```

**SkillsMP:**
```bash
curl "https://skillsmp.com/api/v1/skills/search?q=drawio-architecture&repo=afonsoft/drawio-skill"
```

### Solução de problemas comuns

| Sintoma | Causa | Solução |
|---------|-------|-----|
| Agente não vê habilidade | Diretório de habilidade errado para agente | Use `skills.sh add` (detectar) ou verifique `.claude/skills/` / `.opencode/skills/` |
| MCP não funcionando | Arquivo de config não recarregado | Reinicie o agente/IDE |
| Habilidade parece quebrada | Frontmatter inválido | Execute `npx skills lint afonsoft/drawio-skill` |
| Badge ausente no README | Badge não atualizado | Execute `npx skills badge afonsoft/drawio-skill >> README.md` |

### Escolha sua plataforma

- **skills.sh** → Melhor para: Telemetria, leaderboards, detecção automática, instalação rápida
- **Agent Skills** → Melhor para: Controle de qualidade, compatibilidade de agentes, documentação estruturada
- **SkillsMP** → Melhor para: Descoberta, acesso à API, contribuições da comunidade
- **GitHub direto** → Melhor para: Instalações offline, CLIs customizados

Você pode misturar — instale via skills.sh para configuração rápida, depois complemente com descoberta SkillsMP.

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
skills.sh.json                 # personalização da página skills.sh
skills/
  drawio-architecture/         # layout padrão agentskills.io
    SKILL.md                   # definição da skill (name: drawio-architecture)
    references/                # material de referência profunda
      mcp-config.md            # config MCP exata por plataforma + self-host + fallback CLI
      architecture-patterns.md # XML pronto: layered / microservices / client-api-db / C4
      cloud-icons.md           # cheatsheet de ícones AWS / Azure / GCP
      style-guide.md           # paleta, tipografia, efeitos, legenda
    scripts/                   # helpers
      setup_drawio_mcp.py      # detecta plataforma + escreve config MCP / gera viewer URL
      validate_drawio.py       # lint XML + score de legibilidade + reparo IEND de PNG
docs/                          # guias (EN + PT-BR)
  configuration.md             # como configurar a skill e o MCP
  configuration.pt-br.md
  usage.md                     # como usar a skill (fluxo de trabalho)
  usage.pt-br.md
  tools.md                     # referência das ferramentas MCP
  tools.pt-br.md
  examples.md                  # exemplos de uso ponta a ponta
  examples.pt-br.md
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
- `SKILL.md` — definição da skill (raiz para skills.sh, `skills/drawio-architecture/SKILL.md` para agentskills.io)
- `skills.sh.json` — personalização da página skills.sh
- `skills/drawio-architecture/` — layout padrão agentskills.io (SKILL.md, references/, scripts/)
- `docs/` — guias em inglês e português
- `references/` — material de referência profunda (na pasta da skill)
- `scripts/` — helpers (na pasta da skill)

## Licença

MIT — veja `LICENSE`.
