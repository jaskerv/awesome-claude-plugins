# awesome-claude-plugins

Public Claude Code plugin collection by jaskerv.

## Repo structure

```
.claude-plugin/marketplace.json   plugin registry (marketplace schema)
plugins/<name>/README.md          per-plugin docs
README.md                         collection landing page (SEO-focused)
```

## Adding a plugin

1. Add an entry to `.claude-plugin/marketplace.json` under `plugins[]`
2. Create `plugins/<name>/README.md` with install instructions and usage
3. Add a row to the table in `README.md`
4. Add a detail section to `README.md`

## Git

- Remote: `git@github-jaskerv:jaskerv/awesome-claude-plugins.git`
- Identity: `jaskerv / jono2496@gmail.com` (set locally, not global)
- Commit style: `type: description` — no scope, no ticket
- No `Co-Authored-By` trailers

## Marketplace

- Key: `jaskerv-plugins`
- Install: `claude plugins marketplace add jaskerv/awesome-claude-plugins`
- Plugin identifier format: `<plugin-name>@jaskerv-plugins`
