# Composio MCP Integration
Connects AI agents to 1000+ external apps via Composio with CLI-first auth and multi-platform MCP fallback.

## 🎯 Purpose
Enable agents to use Composio's hosted MCP server (`https://connect.composio.dev/mcp`) to call external apps (Gmail, GitHub, Slack, Notion, Linear, Jira, etc.) without each app needing its own MCP server. Resolves the `ak_*` (project key, CLI) vs `ck_*` (consumer key, MCP) auth boundary that causes silent failures.

## 🛠️ How it Works
The skill provides two paths:
1. **CLI-first (preferred)**: Uses the `composio` CLI with `ak_*` project key for `composio search`, `composio execute`, `composio link`, `composio proxy`.
2. **MCP fallback**: Configures the hosted Connect MCP endpoint with `x-consumer-api-key: ck_*` header. Handles platform-specific config formats (`serverUrl` vs `url`, `mcp` vs `mcpServers`, `environment` vs `env`) across 8 agent platforms.

## 🚀 Usage
Use this skill when `devin mcp list` shows composio failing to list tools, when configuring Composio MCP on any platform, or when `composio` CLI commands fail with auth errors.

## 🔗 Correlation
- **Building MCP Servers**: If you need a custom MCP server instead of Composio's hosted one, use `building-mcp-servers`.
- **NotebookLM MCP**: The other MCP integration skill in this catalog, with the same multi-platform setup script pattern.
