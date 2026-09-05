# WordPress MCP — extended troubleshooting

## mcp-adapter (Path A)

### Endpoint returns 404

**Cause:** Plugin not active, or `vendor/` directory missing (composer dependencies not installed).

**Fix:**
```bash
wp plugin status mcp-adapter --path=$WP_PATH --allow-root
# If not active:
wp plugin activate mcp-adapter --path=$WP_PATH --allow-root

# If vendor/ is missing:
cd $WP_PATH/wp-content/plugins/mcp-adapter
composer install --no-dev --no-interaction --optimize-autoloader
wp rewrite flush --path=$WP_PATH --allow-root
```

### `composer install` fails with jetpack-autoloader error

**Cause:** Composer < 2.2. The `automattic/jetpack-autoloader` package requires `composer-plugin-api ^2.2`.

**Fix:**
```bash
composer --version  # check version
sudo composer self-update --2  # update to latest 2.x
composer install --no-dev --no-interaction --optimize-autoloader
```

### Endpoint returns 401 Unauthorized

**Cause:** Application Passwords are disabled on the WordPress install.

**Fix:** Create a mu-plugin to force-enable:
```bash
sudo tee $WP_PATH/wp-content/mu-plugins/enable-app-passwords.php > /dev/null <<'EOF'
<?php
add_filter('wp_is_application_passwords_available', '__return_true');
add_filter('wp_is_application_passwords_api_available', '__return_true');
EOF
```

### `tools/list` returns empty array

**Cause:** The `notifications/initialized` step was skipped, or the `Mcp-Session-Id` header is missing.

**Fix:** The mcp-adapter requires a proper MCP handshake:
1. Send `initialize` → capture `Mcp-Session-Id` from response headers
2. Send `notifications/initialized` with the session header (returns HTTP 202)
3. Send `tools/list` with the session header

```bash
# Correct flow:
SESSION=$(curl -s -i -X POST "$URL" -H "Authorization: Basic $AUTH" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{...}}' \
  | grep -i "mcp-session-id" | awk '{print $2}' | tr -d '\r\n')

curl -s -X POST "$URL" -H "Authorization: Basic $AUTH" \
  -H "Content-Type: application/json" -H "Mcp-Session-Id: $SESSION" \
  -d '{"jsonrpc":"2.0","method":"notifications/initialized"}' -o /dev/null

curl -s -X POST "$URL" -H "Authorization: Basic $AUTH" \
  -H "Content-Type: application/json" -H "Mcp-Session-Id: $SESSION" \
  -d '{"jsonrpc":"2.0","id":2,"method":"tools/list"}'
```

> MCP clients (Claude Code, Devin, etc.) handle this automatically. This is only an issue when testing with curl.

### Application Password creation fails

**Cause:** `wp_is_application_passwords_available()` returns false despite WP 5.6+.

**Fix:** Some hosts (and local environments) disable Application Passwords. Use the mu-plugin from A.2 to force-enable.

---

## AI Engine (Path B)

### Endpoint returns 404

**Cause:** `module_mcp` option is `false` (MCP module not enabled).

**Fix:**
```bash
wp eval '
$o = get_option("mwai_options");
$o["module_mcp"] = true;
update_option("mwai_options", $o);
' --path=$WP_PATH --allow-root
wp rewrite flush --path=$WP_PATH --allow-root
```

### Endpoint returns 401 Unauthorized

**Cause:** Wrong or missing Bearer Token.

**Fix:** Check the stored token and regenerate if needed:
```bash
wp eval 'echo get_option("mwai_options")["mcp_bearer_token"];' --path=$WP_PATH --allow-root
# If empty or wrong, regenerate:
TOKEN=$(openssl rand -hex 24)
wp eval '
$o = get_option("mwai_options");
$o["mcp_bearer_token"] = "'"$TOKEN"'";
update_option("mwai_options", $o);
' --path=$WP_PATH --allow-root
echo "New token: $TOKEN"
```

### `wp plugin install ai-engine` fails

**Cause:** Some hosts block outbound downloads from WordPress.org.

**Fix:** Download manually and copy:
```bash
cd /tmp
curl -L -o ai-engine.zip "https://downloads.wordpress.org/plugin/ai-engine.zip"
unzip -q ai-engine.zip
sudo cp -r ai-engine $WP_PATH/wp-content/plugins/
sudo chown -R www:www $WP_PATH/wp-content/plugins/ai-engine
wp plugin activate ai-engine --path=$WP_PATH --allow-root
```

### Tools missing (e.g., no WooCommerce tools)

**Cause:** Feature flags are off. Only WordPress core tools are enabled by default.

**Fix:** Enable the feature in `mwai_options`:
```bash
wp eval '
$o = get_option("mwai_options");
$o["mcp_feature_woocommerce"] = true;  // requires WooCommerce plugin
update_option("mwai_options", $o);
' --path=$WP_PATH --allow-root
```

Available features: `mcp_feature_plugins`, `mcp_feature_themes`, `mcp_feature_database`, `mcp_feature_polylang`, `mcp_feature_woocommerce`, `mcp_feature_seo_engine`, `mcp_feature_social_engine`, `mcp_feature_dynamic_rest`.

---

## MCP client config issues

### Server silently ignored (no tools, no error)

**Cause:** Wrong field name for the platform. See `references/platform-quirks.md`.

**Common mistakes:**
- Gemini CLI / AGY: used `url` instead of `httpUrl`
- OpenCode: used `mcpServers` instead of `mcp`
- Codex: headers not in TOML sub-table
- Claude Code: missing `type: "http"`

**Fix:** Use the automated setup script or consult `references/mcp-config.md` for the exact format per platform.

### Devin CLI: server only works in one project

**Cause:** Added without `-s user` (project-scoped instead of global).

**Fix:**
```bash
devin mcp remove wordpress-mcp
devin mcp add -s user wordpress-mcp "..." --header "..."
```

### OpenCode: `opencode mcp add` writes to wrong file

**Cause:** OpenCode may write to `~/.config/opencode/opencode.json` (not `config.json`).

**Fix:** Check both files:
```bash
cat ~/.config/opencode/opencode.json
cat ~/.config/opencode/config.json
```

The MCP config lives in `opencode.json`, while `config.json` holds other settings.

---

## aaPanel / BT-Panel specific

### WP-CLI uses wrong PHP version

aaPanel manages multiple PHP versions. WP-CLI may pick the wrong one.

**Fix:**
```bash
# Check which PHP WP-CLI uses
wp --info --path=$WP_PATH --allow-root | grep "PHP version"

# If wrong, set the path:
WP_PHP=/www/server/php/85/bin/php
$WP_PHP /usr/local/bin/wp plugin list --path=$WP_PATH --allow-root
```

### File permissions after plugin install

aaPanel uses `www:www` as the web user. Files copied as `root` or `ubuntu` won't be readable by PHP-FPM.

**Fix:**
```bash
sudo chown -R www:www $WP_PATH/wp-content/plugins/mcp-adapter
sudo chown -R www:www $WP_PATH/wp-content/plugins/ai-engine
sudo chown -R www:www $WP_PATH/wp-content/mu-plugins/
```

### PHP-FPM needs restart after mu-plugin changes

Sometimes PHP-FPM caches the plugin list. Restart it:
```bash
# aaPanel: via the panel UI, or:
sudo /etc/init.d/php-fpm-85 restart
# or
sudo systemctl restart php8.5-fpm
```
