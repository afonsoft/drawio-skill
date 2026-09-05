# Integração Composio MCP
Conecta agentes de IA a mais de 1000 aplicativos externos via Composio com autenticação CLI-first e fallback MCP multiplataforma.

## 🎯 Objetivo
Permitir que agentes usem o servidor MCP hospedado do Composio (`https://connect.composio.dev/mcp`) para chamar aplicativos externos (Gmail, GitHub, Slack, Notion, Linear, Jira, etc.) sem que cada app precise de seu próprio servidor MCP. Resolve o limite de autenticação `ak_*` (chave de projeto, CLI) vs `ck_*` (chave de consumidor, MCP) que causa falhas silenciosas.

## 🛠️ Como Funciona
A skill oferece dois caminhos:
1. **CLI-first (preferencial)**: Usa a CLI `composio` com chave de projeto `ak_*` para `composio search`, `composio execute`, `composio link`, `composio proxy`.
2. **Fallback MCP**: Configura o endpoint Connect MCP hospedado com header `x-consumer-api-key: ck_*`. Trata formatos específicos por plataforma (`serverUrl` vs `url`, `mcp` vs `mcpServers`, `environment` vs `env`) em 8 plataformas de agente.

## 🚀 Uso
Use esta skill quando `devin mcp list` mostrar composio falhando ao listar tools, ao configurar Composio MCP em qualquer plataforma, ou quando comandos da CLI `composio` falharem com erros de autenticação.

## 🔗 Correlação
- **Building MCP Servers**: Se você precisa de um servidor MCP customizado em vez do hospedado pelo Composio, use `building-mcp-servers`.
- **NotebookLM MCP**: A outra skill de integração MCP neste catálogo, com o mesmo padrão de script de setup multiplataforma.
