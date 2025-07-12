# git-url

A command-line tool that parses Git URLs from stdin and outputs detailed endpoint information as JSON.

## Usage

```bash
# Parse a Git URL
echo "git@github.com:user/repo.git" | git-url

# Parse from git remote
git remote get-url origin | git-url

# Parse HTTPS URLs
echo "https://github.com/user/repo.git" | git-url
```

## Output

The tool outputs JSON with all endpoint fields:

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

## Build

```bash
# From workbench directory
make build

# Or directly
cd git-url && go build -o ../bin/git-url .
```