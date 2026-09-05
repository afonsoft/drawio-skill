# Integração NotebookLM MCP
Integração do Google NotebookLM (Gemini Notebook) via CLI `nlm` e servidor `notebooklm-mcp`, com autenticação baseada em cookies para servidores headless.

## 🎯 Objetivo
Permitir que agentes usem o Google NotebookLM sem uma API pública oficial. Fornece três caminhos de autenticação para servidores headless (OpenClaw CDP, arquivo manual de cookies, auto desktop + cópia) e configuração MCP multiplataforma em 8 plataformas de agente.

## 🛠️ Como Funciona
A skill oferece:
1. **Auth**: Autenticação baseada em cookies via OpenClaw CDP (preferencial, porta 18800), arquivo manual `cookies.txt`, ou auto desktop + cópia de `auth.json`.
2. **Servidor MCP**: `notebooklm-mcp` (stdio) ou `nlm mcp start` (wrapper). Configurado por plataforma com o formato correto (`mcp` vs `mcpServers`, `command` array vs `command`+`args`, etc.).
3. **CLI**: CLI `nlm` para gerenciamento de notebooks, fontes e diagnósticos (`nlm doctor`, `nlm login --check`).

## 🚀 Uso
Use esta skill quando `nlm login --check` falhar com `ClientAuthenticationError`, ao configurar NotebookLM MCP em qualquer plataforma, ou ao autenticar em um servidor headless sem navegador.

## 🔗 Correlação
- **Composio MCP**: A outra skill de integração MCP neste catálogo, com o mesmo padrão de script de setup multiplataforma.
- **OpenClaw**: O provedor de autenticação preferencial para NotebookLM headless via CDP na porta 18800.
