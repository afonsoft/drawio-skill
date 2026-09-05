# NotebookLM MCP — per-platform config reference

The server binary is `notebooklm-mcp` (stdio by default). Recommended server name: `notebooklm-mcp` (or `gemini-notebook-mcp` to avoid clashing with legacy servers).

## Claude Code

File: `~/.claude.json`

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "type": "stdio",
      "command": "notebooklm-mcp"
    }
  }
}
```

Or via the CLI:

```bash
nlm setup add claude-code
# or
claude mcp add --scope user notebooklm-mcp notebooklm-mcp
```

## Claude Desktop

macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
Windows: `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "command": "notebooklm-mcp"
    }
  }
}
```

Or: `nlm setup add claude-desktop`

## Cursor

File: `~/.cursor/mcp.json`

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "command": "notebooklm-mcp"
    }
  }
}
```

Or: `nlm setup add cursor`

## VS Code / GitHub Copilot

File: `.vscode/mcp.json`

```json
{
  "servers": {
    "notebooklm-mcp": {
      "type": "stdio",
      "command": "notebooklm-mcp"
    }
  }
}
```

Or: `nlm setup add github-copilot`

## OpenCode

File: `~/.opencode/config.json`

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "type": "stdio",
      "command": "notebooklm-mcp"
    }
  }
}
```

## Devin CLI

File: `~/.config/devin/mcp-servers.json`

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "type": "stdio",
      "command": "nlm",
      "args": ["mcp", "start"]
    }
  }
}
```

> Note: the Devin CLI config uses `nlm mcp start` (the wrapper) rather than the bare `notebooklm-mcp` binary. Both work; `nlm mcp start` ensures the profile/auth layer is initialized.

## Gemini CLI

File: `~/.gemini/settings.json`

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "command": "notebooklm-mcp"
    }
  }
}
```

Or: `nlm setup add gemini`

## Windsurf

Or: `nlm setup add windsurf`

## HTTP / SSE transport (remote)

```bash
notebooklm-mcp --transport http --port 8000
notebooklm-mcp --transport sse  --port 8000
```

Config (HTTP):

```json
{
  "mcpServers": {
    "notebooklm-mcp": {
      "type": "http",
      "url": "http://your-server:8000/mcp"
    }
  }
}
```

> **Warning:** HTTP transport does not provide HTTPS, caller authentication, per-user NotebookLM accounts, or remote file transfer. Do not expose it publicly without a reverse proxy adding TLS + auth. See the upstream [Remote MCP Deployment guide](https://github.com/jacob-bd/notebooklm-mcp-cli/blob/main/docs/REMOTE_MCP.md).

## Env vars

| Variable | Default | Description |
|----------|---------|-------------|
| `NOTEBOOKLM_MCP_TRANSPORT` | stdio | Transport type (stdio/http/sse) |
| `NOTEBOOKLM_MCP_PORT` | 8000 | HTTP/SSE port |
| `NOTEBOOKLM_MCP_DEBUG` | false | Enable verbose logging |
| `NOTEBOOKLM_HL` | en | Interface language / locale (e.g. `pt-BR`, `es-419`) |
| `NOTEBOOKLM_QUERY_TIMEOUT` | — | Query timeout (seconds) |
| `NOTEBOOKLM_BASE_URL` | `https://notebooklm.google.com` | Override for Enterprise/Workspace |

## Removing the server

```bash
nlm setup remove claude-code
nlm setup remove claude-desktop
# etc.
```
