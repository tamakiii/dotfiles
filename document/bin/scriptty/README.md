# scriptty

Enhanced terminal session recorder that supercharges macOS's built-in `script` command with modern UX and powerful features.

## Overview

scriptty is a user-friendly wrapper around the BSD `script` command that comes with macOS. While the native `script` command is powerful, it has a cryptic interface and basic file management. scriptty adds:

- **npx-style command execution**: `scriptty claude` instead of `script output.txt claude`
- **Smart file organization**: Timestamped logs with descriptive names in organized directories
- **Session management**: Resume sessions, check status, duration tracking
- **Enhanced log management**: Easy viewing, filtering, and cleanup
- **BSD script superpowers**: Access to keylogging, live streaming, and raw recording modes
- **Security features**: Private mode with sensitive data scanning

## Key Features

### 🚀 **npx-Style Command Execution**
```bash
# Old way (BSD script)
script /tmp/mylog.txt npm test

# New way (scriptty)
scriptty npm test
```

### 📊 **BSD Script Enhanced Modes**
```bash
scriptty -k make build      # Keylog mode: Records timing data for replay
scriptty -f npm test        # Live streaming: Real-time output
scriptty -r debug-session   # Raw mode: No post-processing
```

### 📁 **Smart File Management**
- Automatic timestamped filenames: `ttys002_npm_20231201_143022`
- Organized log directory structure
- Easy log viewing with ANSI filtering
- Bulk cleanup of old logs

### 🎮 **Session Management**
- Resume interrupted sessions
- Check active recording status
- Track session duration
- Handle multiple concurrent sessions

## Installation

scriptty works with macOS's built-in BSD `script` command - no additional installation required!

Simply clone the dotfiles repository or copy the `scriptty` script to your PATH.

## Usage

### Basic Recording

```bash
# Interactive session
scriptty

# Record a specific command  
scriptty claude
scriptty npm test
scriptty make build

# With options
scriptty -q npm test        # Quiet mode
scriptty -d ~/logs claude   # Custom directory
```

### BSD Script Enhanced Modes

```bash
# Keylog mode - records timing data for keystroke analysis
scriptty -k interactive-debug

# Live streaming - shows output in real-time  
scriptty -f long-running-process

# Raw mode - no post-processing of output
scriptty -r system-diagnostics

# Combinations work too
scriptty -qk npm test       # Quiet + keylog mode
```

### Session Management

```bash
# Check what's currently recording
scriptty -s

# Resume the most recent session
scriptty --resume

# List recent session logs
scriptty -l

# View a session log (with ANSI filtering)
scriptty --view /tmp/dev/ttys002_npm_20231201_143022
```

### Log Management

```bash
# Clean logs older than 30 days (default)
scriptty --clean

# Clean logs older than 7 days
scriptty --clean 7

# Filter ANSI codes from a log file
scriptty --filter logfile.txt
```

## Command Line Options

```
Usage: scriptty [OPTIONS] [COMMAND [ARGS...]]

Core Options:
  -d, --dir DIR      Custom log directory (default: /tmp/dev)
  -a, --append       Append to existing log file instead of creating new
  -q, --quiet        Suppress script start and stop messages
  -e, --exit-code    Return exit code of recorded command

BSD Script Enhanced Modes:
  -f, --flush        Live streaming mode (real-time output)
  -k, --keylog       Record timing data for keystroke replay  
  -r, --raw          Raw recording mode (no post-processing)

Session Management:
  --resume           Resume the most recent session for this TTY
  -s, --status       Check if a script session is currently active

Log Management:
  -l, --list         List recent session logs
  --view FILE        View a log file with less (strips ANSI codes)
  --clean [DAYS]     Remove log files older than DAYS (default: 30)
  --filter FILE      Display log file with ANSI codes stripped

Security:
  --private          Warn about sensitive data recording and scan logs

Other:
  -h, --help         Show this help message
```

## BSD Script Features Explained

### Keylog Mode (`-k`)
Records timing information for each keystroke, enabling analysis of typing patterns and session replay capabilities.

```bash
scriptty -k debugging-session
# Creates both output log and timing data
```

### Live Streaming (`-f`) 
Forces real-time output flushing, perfect for monitoring long-running processes.

```bash
scriptty -f npm run build
# See build output as it happens
```

### Raw Mode (`-r`)
Disables post-processing, capturing exactly what the terminal sees without any cleanup.

