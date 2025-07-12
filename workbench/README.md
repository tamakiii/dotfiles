# Workbench Development Environment

The workbench directory contains development tools and utilities built in Go. This provides a structured environment for building, testing, and managing custom development utilities.

## Overview

The workbench follows a modular design where each tool has its own subdirectory with independent build configuration, allowing for:

- **Independent development**: Each tool can be developed and tested separately
- **Shared build system**: Common Makefile patterns for consistency
- **Easy integration**: Built tools are linked into a shared `bin/` directory
- **Clean separation**: Development artifacts are isolated and gitignored

## Structure

```
workbench/
├── Makefile              # Main build orchestration
├── bin/                  # Symlinks to built executables (gitignored)
├── git-url/              # Git URL parser utility
│   ├── Makefile
│   ├── README.md
│   ├── main.go
│   ├── go.mod
│   └── go.sum
└── README.md             # This file
```

## Quick Start

### Prerequisites

- Go 1.24.4 or later
- Make

### Building All Tools

```bash
# From the workbench directory
make build

# Or from repository root
make -C workbench build
```

### Building Specific Tools

```bash
# Build just git-url
make -C workbench/git-url build

# Or use the main Makefile
make bin/git-url
```

### Cleaning

```bash
# Clean all build artifacts
make clean

# Clean specific tool
make -C git-url clean
```

## Available Tools

### git-url

A command-line utility that parses Git URLs from stdin and outputs detailed endpoint information as JSON.

**Usage:**
```bash
# Parse a git remote URL
git remote get-url origin | git-url

# Parse any Git URL format
echo "git@github.com:user/repo.git" | git-url
echo "https://github.com/user/repo.git" | git-url
```

**Output Example:**
```json
{
  "caBundle": null,
  "host": "github.com",
  "insecureSkipTLS": false,
  "password": "",
  "path": "user/repo.git",
  "port": 22,
  "protocol": "ssh",
  "proxy": {
    "URL": "",
    "Username": "",
    "Password": ""
  },
  "user": "git"
}
```

**Use Cases:**
- Extracting repository information for scripts
- Converting between Git URL formats
- Analyzing Git endpoint configurations
- Integration with shell workflows

For detailed documentation, see [git-url/README.md](git-url/README.md).

## Development Workflow

### Adding New Tools

1. **Create tool directory:**
   ```bash
   mkdir workbench/new-tool
   cd workbench/new-tool
   ```

2. **Initialize Go module:**
   ```bash
   go mod init new-tool
   ```

3. **Create Makefile:**
   ```makefile
   .PHONY: help build clean
   
   help:
   	@cat $(firstword $(MAKEFILE_LIST))
   
   build: \\
   	bin \\
   	bin/new-tool
   
   clean:
   	rm -rf bin
   
   bin:
   	mkdir -p bin
   
   bin/new-tool: main.go go.mod
   	go build -o bin/new-tool .
   ```

4. **Update main workbench Makefile:**
   ```makefile
   build: \\
   	bin \\
   	bin/git-url \\
   	bin/new-tool
   
   bin/new-tool: new-tool/bin/new-tool
   	ln -sf ../new-tool/bin/new-tool bin/
   
   new-tool/bin/new-tool:
   	make -C new-tool build
   ```

5. **Create documentation:**
   - Add README.md in the tool directory
   - Update this workbench README.md
   - Add usage examples

### Testing Tools

```bash
# Test individual tool
cd git-url
go test ./...

# Test all tools
for dir in */; do
    if [[ -f "$dir/go.mod" ]]; then
        echo "Testing $dir"
        (cd "$dir" && go test ./...)
    fi
done
```

### Integration with Dotfiles

The workbench tools integrate with the dotfiles environment:

1. **PATH Integration**: Built tools are available via the shared `bin/` directory
2. **Shell Snippets**: Common usage patterns documented in `document/snippets.md`
3. **Build Integration**: Main dotfiles Makefile can trigger workbench builds
4. **Documentation**: Cross-referenced with main repository documentation

## Build System Details

### Makefile Patterns

The workbench uses consistent Makefile patterns:

1. **Help target**: `make help` shows the Makefile contents
2. **Build dependencies**: Explicit dependency chains ensure proper build order
3. **Clean targets**: Remove all build artifacts
4. **Symlink management**: Main workbench creates symlinks to individual tool binaries

### Directory Layout

- `bin/`: Contains symlinks to built executables (gitignored)
- `*/bin/`: Individual tool build directories (gitignored)
- `*/`: Tool source directories with independent Go modules

### Go Module Management

Each tool maintains its own Go module:
- Independent dependency management
- Separate version control for dependencies  
- Isolated build environments
- Easy tool extraction if needed

## Integration Examples

### Shell Workflows

```bash
# Extract repository name from URL
REPO_NAME=$(git remote get-url origin | git-url | jq -r '.path' | sed 's/\\.git$//')

# Get host for repository
REPO_HOST=$(git remote get-url origin | git-url | jq -r '.host')

# Parse URL for conditional logic
if git remote get-url origin | git-url | jq -e '.protocol == "ssh"' > /dev/null; then
    echo "Using SSH protocol"
fi
```

### Script Integration

```bash
#!/bin/bash
# Example: Clone repository to standardized path

URL="$1"
PARSED=$(echo "$URL" | git-url)
HOST=$(echo "$PARSED" | jq -r '.host')
PATH_INFO=$(echo "$PARSED" | jq -r '.path' | sed 's/\\.git$//')

mkdir -p "~/repositories/$HOST"
git clone "$URL" "~/repositories/$HOST/$PATH_INFO"
```

## Troubleshooting

### Build Issues

```bash
# Check Go installation
go version

# Verify module integrity
cd tool-directory
go mod tidy
go mod verify

# Clean and rebuild
make clean
make build
```

### Missing Dependencies

```bash
# Install/update dependencies
go mod download

# Update to latest versions
go get -u ./...
go mod tidy
```

### Permission Issues

```bash
# Ensure proper permissions
chmod +x bin/*

# Verify symlinks
ls -la bin/
```

## Contributing

When adding new tools to the workbench:

1. Follow the established directory structure
2. Use consistent Makefile patterns
3. Include comprehensive documentation
4. Add shell integration examples
5. Update main workbench documentation
6. Consider cross-platform compatibility

## References

- [Go Documentation](https://golang.org/doc/)
- [Makefile Tutorial](https://makefiletutorial.com/)
- [git-url Tool Documentation](git-url/README.md)
- [Main Dotfiles Documentation](../README.md)