# NotebookLM MCP Integration
Google NotebookLM (Gemini Notebook) integration via the `nlm` CLI and `notebooklm-mcp` server, with cookie-based auth for headless servers.

## 🎯 Purpose
Enable agents to use Google NotebookLM without an official public API. Provides three authentication paths for headless servers (OpenClaw CDP, manual cookie file, desktop auto + copy) and multi-platform MCP config across 8 agent platforms.

## 🛠️ How it Works
The skill provides:
1. **Auth**: Cookie-based authentication via OpenClaw CDP (preferred, port 18800), manual `cookies.txt` file, or desktop auto + `auth.json` copy.
2. **MCP server**: `notebooklm-mcp` (stdio) or `nlm mcp start` (wrapper). Configured per-platform with the correct format (`mcp` vs `mcpServers`, `command` array vs `command`+`args`, etc.).
3. **CLI**: `nlm` CLI for notebook management, source management, and diagnostics (`nlm doctor`, `nlm login --check`).

## 🚀 Usage
Use this skill when `nlm login --check` fails with `ClientAuthenticationError`, when configuring NotebookLM MCP on any platform, or when authenticating on a headless server without a browser.

## 🔗 Correlation
- **Composio MCP**: The other MCP integration skill in this catalog, with the same multi-platform setup script pattern.
- **OpenClaw**: The preferred auth provider for headless NotebookLM authentication via CDP on port 18800.
