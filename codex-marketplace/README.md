# codex-marketplace

Standalone Codex marketplace-style repository for local plugins.

## Layout

```text
codex-marketplace/
├── .agents/plugins/marketplace.json
└── plugins/github-workflow/
    ├── .codex-plugin/plugin.json
    ├── scripts/gh
    └── skills/
        ├── create-pull-request/
        └── review-pull-request/
```

## What is packaged

- `create-pull-request` skill
- `review-pull-request` skill
- bundled `scripts/gh` wrapper

The bundled wrapper selects the bot identity with `CODEX_GH_PROFILE`:

- `CODEX_GH_PROFILE=doppelganger` for PR creation
- `CODEX_GH_PROFILE=codex` for PR review

## Installation shape

This repo is structured for Codex's local plugin marketplace manifests:

- marketplace manifest: `.agents/plugins/marketplace.json`
- plugin path: `./plugins/github-workflow`

For a home-local install, the same layout maps naturally to:

- `~/.agents/plugins/marketplace.json`
- `~/plugins/github-workflow`

## Runtime dependencies

- `gh`
- `gh-app-token`
- `pass`

The wrapper expects these pass entries to exist:

- `tamakiii/github.com/tamakiii-codex/app-id`
- `tamakiii/github.com/tamakiii-codex/installation-id`
- `tamakiii/github.com/tamakiii-codex.pem`
- `tamakiii/github.com/tamakiii-doppelganger/app-id`
- `tamakiii/github.com/tamakiii-doppelganger/installation-id`
- `tamakiii/github.com/tamakiii-doppelganger.pem`
