# awesome-claude-plugins

A curated collection of Claude Code plugins by [@jaskerv](https://github.com/jaskerv) — language servers, workflow tools, and developer experience improvements for [Claude Code](https://claude.ai/code).

## Plugins

| Plugin | Description | Category |
|--------|-------------|----------|
| [vtsls-lsp](./plugins/vtsls-lsp/) | TypeScript/JavaScript language server powered by VS Code's TypeScript engine | LSP |
| [secret-scan-hook](./plugins/secret-scan-hook/) | Runs gitleaks after every file edit — detects leaked secrets and alerts Claude before they reach git | Hook |
| [oxlint-hook](./plugins/oxlint-hook/) | Runs oxlint after every file edit — auto-fixes violations and reports remaining issues to Claude | Hook |

## Installation

```bash
claude plugins marketplace add jaskerv/awesome-claude-plugins
claude plugins install <plugin-name>@jaskerv-plugins
```

## Plugins in Detail

### vtsls-lsp

TypeScript and JavaScript language intelligence for Claude Code, powered by [VTSLS](https://github.com/yioneko/vtsls) — the same TypeScript engine that powers VS Code.

Gives Claude Code's built-in `LSP` tool access to go-to-definition, find references, hover types, document symbols, workspace symbol search, go-to-implementation, and call hierarchy — for `.ts`, `.tsx`, `.js`, `.jsx`, and ESM/CJS variants.

**Why VTSLS over `typescript-language-server`?** VTSLS uses VS Code's TypeScript extension under the hood. It handles complex projects — monorepos, path aliases, project references — more reliably than the alternative.

[Full installation instructions →](./plugins/vtsls-lsp/README.md)

### oxlint-hook

Auto-lints JS/TS files as Claude edits them. After each write, it runs `oxlint --fix` to clean up fixable violations in place, then reports anything left to Claude as a system message so Claude can address it in the next turn.

Works with your project's existing `.oxlintrc.json` — no extra config needed in the plugin. Prefers the local `node_modules/.bin/oxlint` binary so it always uses the version your project specifies.

[Full installation instructions →](./plugins/oxlint-hook/README.md)

### secret-scan-hook

Protects against leaked secrets in two layers. The async per-file scan warns Claude immediately after each write so secrets get caught early. The blocking commit gate intercepts `git commit` commands and hard-blocks any commit where staged files contain secrets — using [gitleaks](https://github.com/gitleaks/gitleaks) with 140+ detectors covering AWS, GitHub, Stripe, GCP, and more.

Respects `.gitleaks.toml` at the project root for custom rules and allowlists.

[Full installation instructions →](./plugins/secret-scan-hook/README.md)

## Contributing

Plugin ideas and PRs welcome. See the [plugin structure](./plugins/) for how to add a new one.

## License

[MIT](./LICENSE)
