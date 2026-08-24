# Configuring the Skill & the draw.io MCP Server

This guide explains how to wire the `drawio-architecture` skill into your
agent/IDE by registering the official draw.io MCP server (`npx @drawio/mcp`).

## Prerequisites

- **Node.js** (any recent LTS) — the MCP server runs via `npx`.
- (Optional, for the local export path) the **draw.io desktop** app + CLI.
- An MCP-capable agent/IDE from the supported list below.

## Option 1 — Automated setup (recommended)

```bash
# See which targets this machine likely uses
python3 scripts/setup_drawio_mcp.py --detect

# Write the config for a specific target
python3 scripts/setup_drawio_mcp.py --target claude-code
python3 scripts/setup_drawio_mcp.py --target opencode --dry-run   # preview only
python3 scripts/setup_drawio_mcp.py --target devin --force        # overwrite existing
python3 scripts/setup_drawio_mcp.py --target vscode --global      # user-global, not workspace
```

Supported `--target` values: `claude-desktop`, `claude-code`, `vscode`,
`cursor`, `opencode`, `windsurf`, `devin`, `devin-cli`, `agy`,
`antigravity`, `gemini`, `raw`.

The helper merges a `drawio` entry into the right config file and the right JSON
key (`mcpServers` for most, `servers` for VS Code). Devin/AGY also expose MCP
through their UI — use the same stdio command there if a file isn't picked up.

## Option 2 — Manual config

Add this block to your client's MCP config (exact file paths in
`references/mcp-config.md` and the README platform table):

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

VS Code/Copilot uses `"servers"` instead of `"mcpServers"`.

### Self-hosted draw.io

Point the server at your own instance:

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

## Verify

1. Restart the client / re-read config.
2. Ask: *"Use the draw.io MCP to make a simple flowchart of A → B → C."*
3. The agent should return a `app.diagrams.net/#create=…` URL or open the
   editor. If it instead writes a `.drawio` file by hand, add a system
   instruction: *"Always use the draw.io MCP tools to create diagrams."*

## Local CLI fallback (no MCP / image deliverables)

Registering the MCP is not required if you only want file + image export.
Resolve the draw.io CLI binary (`drawio` on Homebrew/Linux; `draw.io` on older
builds; full path on macOS `.app`/Windows `.exe`) and export:

```bash
drawio -x -f png --width 2000 -o diagram.png input.drawio      # preview (NO -e)
drawio -x -f png -e -s 2 -o diagram.drawio.png input.drawio    # final (WITH -e)
python3 scripts/validate_drawio.py diagram.drawio.png --repair-iend
```

Linux headless: prefix with `xvfb-run -a` and add `--disable-gpu`
(`--no-sandbox` at the very end when running as root). Full details in
`references/mcp-config.md`.

## Browser fallback (no CLI at all)

```bash
python3 scripts/setup_drawio_mcp.py --viewer-url input.drawio        # read-only
python3 scripts/setup_drawio_mcp.py --viewer-url input.drawio --edit # editable
```

The diagram XML is deflate-compressed + base64 in the URL `#` fragment, so
nothing is uploaded to a server.
