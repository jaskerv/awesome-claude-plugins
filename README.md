# awesome-claude-plugins

A curated collection of Claude Code plugins by [@jaskerv](https://github.com/jaskerv) — language servers, workflow tools, and developer experience improvements for [Claude Code](https://claude.ai/code).

## Plugins

| Plugin | Description | Category |
|--------|-------------|----------|
| [vtsls-lsp](./plugins/vtsls-lsp/) | TypeScript/JavaScript language server powered by VS Code's TypeScript engine | LSP |

## Installation

Add this marketplace to your Claude Code `~/.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "jaskerv-plugins": {
      "source": {
        "source": "github",
        "repo": "jaskerv/awesome-claude-plugins"
      }
    }
  }
}
```

Then install any plugin via CLI:

```bash
claude plugins install vtsls-lsp@jaskerv-plugins
```

Or enable via settings:

```json
{
  "enabledPlugins": {
    "vtsls-lsp@jaskerv-plugins": true
  }
}
```

## Plugins in Detail

### vtsls-lsp

TypeScript and JavaScript language intelligence for Claude Code, powered by [VTSLS](https://github.com/yioneko/vtsls) — the same TypeScript engine that powers VS Code.

Gives Claude Code's built-in `LSP` tool access to go-to-definition, find references, hover types, document symbols, workspace symbol search, go-to-implementation, and call hierarchy — for `.ts`, `.tsx`, `.js`, `.jsx`, and ESM/CJS variants.

**Why VTSLS over `typescript-language-server`?** VTSLS uses VS Code's TypeScript extension under the hood. It handles complex projects — monorepos, path aliases, project references — more reliably than the alternative.

[Full installation instructions →](./plugins/vtsls-lsp/README.md)

## Contributing

Plugin ideas and PRs welcome. See the [plugin structure](./plugins/) for how to add a new one.

## License

[MIT](./LICENSE)
