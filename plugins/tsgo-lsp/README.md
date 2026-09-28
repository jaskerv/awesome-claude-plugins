# tsgo-lsp

TypeScript and JavaScript language server for Claude Code, powered by [tsgo](https://github.com/microsoft/typescript-go) — TypeScript 7's native Go-based compiler and language server.

Provides Claude Code's built-in `LSP` tool with:
- Go-to-definition
- Find references
- Hover / type info
- Document symbols
- Workspace symbol search
- Go-to-implementation

## Supported Extensions

`.ts` `.tsx` `.js` `.jsx` `.mts` `.cts` `.mjs` `.cjs`

## Prerequisites

Install tsgo globally:

```bash
npm install -g @typescript/native-preview
```

Verify it's on your PATH:

```bash
tsgo --version
```

## Installation

```bash
claude plugins marketplace add jaskerv/awesome-claude-plugins
claude plugins install tsgo-lsp@jaskerv-plugins
```

If you have the official `typescript-lsp` plugin (or `vtsls-lsp`) enabled, disable it — having two servers registered for the same file extensions causes undefined behaviour:

```bash
claude plugins disable typescript-lsp@claude-plugins-official
```

## Verification

Open a TypeScript file and ask Claude to use the LSP tool:

> "Use the LSP hover operation on line 5, character 10 of src/index.ts"

You should receive type information from tsgo.

## Notes

tsgo is still under active development (TypeScript 7 native preview) — some LSP features available in mature servers like VTSLS may be missing or behave differently.
