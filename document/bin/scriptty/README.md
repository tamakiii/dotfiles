# scriptty

Enhanced terminal session recorder using the GNU `script` command with npx-style command execution.

##  Important: GNU Script Requirement

**scriptty requires the GNU version of the `script` command, not the BSD version included with macOS.**

The GNU `script` command provides essential features that scriptty depends on:
- Advanced timing support for session replay
- Consistent flush behavior across platforms  
- Better command-line option compatibility
- More reliable output handling

## Installation

### 1. Install GNU Script (macOS)

Choose one of these methods:

```bash
brew install util-linux
```
This installs GNU script as `gscript` to avoid conflicts with BSD script.

### 2. Verify Installation

```bash
# Check GNU script is available
gscript --version
# Should show: script from util-linux 2.39.x

# Test scriptty can find GNU script
scriptty --help
```

### 3. Setup scriptty

scriptty is designed to automatically detect and use GNU script (`gscript`) when available, falling back to system script with warnings.

## Usage

### Basic Usage

```bash
# Start interactive recording session
scriptty

# Record a specific command (npx-style)
scriptty claude
scriptty npm test
scriptty make build

# With options
scriptty -q claude --help          # Quiet mode
scriptty -d ~/logs make            # Custom directory
scriptty --private sensitive-cmd   # Private mode with data scanning
```

### Command Line Options

```
Usage: scriptty [OPTIONS] [COMMAND [ARGS...]]

Options:
  -d, --dir DIR      Custom log directory (default: /tmp/dev)
  -a, --append       Append to existing log file instead of creating new
  -q, --quiet        Suppress script start and stop messages
  -e, --exit-code    Return exit code of recorded command
  -f, --flush        Force flush output after each write
  --private          Warn about sensitive data recording and scan logs
  --resume           Resume the most recent session for this TTY
  -s, --status       Check if a script session is currently active
  -l, --list         List recent session logs
  --view FILE        View a log file with less (strips ANSI codes)
  --clean [DAYS]     Remove log files older than DAYS (default: 30)
  --filter FILE      Display log file with ANSI codes stripped
  -h, --help         Show this help message
```

### Log Management

```bash
# List recent session logs
scriptty -l

# View a log file (filtered)
scriptty --view /tmp/dev/ttys002_claude_20231201_143022

# Clean old logs (30+ days)
scriptty --clean

# Clean logs older than 7 days
scriptty --clean 7

# Filter ANSI codes from a log
scriptty --filter logfile.txt
```

## Features

### NPX-Style Command Execution

scriptty supports intuitive command execution without requiring `--` separators:

```bash
# These are equivalent:
scriptty claude
scriptty -- claude

# Complex commands work naturally:
scriptty -q npm test --verbose
scriptty -d ~/logs python -m pytest
```

### Session Management

- **Resume**: Continue previous sessions with `--resume`
- **Status**: Check active sessions with `--status`  
- **Duration tracking**: Shows session length on completion
- **Smart naming**: Includes command names in log filenames

### Security Features

- **Private mode**: Warns about sensitive data and scans logs
- **Pattern detection**: Identifies potential passwords, keys, tokens
- **Safe defaults**: Encourages security-conscious recording

### Platform Optimization

- **Automatic detection**: Prefers GNU script over BSD script
- **Smart options**: Uses appropriate flags based on script version
- **Cross-platform**: Works consistently across Linux and macOS

## Examples

### Development Workflows

```bash
# Record a build process
scriptty make clean all

# Debug a failing test
scriptty --private npm test -- --debug

# Document a deployment
scriptty -d ~/deployment-logs ansible-playbook deploy.yml
```

### Learning and Documentation

```bash
# Record a tutorial session
scriptty -q --private learn-kubernetes

# Capture command outputs for documentation
scriptty --filter kubectl get pods > docs/pod-status.txt
```

### Troubleshooting

```bash
# Resume a long-running process
scriptty --resume

# Check what's currently recording
scriptty --status

# Review recent sessions
scriptty -l
scriptty --view /tmp/dev/ttys002_debug_20231201_143022
```

## Technical Details

### GNU vs BSD Script Differences

| Feature | GNU script | BSD script (macOS) | Impact |
|---------|------------|-------------------|---------|
| Timing data | `-t, -T` flags | Not supported | No replay capability |
| Flush behavior | `-f` flag | `-F` flag | Inconsistent options |
| Input logging | `-I` flag | Limited | Reduced debugging info |
| Exit codes | Reliable | Inconsistent | Poor error handling |

### Log File Format

scriptty creates timestamped logs with descriptive filenames:

```
Format: {tty}_{command}_{timestamp}
Examples:
  ttys002_claude_20231201_143022
  ttys001_npm_20231201_144530
  ttys003_20231201_150000        # Interactive session
```

### Platform Detection

scriptty automatically detects the platform and script version:

1. **Prefers GNU script**: Checks for `gscript` first
2. **Falls back gracefully**: Uses system script with warnings
3. **Optimizes flags**: Adjusts options based on detected version
4. **Warns users**: Alerts when GNU script features unavailable

## Troubleshooting

### GNU Script Not Found

```bash
# Error: scriptty requires GNU script
[ERROR] GNU script not found. Please install util-linux.
        macOS: brew install util-linux
        Linux: sudo apt install util-linux (usually pre-installed)
```

**Solution**: Install util-linux package as described in Installation section.

### Permission Issues

```bash
# Error: Cannot create log directory
[ERROR] Failed to create log directory: /tmp/dev
```

**Solution**: Check directory permissions or use custom directory:
```bash
scriptty -d ~/scriptty-logs command
```

### Active Session Conflicts

```bash
# Error: Script session already active
[WARNING] Script session already active!
```

**Solution**: Exit current session or use different terminal.

## Contributing

scriptty is part of the [tamakiii/.dotfiles](https://github.com/tamakiii/.dotfiles) repository. 

### Development Setup

1. Clone the dotfiles repository
2. Install GNU script (see Installation section)
3. Test with various command scenarios
4. Follow the project's contribution guidelines

### Testing

```bash
# Test basic functionality
scriptty echo "test"

# Test option parsing
scriptty -q -d /tmp echo "quiet test"

# Test error handling
scriptty -x  # Should show error

# Test GNU script detection
scriptty --status
```

## License

MIT License - see the main dotfiles repository for full license text.

## See Also

- [GNU util-linux documentation](https://www.kernel.org/pub/linux/utils/util-linux/)
- [scriptreplay(1)](https://man7.org/linux/man-pages/man1/scriptreplay.1.html) - For replaying GNU script sessions
- [script(1)](https://man7.org/linux/man-pages/man1/script.1.html) - GNU script manual
- [Alternative tools: asciinema, ttyrec](https://asciinema.org/) - Modern terminal recording
