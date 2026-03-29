.PHONY: check

check: \
	check-claude-settings-allow \
	check-claude-settings-deny

check-claude-settings-allow:
	@jq -e '.permissions.allow | index("Bash(~/.claude/bin/gh *)")' ~/.claude/settings.json > /dev/null \
		|| (echo "FAIL: ~/.claude/settings.json missing allow rule: Bash(~/.claude/bin/gh *)" >&2; exit 1)
	@echo "OK: allow Bash(~/.claude/bin/gh *)"

check-claude-settings-deny:
	@jq -e '.permissions.deny | index("Bash(/usr/bin/gh *)")' ~/.claude/settings.json > /dev/null \
		|| (echo "FAIL: ~/.claude/settings.json missing deny rule: Bash(/usr/bin/gh *)" >&2; exit 1)
	@echo "OK: deny Bash(/usr/bin/gh *)"
	@jq -e '.permissions.deny | index("Bash(gh *)")' ~/.claude/settings.json > /dev/null \
		|| (echo "FAIL: ~/.claude/settings.json missing deny rule: Bash(gh *)" >&2; exit 1)
	@echo "OK: deny Bash(gh *)"
