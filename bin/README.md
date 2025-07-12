# Custom Scripts and Utilities

This directory contains custom shell scripts and utilities that enhance the development workflow. These scripts are automatically added to your PATH via the `.zshrc` configuration.

## Available Scripts

### scriptty

Enhanced terminal session recorder that supercharges macOS's built-in `script` command with modern UX and powerful features.

**Overview:**
`scriptty` is a user-friendly wrapper around the BSD `script` command that comes with macOS. While the native `script` command is powerful, it has a cryptic interface and basic file management. scriptty adds modern UX and enhanced capabilities.

**Key Features:**
- **npx-style command execution**: `scriptty claude` instead of `script output.txt claude`
- **Smart file organization**: Timestamped logs with descriptive names in organized directories
- **Session management**: Resume sessions, check status, duration tracking
- **Enhanced log management**: Easy viewing, filtering, and cleanup
- **BSD script superpowers**: Access to keylogging, live streaming, and raw recording modes
- **Security features**: Private mode with sensitive data scanning

**Quick Start:**
```bash
# Record interactive session
scriptty

# Record specific command with timing data
scriptty -k make build

# Live streaming for long processes
scriptty -f npm test

# Session management
scriptty -s              # Check status
scriptty -l              # List sessions
scriptty --resume        # Resume last session
```

**Advanced Usage:**
```bash
# BSD script enhanced modes
scriptty -k interactive-debug    # Keylog mode for timing analysis
scriptty -f long-running-build   # Live streaming mode
scriptty -r system-diagnostics   # Raw mode, no post-processing

# Log management
scriptty --view session-file     # View with ANSI filtering
scriptty --clean 30             # Clean logs older than 30 days
scriptty --filter logfile        # Strip ANSI codes
```

**File Organization:**
```
/tmp/dev/                        # Default log directory
├── ttys002_npm_20231201_143022  # npm command session
├── ttys002_make_20231201_144500 # make command session
└── ttys001_claude_20231201_145000 # claude session
```

**For comprehensive documentation, see [../document/bin/scriptty/README.md](../document/bin/scriptty/README.md).**

## Script Integration

### PATH Configuration

Scripts in this directory are automatically available in your shell through `.zshrc`:

```bash
# .zshrc includes this directory in PATH
export PATH="$HOME/.dotfiles/bin:$PATH"
```

### Shell Integration

The scripts integrate seamlessly with other dotfiles components:

- **Git workflows**: scriptty can record git operations for troubleshooting
- **Claude Code**: Terminal recordings can be shared with AI assistants for debugging
- **Development workflows**: Capture build processes, test runs, and deployment procedures

### Usage Patterns

**Development Workflow Recording:**
```bash
# Record entire development session
scriptty

# Record specific build with timing data
scriptty -k npm run build

# Monitor deployment in real-time
scriptty -f ./deploy.sh
```

**Learning and Documentation:**
```bash
# Record tutorial sessions
scriptty -k learn-kubernetes

# Capture command demonstrations for documentation
scriptty -q demo-commands

# Document troubleshooting procedures
scriptty debug-session
```

**System Administration:**
```bash
# Record system diagnostics
scriptty -r system-health-check

# Monitor system processes
scriptty -f top

# Debug with timing information
scriptty -k debug-memory-leak
```

## Adding New Scripts

When adding new scripts to this directory:

### 1. Script Requirements
- **Executable permission**: `chmod +x script-name`
- **Shebang line**: Include appropriate interpreter (e.g., `#!/usr/bin/env bash`)
- **Error handling**: Include proper error checking and cleanup
- **Documentation**: Add usage information and examples

### 2. Naming Conventions
- Use lowercase with hyphens for multi-word names
- Choose descriptive names that indicate purpose
- Avoid conflicts with system commands

### 3. Script Template
```bash
#!/usr/bin/env bash
#
# script-name - Brief description of what the script does
#
# Usage: script-name [OPTIONS] [ARGUMENTS]
#
# Description of functionality and use cases.
#

set -euo pipefail

# Default configuration
VERBOSE=false
CONFIG_FILE=""

# Function to display usage
show_help() {
    sed -n '2,10p' "$0" | sed 's/^# //'
    exit 0
}

# Main script logic
main() {
    # Implementation here
    echo "Script execution"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Execute main function
main "$@"
```

### 4. Documentation Updates
- Add entry to this README.md
- Include usage examples
- Document integration with other tools
- Update main repository documentation if significant

### 5. Testing
- Test on clean system
- Verify PATH integration
- Check error handling
- Validate help output

## Script Dependencies

### System Requirements
- **macOS**: Most scripts are optimized for macOS
- **Bash/Zsh**: Compatible with both shells
- **Standard utilities**: awk, sed, grep, find, etc.

### Optional Dependencies
- **fzf**: For interactive selection features
- **jq**: For JSON processing
- **git**: For git-related functionality

### Checking Dependencies
```bash
# Verify required tools are available
command -v fzf >/dev/null 2>&1 || echo "fzf not found"
command -v jq >/dev/null 2>&1 || echo "jq not found"
```

## Troubleshooting

### Script Not Found
```bash
# Check if script is in PATH
which script-name

# Verify PATH includes bin directory
echo $PATH | grep -q ~/.dotfiles/bin

# Reload shell configuration
source ~/.zshrc
```

### Permission Issues
```bash
# Make script executable
chmod +x ~/.dotfiles/bin/script-name

# Check current permissions
ls -la ~/.dotfiles/bin/script-name
```

### PATH Issues
```bash
# Verify PATH configuration
grep -n "bin" ~/.zshrc

# Test PATH manually
export PATH="$HOME/.dotfiles/bin:$PATH"
```

## Security Considerations

### Safe Scripting Practices
- Use `set -euo pipefail` for error handling
- Quote variables to prevent word splitting
- Validate input parameters
- Avoid hardcoded paths when possible

### Sensitive Data
- Never store credentials in scripts
- Use environment variables or keychain for secrets
- Sanitize output when recording sessions
- Consider privacy implications of session recording

### Script Permissions
- Only make scripts executable that need to be
- Review scripts before making them executable
- Use least privilege principles

## Integration Examples

### With Claude Code
```bash
# Record Claude sessions for analysis
scriptty claude --model sonnet -p "Help me debug this error"

# Share terminal recordings with AI for troubleshooting
scriptty --view session-file | claude --model sonnet -p "Analyze this terminal output"
```

### With Git Workflows
```bash
# Record git operations for troubleshooting
scriptty git rebase --interactive main

# Capture deployment procedures
scriptty -k ./deployment-script.sh
```

### With Development Tools
```bash
# Record build processes
scriptty -f npm run build:production

# Debug test failures with timing
scriptty -k npm test -- --verbose
```

## Contributing

When contributing new scripts:

1. **Follow established patterns** in existing scripts
2. **Include comprehensive documentation** with examples
3. **Test thoroughly** on clean systems
4. **Consider cross-platform compatibility** where possible
5. **Update documentation** including this README

## References

- [Bash Scripting Guide](https://www.gnu.org/software/bash/manual/)
- [Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [scriptty Documentation](../document/bin/scriptty/README.md)
- [Main Dotfiles Documentation](../README.md)