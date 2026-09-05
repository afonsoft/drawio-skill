# NotebookLM — authentication deep dive

NotebookLM (Gemini Notebook) has **no official API**. Authentication is done by extracting **Google browser cookies** from a logged-in session and caching them. The CLI/MCP refreshes CSRF tokens and session IDs automatically from those cookies.

## Where tokens are stored

```
~/.notebooklm-mcp-cli/profiles/<profile>/auth.json
```

Default profile: `default`. Each profile is an isolated Google account.

## Cookie file format (manual mode)

The file should contain the raw cookie string from Chrome DevTools:

```
SID=abc123...; HSID=xyz789...; SSID=...; APISID=...; SAPISID=...; __Secure-1PSID=...; __Secure-3PSID=...; ...
```

Rules:
- Lines starting with `#` are treated as comments and ignored.
- The file can contain the cookie string on one or multiple lines.
- A template `cookies.txt` is included in the upstream repository.

## How to extract cookies manually

1. Open Chrome and go to **https://notebooklm.google.com**
2. Make sure you are logged in to your Google account.
3. Press **F12** (or **Cmd+Option+I** on Mac) to open DevTools.
4. Click the **Network** tab.
5. In the filter box, type: `batchexecute`
6. Click on any notebook to trigger a request.
7. Click on a `batchexecute` request in the list.
8. In the right panel, scroll to **Request Headers**.
9. Find the line starting with `cookie:`.
10. Right-click the cookie **value** and select **Copy value**.
11. Paste into a text file and save as `cookies.txt`.

Then on the server:

```bash
nlm login --manual --file cookies.txt
# or interactive:
nlm login --manual
```

## OpenClaw CDP provider

When an OpenClaw-managed browser is already running and exposing a Chrome DevTools Protocol endpoint, `nlm` can read cookies from it without launching a second browser:

```bash
nlm login --provider openclaw --cdp-url http://127.0.0.1:18800
```

- Uses `suppress_origin=True` for websocket CDP commands to support managed endpoints that reject the default Origin header.
- The browser must already be logged in to Google / NotebookLM.
- Increase the DevTools timeout if the endpoint is slow:

```bash
nlm login --provider openclaw --cdp-url http://127.0.0.1:18800 --devtools-timeout 15
```

## Auto mode (desktop with browser)

```bash
nlm login              # launches a dedicated browser profile, you log in, cookies extracted
```

Supported browsers (auto-detected, in order): Chrome, Arc, Brave, Edge, Chromium, Firefox, Vivaldi, Opera.

Prefer a specific browser:

```bash
nlm config set auth.browser chromium
```

How it works:
1. The first available supported browser is detected (or your preferred browser if configured).
2. A dedicated browser profile is created for authentication.
3. The browser launches with the appropriate automation backend (CDP for Chromium-family; direct cookie DB read for Firefox).
4. You log in to NotebookLM via the browser.
5. Cookies are extracted and cached; CSRF/session fields are refreshed automatically when needed.
6. The browser is closed automatically.

## Multi-profile auth

```bash
nlm login --profile work
nlm login --profile personal
nlm login switch work
nlm login profile list
nlm login profile delete personal
nlm login profile rename personal pro
```

The MCP server always uses the **active default profile**. Switching the default profile instantaneously switches the MCP server's Google account:

```bash
nlm config set auth.default_profile work
```

## Auth lifecycle

| Component | Duration | Refresh |
|-----------|----------|---------|
| Cookies | ~2-4 weeks | Auto-refresh via headless browser (if profile saved) |
| CSRF token | minutes | Auto-refreshed on every request failure |
| Session ID | session | Embedded in cookies |

## Understanding `auth_status`

`nlm login --check` reports one of:

| Status | Meaning |
|--------|---------|
| `ok` | Cookies valid, last check succeeded |
| `stale` | Cookies present but not verified recently — re-run `nlm login` to confirm |
| `unverified` | Cookies present but never checked — run `nlm login --check` |
| `failed` | Cookies invalid or expired — re-login |

## Copying auth.json to a headless server

If you authenticated on a desktop and want the same session on a server:

```bash
# On the desktop:
scp ~/.notebooklm-mcp-cli/profiles/default/auth.json \
    user@server:~/.notebooklm-mcp-cli/profiles/default/auth.json

# On the server:
nlm login --check    # confirm the copied cookies still work
```

## Troubleshooting auth

### `ClientAuthenticationError` / `network_error`

Cookies are present but the session is dead or the network is blocked. Re-extract cookies:

```bash
nlm login --manual --file cookies.txt   # manual
nlm login                               # auto (desktop)
nlm login --provider openclaw --cdp-url http://127.0.0.1:18800  # CDP
```

### Cookie replay vs browser-bound auth

Some Google endpoints require a browser-bound session (not just cookie replay). Diagnose with:

```bash
nlm doctor auth-replay
```

If cookie replay fails, you need auto mode with a real browser (or OpenClaw CDP).

### Browser not found (headless)

```bash
nlm doctor
# Browser: not found
# → A supported browser is required for authentication
# Headless auth: not available (no saved profile)
```

Fix: use manual file mode or OpenClaw CDP. See the headless flow diagram in `SKILL.md`.
