# tamakiii/dotfiles

## How to use
```sh
make check-dependency
make install
```

### Ubuntu
```sh
make -C make -f ubuntu.mk install
```

## claude-cli
(TBW)

## MCP servers

### Remote GitHub MCP Server
* https://github.com/github/github-mcp-server

```sh
claude-cli -p "Describe this commit: https://github.com/mojombo/grit/commit/634396b2f541a9f2d58b00be1a07f0c358b999b3"
claude-cli -p "Please review the copilot-instruction: https://github.com/tamakiii/meta/blob/main/.github/copilot-instructions.md"
```


#### cross-repository issue references directly through the resource syntax
⏺ Based on the MCP documentation and the empty resources list, it appears that the GitHub MCP server in
  your current setup may not support cross-repository issue references directly through the resource
  syntax.

  The standard format @github:issue://114 would typically reference issue #114 in the current repository
  context. For cross-repository references, you might need to:

  1. Configure the MCP GitHub server to have access to the tamakiii/meta repository
  2. Or use the full GitHub URL: https://github.com/tamakiii/meta/issues/114

  Without seeing specific MCP server documentation for the GitHub integration, I cannot confirm if there's
   a syntax like @github:issue://tamakiii/meta/114 or similar for cross-repository references.

See also: https://docs.anthropic.com/en/docs/claude-code/mcp#reference-mcp-resources
