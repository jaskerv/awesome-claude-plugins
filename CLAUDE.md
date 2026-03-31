# awesome-claude-plugins

Public Claude Code plugin collection by jaskerv.

## Repo structure

```
.claude-plugin/marketplace.json          plugin registry (marketplace schema)
plugins/<name>/.claude-plugin/plugin.json  plugin manifest (name, version, description)
plugins/<name>/hooks/hooks.json          hook configuration (must wrap events under "hooks" key)
plugins/<name>/hooks/scripts/            hook shell scripts
plugins/<name>/README.md                 per-plugin docs
README.md                                collection landing page (SEO-focused)
```

## Adding a plugin

1. Add an entry to `.claude-plugin/marketplace.json` under `plugins[]`
2. Create `plugins/<name>/.claude-plugin/plugin.json` with name, version, description, author, category, license
3. Create `plugins/<name>/README.md` with install instructions and usage (use CLI commands, not settings.json)
4. Add a row to the table in `README.md`
5. Add a detail section to `README.md`

## Plugin types

**LSP plugins** — declare `lspServers` in the marketplace.json entry (see vtsls-lsp)

**Hook plugins** — create `hooks/hooks.json` (auto-discovered) with this structure:
```json
{
  "hooks": {
    "PostToolUse": [{ "matcher": "Write|Edit", "hooks": [{ "type": "command", "command": "bash $CLAUDE_PLUGIN_ROOT/hooks/scripts/foo.sh", "async": true }] }]
  }
}
```
Note: the top-level `hooks` wrapper key is required — events directly at root will fail to load.

## Versioning

Bump version in both `plugins/<name>/.claude-plugin/plugin.json` AND `.claude-plugin/marketplace.json` when releasing fixes. Claude Code caches by version — without a bump, users won't get the update.

## Git

- Remote: `git@github-jaskerv:jaskerv/awesome-claude-plugins.git`
- Identity: `jaskerv / jono2496@gmail.com` (set locally, not global)
- Commit style: `type: description` — no scope, no ticket
- No `Co-Authored-By` trailers

## Marketplace

- Key: `jaskerv-plugins`
- Install: `claude plugins marketplace add jaskerv/awesome-claude-plugins`
- Plugin identifier format: `<plugin-name>@jaskerv-plugins`
