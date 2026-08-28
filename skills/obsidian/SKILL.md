---
name: obsidian
license: UNLICENSED
description: Use when working with Obsidian vaults — running the Obsidian CLI (read/create/search/manage notes, tasks, properties), building Bases (.base views/filters/formulas), writing Obsidian Flavored Markdown (wikilinks, embeds, callouts, properties), or developing/debugging plugins and themes. Do NOT use for generic Markdown editors or non-Obsidian note tools; this skill is Obsidian-specific.
metadata:
  version: "1.0.0"
  visibility: public
  author: afonsoft
  url: https://github.com/afonsoft/skills
---

# Obsidian

A single skill for everything Obsidian: the **CLI**, **Bases** (`.base` files), and **Obsidian Flavored Markdown**. Consolidates the former `obsidian-cli`, `obsidian-bases`, and `obsidian-markdown` skills.

> **Origin:** derived from `kepano/obsidian-skills` (MIT). Obsidian must be running for any CLI or MCP command to work.

## When to Use

- Interact with a vault from the command line (create/read/search notes, tasks, properties).
- Build or edit a **Base** (database-like view over notes) with filters and formulas.
- Author **Obsidian Flavored Markdown** (wikilinks, embeds, callouts, properties).
- Develop or debug an Obsidian **plugin or theme**.

## Three areas

### 1. CLI
Run `obsidian` against a running Obsidian instance — vault operations, plugin/theme dev, DOM/screenshot inspection.
See [`references/obsidian-cli.md`](references/obsidian-cli.md).

Quick start:
```bash
# enable: Settings → General → Command line interface → Register CLI
which obsidian && obsidian --version
obsidian create name="New Note" content="# Hello" silent
obsidian search query="search term" limit=10
```

### 2. Bases
`.base` files are valid YAML defining filters, formulas, and views (table/cards/list/map) over notes.
See [`references/obsidian-bases.md`](references/obsidian-bases.md) and the full function list in [`references/FUNCTIONS_REFERENCE.md`](references/FUNCTIONS_REFERENCE.md).

```yaml
filters:
  and:
    - file.hasTag("task")
    - 'file.ext == "md"'
formulas:
  days_until_due: 'if(due, (date(due) - today()).days, "")'
views:
  - type: table
    name: "Active Tasks"
    order: [file.name, status, formula.days_until_due]
```

### 3. Markdown (Obsidian Flavored)
Wikilinks `[[Note]]`, embeds `![[note.png|300]]`, callouts `> [!warning]`, properties/frontmatter, highlights `==text==`, Mermaid, math.
See [`references/obsidian-markdown.md`](references/obsidian-markdown.md), plus [`references/CALLOUTS.md`](references/CALLOUTS.md), [`references/EMBEDS.md`](references/EMBEDS.md), [`references/PROPERTIES.md`](references/PROPERTIES.md).

## Workflows

### Create an Obsidian note
1. Add frontmatter/properties at the top (see `references/PROPERTIES.md`).
2. Write content with standard Markdown + Obsidian syntax (wikilinks, embeds, callouts).
3. Verify it renders in reading view.

### Build a Base
1. Create a `.base` file with valid YAML.
2. Define `filters` (global/view) and optional `formulas`.
3. Add one or more `views` (`table`/`cards`/`list`/`map`).
4. Validate YAML (watch quoting rules); open in Obsidian to confirm rendering.

### Register CLI / develop a plugin
1. Settings → General → Command line interface → **Register CLI**; restart terminal.
2. After code changes: `obsidian plugin:reload id=my-plugin` → `obsidian dev:errors` → `obsidian dev:screenshot`.

## Common Mistakes

| Mistake | Symptom | Fix |
|---|---|---|
| Obsidian not running | CLI/MCP commands fail | Open the Obsidian app first |
| Unquoted special chars in `.base` | YAML error | Quote strings with `:`, `{`, `}`, `[`, `]`, `,`, `&`, `*`, `#`, `?`, `\|`, `-`, `<`, `>`, `=`, `!`, `%`, `@` |
| Double quotes inside double quotes (formula) | Parse error | Wrap formula in single quotes: `'if(done, "Yes", "No")'` |
| Duration without field access | `(now()-file.ctime).round(0)` errors | Access `.days` first: `(now()-file.ctime).days.round(0)` |
| Missing null checks in formulas | Crash on empty property | Guard with `if()`: `if(due, (date(due)-today()).days, "")` |
| Wikilink vs Markdown link | Broken external links | `[[Note]]` for vault notes; `[text](url)` for external only |

## References

- [`references/obsidian-cli.md`](references/obsidian-cli.md) — CLI install, syntax, commands, plugin dev.
- [`references/obsidian-bases.md`](references/obsidian-bases.md) — Bases schema, filters, formulas, views, examples.
- [`references/obsidian-markdown.md`](references/obsidian-markdown.md) — Obsidian Flavored Markdown syntax.
- [`references/FUNCTIONS_REFERENCE.md`](references/FUNCTIONS_REFERENCE.md) — Complete Bases function reference.
- [`references/CALLOUTS.md`](references/CALLOUTS.md) — All callout types.
- [`references/EMBEDS.md`](references/EMBEDS.md) — All embed types.
- [`references/PROPERTIES.md`](references/PROPERTIES.md) — All property types and tag rules.
