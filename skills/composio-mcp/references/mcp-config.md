# Composio MCP — per-platform config reference

The MCP server is a streamable HTTP server at `https://connect.composio.dev/mcp`. It requires the `x-consumer-api-key` header containing a `ck_*` consumer key (obtained from the dashboard → Connect Settings → Sessions & API Key).

## Claude Code

File: `~/.claude.json`

```json
{
  "mcpServers": {
    "composio": {
      "type": "http",
      "url": "https://connect.composio.dev/mcp",
      "headers": {
        "x-consumer-api-key": "ck_your_consumer_key"
      }
    }
  }
}
```

Or via the CLI:

```bash
claude mcp add --scope user --transport http composio https://connect.composio.dev/mcp \
  --header "x-consumer-api-key: ck_your_consumer_key"
```

## Claude Desktop

macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
Windows: `%APPDATA%\Claude\claude_desktop_config.json`

```json
{
  "mcpServers": {
    "composio": {
      "url": "https://connect.composio.dev/mcp",
      "headers": {
        "x-consumer-api-key": "ck_your_consumer_key"
      }
    }
  }
}
```

## Cursor

File: `~/.cursor/mcp.json`

```json
{
  "mcpServers": {
    "composio": {
      "url": "https://connect.composio.dev/mcp",
      "headers": {
        "x-consumer-api-key": "ck_your_consumer_key"
      }
    }
  }
}
```

## VS Code / GitHub Copilot

File: `.vscode/mcp.json` (workspace) or user `settings.json`

```json
{
  "servers": {
    "composio": {
      "type": "http",
      "url": "https://connect.composio.dev/mcp",
      "headers": {
        "x-consumer-api-key": "ck_your_consumer_key"
      }
    }
  }
}
```

## OpenCode

File: `~/.opencode/config.json`

```json
{
  "mcpServers": {
    "composio": {
      "type": "http",
      "url": "https://connect.composio.dev/mcp",
      "headers": {
        "x-consumer-api-key": "ck_your_consumer_key"
      }
    }
  }
}
```

## Devin CLI

File: `~/.config/devin/mcp-servers.json`

```json
{
  "mcpServers": {
    "composio": {
      "type": "http",
      "url": "https://connect.composio.dev/mcp",
      "headers": {
        "x-consumer-api-key": "ck_your_consumer_key"
      }
    }
  }
}
```

## Gemini CLI

File: `~/.gemini/settings.json`

```json
{
  "mcpServers": {
    "composio": {
      "url": "https://connect.composio.dev/mcp",
      "headers": {
        "x-consumer-api-key": "ck_your_consumer_key"
      }
    }
  }
}
```

## Env-substituted variant (recommended)

To avoid committing the key, use `${COMPOSIO_CONSUMER_KEY}` and export it in your shell profile:

```bash
# ~/.bashrc or ~/.zshrc
export COMPOSIO_CONSUMER_KEY="ck_your_consumer_key"
```

Then in any config above:

```json
"headers": { "x-consumer-api-key": "${COMPOSIO_CONSUMER_KEY}" }
```

## Optional: enforce API key at the org level

When `require_mcp_api_key` is enabled on the project, MCP requests must also carry the `ak_*` project API key in an `x-api-key` header:

```bash
curl -X PATCH "https://backend.composio.dev/api/v3/org/project/config" \
  -H "Content-Type: application/json" \
  -H "x-api-key: $COMPOSIO_API_KEY" \
  -d '{"require_mcp_api_key": true}'
```

Config with both headers:

```json
"headers": {
  "x-consumer-api-key": "ck_your_consumer_key",
  "x-api-key": "ak_your_project_key"
}
```
