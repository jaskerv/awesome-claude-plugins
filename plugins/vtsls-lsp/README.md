# vtsls-lsp

TypeScript and JavaScript language server for Claude Code, powered by [VTSLS](https://github.com/yioneko/vtsls) — VS Code's TypeScript engine as a standalone LSP server.

Provides Claude Code's built-in `LSP` tool with:
- Go-to-definition
- Find references
- Hover / type info
- Document symbols
- Workspace symbol search
- Go-to-implementation
- Call hierarchy (incoming/outgoing)

## Supported Extensions

`.ts` `.tsx` `.js` `.jsx` `.mts` `.cts` `.mjs` `.cjs`

## Prerequisites

Install VTSLS globally:

```bash
npm install -g @vtsls/language-server
```

Verify it's on your PATH:

```bash
vtsls --version
```

## Installation

```bash
claude plugins marketplace add jaskerv/awesome-claude-plugins
claude plugins install vtsls-lsp@jaskerv-plugins
```

If you have the official `typescript-lsp` plugin enabled, disable it — having two servers registered for the same file extensions causes undefined behaviour:

```bash
claude plugins disable typescript-lsp@claude-plugins-official
```

## Verification

Open a TypeScript file and ask Claude to use the LSP tool:

> "Use the LSP hover operation on line 5, character 10 of src/index.ts"

You should receive type information from VTSLS.
