# oxlint-hook

Runs [oxlint](https://oxc.rs/docs/guide/usage/linter) after every file edit in Claude Code.

After each `Write` or `Edit` on a JS/TS file:
1. Runs `oxlint --fix` to auto-fix violations in place
2. Runs `oxlint` again to check what's left
3. Reports remaining violations to Claude as a system message so it can fix them

## Supported extensions

`.js` `.jsx` `.ts` `.tsx` `.mjs` `.cjs`

## Prerequisites

oxlint must be available — either as a project devDependency or globally:

```bash
# Local (preferred — respects your project version)
npm install --save-dev oxlint

# Global
npm install -g oxlint
```

`jq` must also be installed (`brew install jq` on macOS).

## Config

oxlint auto-discovers `.oxlintrc.json` by walking up from the edited file. No extra config needed in the plugin.

## Installation

```bash
claude plugins marketplace add jaskerv/awesome-claude-plugins
claude plugins install oxlint-hook@jaskerv-plugins
```

## Verification

Open a JS/TS file and ask Claude to make a change. If there are lint violations, you'll see a system message like:

```
oxlint found issues in Button.tsx:
  × no-unused-vars: 'foo' is defined but never used at 12:7
```
