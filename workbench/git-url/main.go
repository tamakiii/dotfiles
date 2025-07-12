package main

import (
    "bufio"
    "encoding/json"
    "fmt"
    "log"
    "os"
    "strings"

    "github.com/go-git/go-git/v5/plumbing/transport"
)

type Endpoint struct {
    Protocol         string `json:"protocol"`
    User             string `json:"user"`
    Password         string `json:"password"`
    Host             string `json:"host"`
    Port             int    `json:"port"`
    Path             string `json:"path"`
    InsecureSkipTLS  bool   `json:"insecureSkipTLS"`
    CaBundle         []byte `json:"caBundle"`
}

func main() {
    scanner := bufio.NewScanner(os.Stdin)
    
    for scanner.Scan() {
        line := strings.TrimSpace(scanner.Text())
        if line == "" {
            continue
        }
        
        endpoint, err := transport.NewEndpoint(line)
        if err != nil {
            log.Printf("Error parsing URL %s: %v", line, err)
            continue
        }
        
        result := Endpoint{
            Protocol:         endpoint.Protocol,
            User:             endpoint.User,
            Password:         endpoint.Password,
            Host:             endpoint.Host,
            Port:             endpoint.Port,
            Path:             endpoint.Path,
            InsecureSkipTLS:  endpoint.InsecureSkipTLS,
            CaBundle:         endpoint.CaBundle,
        }
        
        output, err := json.MarshalIndent(result, "", "  ")
        if err != nil {
            log.Printf("Error marshaling JSON for URL %s: %v", line, err)
            continue
        }
        
        fmt.Println(string(output))
    }
    
    if err := scanner.Err(); err != nil {
        log.Fatal(err)
    }
}
