# Configurando a Skill e o Servidor MCP do draw.io

Este guia explica como integrar a skill `drawio-architecture` ao seu
agente/IDE registrando o servidor MCP oficial do draw.io (`npx @drawio/mcp`).

## Pré-requisitos

- **Node.js** (qualquer LTS recente) — o servidor MCP roda via `npx`.
- (Opcional, para o caminho de export local) o app **draw.io desktop** + CLI.
- Um agente/IDE com suporte a MCP da lista abaixo.

## Opção 1 — Setup automatizado (recomendado)

```bash
# Veja quais targets esta máquina provavelmente usa
python3 scripts/setup_drawio_mcp.py --detect

# Escreve a config para um target específico
python3 scripts/setup_drawio_mcp.py --target claude-code
python3 scripts/setup_drawio_mcp.py --target opencode --dry-run   # só pré-visualiza
python3 scripts/setup_drawio_mcp.py --target devin --force        # sobrescreve existente
python3 scripts/setup_drawio_mcp.py --target vscode --global      # global do usuário
```

Valores suportados de `--target`: `claude-desktop`, `claude-code`, `vscode`,
`cursor`, `opencode`, `windsurf`, `devin`, `devin-cli`, `agy`,
`antigravity`, `gemini`, `raw`.

O helper mescla uma entrada `drawio` no arquivo de config correto e na chave
JSON correta (`mcpServers` para a maioria, `servers` para VS Code). Devin/AGY
também expõem MCP pela UI — use o mesmo comando stdio lá se o arquivo não for
reconhecido.

## Opção 2 — Config manual

Adicione este bloco à config MCP do seu cliente (caminhos exatos em
`references/mcp-config.md` e na tabela de plataformas do README):

```json
{
  "mcpServers": {
    "drawio": {
      "command": "npx",
      "args": ["-y", "@drawio/mcp"]
    }
  }
}
```

VS Code/Copilot usa `"servers"` em vez de `"mcpServers"`.

### draw.io self-hosted

Aponte o servidor para sua própria instância:

```json
{
  "mcpServers": {
    "drawio": {
      "command": "npx",
      "args": ["-y", "@drawio/mcp"],
      "env": { "DRAWIO_BASE_URL": "https://drawio.example.com/" }
    }
  }
}
```

## Verificar

1. Reinicie o cliente / recarregue a config.
2. Pergunte: *"Use o MCP do draw.io para fazer um fluxograma simples de A → B → C."*
3. O agente deve retornar uma URL `app.diagrams.net/#create=…` ou abrir o
   editor. Se ele instead escrever um arquivo `.drawio` manualmente, adicione
   uma instrução de sistema: *"Always use the draw.io MCP tools to create
   diagrams."*

## Fallback CLI local (sem MCP / entregáveis em imagem)

Registrar o MCP não é obrigatório se você quiser só exportar arquivo + imagem.
Resolva o binário draw.io (`drawio` no Homebrew/Linux; `draw.io` em builds
antigos; caminho completo no macOS `.app`/Windows `.exe`) e exporte:

```bash
drawio -x -f png --width 2000 -o diagram.png input.drawio      # preview (SEM -e)
drawio -x -f png -e -s 2 -o diagram.drawio.png input.drawio    # final (COM -e)
python3 scripts/validate_drawio.py diagram.drawio.png --repair-iend
```

Linux headless: prefixe com `xvfb-run -a` e adicione `--disable-gpu`
(`--no-sandbox` no final quando rodar como root). Detalhes em
`references/mcp-config.md`.

## Fallback via browser (sem CLI nenhum)

```bash
python3 scripts/setup_drawio_mcp.py --viewer-url input.drawio        # somente leitura
python3 scripts/setup_drawio_mcp.py --viewer-url input.drawio --edit # editável
```

O XML do diagrama é comprimido (deflate) + base64 no fragmento `#` da URL, então
nada é enviado a um servidor.
