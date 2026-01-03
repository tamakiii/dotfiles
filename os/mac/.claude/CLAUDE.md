# User Preferences

## Build System

Use `make` and Makefiles instead of npm scripts (package.json scripts).

When working on projects:
- Look for a `Makefile` first to understand available commands
- Run `make help` or `make` to see available targets
- Use `make <target>` to run tasks (e.g., `make test`, `make build`, `make install`)
- Do NOT suggest using `npm run`, `yarn`, or `pnpm` scripts unless explicitly requested
- If a project only has package.json scripts and no Makefile, ask if I'd like you to create a Makefile