```bash
scriptty -r system-diagnostics  
# Raw terminal data, useful for debugging display issues
```

## Use Cases

### Development Workflows

```bash
# Record build processes for troubleshooting
scriptty -k make clean all

# Monitor deployment scripts in real-time
scriptty -f ansible-playbook deploy.yml

# Capture test output for analysis
scriptty npm test -- --verbose
```

### Learning and Documentation

```bash
# Record tutorial sessions with timing data
scriptty -k learn-kubernetes

# Capture command demonstrations
scriptty -q --private demo-commands

# Document deployment procedures
scriptty -d ~/deployment-docs production-deploy
```

### System Debugging

```bash
# Raw system diagnostics
scriptty -r system-health-check

# Live monitoring of system processes  
scriptty -f top

# Detailed debugging session with timing
scriptty -k debug-memory-leak
```

## Log File Format

scriptty creates organized, descriptive log files:

```
Format: {tty}_{command}_{timestamp}
Examples:
  ttys002_npm_20231201_143022      # npm command
  ttys001_claude_20231201_144530   # claude session  
  ttys003_20231201_150000          # Interactive session
```

### Directory Structure
```
/tmp/dev/                    # Default log directory
├── ttys002_npm_20231201_143022
├── ttys002_make_20231201_144500
└── ttys001_claude_20231201_145000
```

## BSD vs GNU Script

scriptty is designed specifically for BSD script (macOS default) and takes advantage of its unique features:

| Feature | BSD Script (scriptty) | GNU Script |
|---------|----------------------|------------|
| **Keylog mode** | ✅ `-k` flag | ❌ No equivalent |
| **Live streaming** | ✅ `-F` flag | Limited |
| **Raw recording** | ✅ `-r` flag | Different approach |
| **Built-in availability** | ✅ macOS default | Requires installation |
| **Replay tools** | Manual/custom | scriptreplay available |

## Troubleshooting

### Script Command Not Found
```bash
[ERROR] script command not found in PATH
        The script command should be available on macOS by default
        If missing, try: xcode-select --install
```

**Solution**: Install Xcode command line tools.

### Permission Issues
```bash
[ERROR] Failed to create log directory: /tmp/dev
```

**Solution**: Use custom directory with proper permissions:
```bash
scriptty -d ~/scriptty-logs command
```

### Active Session Conflicts
```bash
[WARNING] Script session already active!
```

**Solution**: Exit current session or use a different terminal window.

## Advanced Features

### Private Mode
```bash
scriptty --private sensitive-command
```
- Warns about recording sensitive data
- Scans logs for potential passwords, keys, API tokens
- Provides security recommendations

### Session Resume
```bash
scriptty --resume
```
- Continues the most recent session for the current TTY
- Maintains session continuity across interruptions
- Preserves log file naming and organization

### Bulk Log Management
```bash
# Clean up old logs
scriptty --clean 14    # Remove logs older than 14 days

# View recent sessions
scriptty -l           # List with timestamps and sizes
```

## Integration with Other Tools

### With Development Tools
```bash
# CI/CD pipeline recording
scriptty -k ./deploy.sh

# Test result capture
scriptty npm test 2>&1 | tee test-results.txt
```

### With System Administration
```bash
# System health monitoring
scriptty -f watch -n 1 'ps aux | head -20'

# Security auditing
scriptty --private security-scan.sh
```

## Contributing

scriptty is part of the [tamakiii/.dotfiles](https://github.com/tamakiii/.dotfiles) repository.

### Development

1. Clone the repository
2. Test with various BSD script scenarios
3. Ensure compatibility with macOS script command
4. Follow the project's contribution guidelines

### Testing

```bash
# Test basic functionality
scriptty echo "test"

# Test BSD-specific features  
scriptty -k echo "keylog test"
scriptty -f echo "live stream test"
scriptty -r echo "raw mode test"

# Test session management
scriptty --status
scriptty --resume
```

## License

MIT License - see the main dotfiles repository for full license text.

## See Also

- [script(1)](https://man.freebsd.org/cgi/man.cgi?query=script&sektion=1) - BSD script manual
- [Terminal recording alternatives](https://asciinema.org/) - Modern web-based recording
- [FreeBSD script documentation](https://docs.freebsd.org/en/books/handbook/) - Comprehensive BSD docs
- [macOS Terminal utilities](https://support.apple.com/guide/terminal/) - Native macOS terminal features