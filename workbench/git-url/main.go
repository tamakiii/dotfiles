import (
    "github.com/go-git/go-git/v5"
    "github.com/go-git/go-git/v5/plumbing/transport"
)

repo, _ := git.PlainOpen(".")
remote, _ := repo.Remote("origin")
for _, url := range remote.Config().URLs {
    endpoint, _ := transport.NewEndpoint(url)
    fmt.Println(endpoint.Host)
    fmt.Println(endpoint.Path)
}

// TODO: output JSON by default
