# secret-scan-hook

Runs [gitleaks](https://github.com/gitleaks/gitleaks) in two layers to prevent secrets from reaching git.

**Layer 1 — per-file scan (async):** After each `Write` or `Edit`, scans the file and warns Claude via system message if a secret is detected. Non-blocking — Claude continues but sees the warning immediately.

**Layer 2 — commit gate (blocking):** Intercepts every `git commit` command. Scans the staging area with gitleaks and hard-blocks the commit if any secrets are found.

## What it detects

gitleaks ships with 140+ detectors:

- Cloud credentials (AWS, GCP, Azure)
- Version control tokens (GitHub, GitLab, Bitbucket)
- Payment keys (Stripe, PayPal, Square)
- Communication services (Twilio, SendGrid, Mailgun)
- Database URIs, private keys, JWTs, and more

## Prerequisites

```bash
brew install gitleaks
brew install jq
```

## Installation

```bash
claude plugins marketplace add jaskerv/awesome-claude-plugins
claude plugins install secret-scan-hook@jaskerv-plugins
```

## Config

gitleaks auto-discovers `.gitleaks.toml` at the project root. Use it to add custom rules or allowlist paths that produce false positives:

```toml
[allowlist]
paths = [
  "tests/fixtures/fake-keys.ts"
]
```

See the [gitleaks config docs](https://github.com/gitleaks/gitleaks#configuration) for the full schema.

## Verification

Write a fake secret to any file and ask Claude to save it. You should see a system message like:

```
secret-scan-hook: potential secret(s) detected in config.ts:
  github-pat at line 3: GitHub Personal Access Token

Remove or rotate the secret before committing.
```

Then ask Claude to commit. The commit will be blocked:

```
secret-scan-hook blocked commit: secret(s) detected in staged files:
config.ts line 3: github-pat — GitHub Personal Access Token

Remove or rotate the secret(s) and re-stage before committing.
```
