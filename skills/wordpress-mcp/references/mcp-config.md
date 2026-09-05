# WordPress MCP — per-platform config reference

Two MCP servers can be configured. Each has its own endpoint and auth.

| Server | Endpoint path | Auth header |
|--------|---------------|-------------|
| `wordpress-mcp` (mcp-adapter) | `/wp-json/mcp/mcp-adapter-default-server` | `Authorization: Basic <base64(user:app_password)>` |
| `wordpress-ai-engine` (AI Engine) | `/wp-json/mcp/v1/http` | `Authorization: Bearer <token>` |

Replace `https://yourdomain.com` with your actual WordPress URL.

## Platform config matrix

| Platform | Config file | Root key | URL field | Auth field | Transport field |
|----------|-------------|----------|-----------|------------|-----------------|
| Claude Code | `~/.claude.json` | `mcpServers` | `url` | `headers` | `type: "http"` |
| Devin CLI | `~/.config/devin/mcp_config.json` | `mcpServers` | `url` | `headers` | — (HTTP auto) |
| OpenCode | `~/.config/opencode/opencode.json` | `mcp` | `url` | `headers` | `type: "remote"` |
| Gemini CLI | `~/.gemini/settings.json` | `mcpServers` | **`httpUrl`** | `headers` | — |
| AGY | `~/.gemini/antigravity-cli/settings.json` | `mcpServers` | **`httpUrl`** | `headers` | — |
| Codex | `~/.codex/config.toml` | `[mcp_servers.<name>]` | `url` | sub-table `headers` | — |
| OpenClaw | `~/.openclaw/openclaw.json` | `mcp.servers` | `url` | `--header` flag | `transport: "streamable-http"` |

> **Critical gotchas:**
> - **Gemini CLI** and **AGY** use `httpUrl` (not `url`) for HTTP servers. Using `url` causes the server to be silently ignored.
> - **OpenCode** uses `mcp` (not `mcpServers`) as the root key.
> - **Codex** stores headers in a TOML sub-table `[mcp_servers.<name>.headers]`, not inline.
> - **OpenClaw** is managed via `openclaw mcp add` CLI, not JSON patching.

---

## Claude Code

File: `~/.claude.json`

```json
{
  "mcpServers": {
    "wordpress-mcp": {
      "type": "http",
      "url": "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server",
      "headers": {
        "Authorization": "Basic <base64>"
      }
    },
    "wordpress-ai-engine": {
      "type": "http",
      "url": "https://yourdomain.com/wp-json/mcp/v1/http",
      "headers": {
        "Authorization": "Bearer <token>"
      }
    }
  }
}
```

---

## Devin CLI

File: `~/.config/devin/mcp_config.json`

```json
{
  "mcpServers": {
    "wordpress-mcp": {
      "url": "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server",
      "headers": {
        "Authorization": "Basic <base64>"
      }
    },
    "wordpress-ai-engine": {
      "url": "https://yourdomain.com/wp-json/mcp/v1/http",
      "headers": {
        "Authorization": "Bearer <token>"
      }
    }
  }
}
```

Or via CLI:

```bash
devin mcp add -s user wordpress-mcp "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server" \
  --header "Authorization: Basic <base64>"

devin mcp add -s user wordpress-ai-engine "https://yourdomain.com/wp-json/mcp/v1/http" \
  --header "Authorization: Bearer <token>"
```

---

## OpenCode

File: `~/.config/opencode/opencode.json`

```json
{
  "mcp": {
    "wordpress-mcp": {
      "type": "remote",
      "url": "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server",
      "headers": {
        "Authorization": "Basic <base64>"
      },
      "enabled": true
    },
    "wordpress-ai-engine": {
      "type": "remote",
      "url": "https://yourdomain.com/wp-json/mcp/v1/http",
      "headers": {
        "Authorization": "Bearer <token>"
      },
      "enabled": true
    }
  }
}
```

Or via CLI:

```bash
opencode mcp add wordpress-mcp \
  --url "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server" \
  --header "Authorization=Basic <base64>"

opencode mcp add wordpress-ai-engine \
  --url "https://yourdomain.com/wp-json/mcp/v1/http" \
  --header "Authorization=Bearer <token>"
```

---

## Gemini CLI

File: `~/.gemini/settings.json`

```json
{
  "mcpServers": {
    "wordpress-mcp": {
      "httpUrl": "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server",
      "headers": {
        "Authorization": "Basic <base64>"
      }
    },
    "wordpress-ai-engine": {
      "httpUrl": "https://yourdomain.com/wp-json/mcp/v1/http",
      "headers": {
        "Authorization": "Bearer <token>"
      }
    }
  }
}
```

> **Gotcha:** Gemini uses `httpUrl`, NOT `url`. Using `url` will silently fail.

---

## AGY (Antigravity CLI)

File: `~/.gemini/antigravity-cli/settings.json`

```json
{
  "mcpServers": {
    "wordpress-mcp": {
      "httpUrl": "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server",
      "headers": {
        "Authorization": "Basic <base64>"
      }
    },
    "wordpress-ai-engine": {
      "httpUrl": "https://yourdomain.com/wp-json/mcp/v1/http",
      "headers": {
        "Authorization": "Bearer <token>"
      }
    }
  }
}
```

> **Gotcha:** Same as Gemini — use `httpUrl`, not `url`.

---

## Codex

File: `~/.codex/config.toml`

```toml
[mcp_servers.wordpress-mcp]
url = "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server"

[mcp_servers.wordpress-mcp.headers]
Authorization = "Basic <base64>"

[mcp_servers.wordpress-ai-engine]
url = "https://yourdomain.com/wp-json/mcp/v1/http"

[mcp_servers.wordpress-ai-engine.headers]
Authorization = "Bearer <token>"
```

Or via CLI (then add headers manually):

```bash
codex mcp add wordpress-mcp --url "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server"
codex mcp add wordpress-ai-engine --url "https://yourdomain.com/wp-json/mcp/v1/http"
# Then edit ~/.codex/config.toml to add [mcp_servers.<name>.headers] sub-tables
```

> **Gotcha:** Codex does not support `--header` on the CLI. Headers must be added as a TOML sub-table.

---

## OpenClaw

Managed via CLI (not JSON patching):

```bash
openclaw mcp add wordpress-mcp \
  --url "https://yourdomain.com/wp-json/mcp/mcp-adapter-default-server" \
  --header "Authorization=Basic <base64>" \
  --transport streamable-http \
  --no-probe

openclaw mcp add wordpress-ai-engine \
  --url "https://yourdomain.com/wp-json/mcp/v1/http" \
  --header "Authorization=Bearer <token>" \
  --transport streamable-http \
  --no-probe
```

Config is saved to `~/.openclaw/openclaw.json`.

---

## Generating the Basic Auth value

```bash
echo -n "admin:xxxx xxxx xxxx xxxx xxxx xxxx" | base64
# Output: YWRtaW46eHh4eCB4eHh4IHh4eHggeHh4eCB4eHh4IHh4eHg=
```

Use this as the `Authorization: Basic <value>` header.
