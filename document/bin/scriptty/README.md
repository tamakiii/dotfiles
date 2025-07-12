# scriptty

Enhanced terminal session recorder using the GNU `script` command with npx-style command execution.

##  Important: GNU Script Requirement

**scriptty works best with the GNU version of the `script` command, not the BSD version included with macOS.**

The GNU `script` command provides enhanced features that scriptty can utilize:
- Advanced timing support for session replay
- Consistent flush behavior across platforms  
- Better command-line option compatibility
- More reliable output handling

**Note**: scriptty will work with BSD script (the macOS default) but with reduced functionality. For the best experience, install GNU script via Nix or MacPorts.

## Installation

### 1. Install GNU Script (macOS)

⚠️ **Important Update**: Homebrew's util-linux package excludes the `script` command on macOS. Use one of these alternatives:

#### Option A: Nix Package Manager (Recommended)
```bash
# Install Nix
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)

# Install util-linux with GNU script
nix-env -iA nixpkgs.util-linux
# Or temporarily: nix shell nixpkgs#util-linux
```

#### Option B: MacPorts
```bash
sudo port install util-linux
```
Note: The script command may have limited functionality on macOS.

#### Option C: Use BSD Script (Limited Features)
scriptty will work with BSD script but with reduced functionality.

#### Option D: Alternative - unbuffer (For TTY Simulation)
```bash
brew install expect
# Use unbuffer for some TTY-dependent commands:
unbuffer -p command
```

### 2. Verify Installation

```bash
# For Nix installation:
script --version
# Should show: script from util-linux 2.x.x

# For MacPorts:
/opt/local/bin/script --version

# Test scriptty detection:
scriptty --help
# Should show minimal warnings if GNU script is found
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
# Error: scriptty requires script command
[ERROR] No script command found in PATH
        Please install a script command for terminal recording
        macOS options:
          - Nix: nix-env -iA nixpkgs.util-linux
          - MacPorts: sudo port install util-linux
          - BSD script is built-in but limited
        Linux: sudo apt install util-linux
```

**Solution**: 
1. **Nix (Recommended)**: Install Nix package manager and util-linux as shown in Installation section
2. **MacPorts**: Install via MacPorts if available
3. **BSD Script**: Use the built-in BSD script (limited features but functional)

### Homebrew util-linux Issue

```bash
# Homebrew excludes script command on macOS
brew install util-linux
# No gscript or script command available
```

**Solution**: Homebrew's util-linux deliberately excludes the script command on macOS. Use Nix or MacPorts instead.

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
