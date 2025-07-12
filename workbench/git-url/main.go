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

type GitURL struct {
    Host string `json:"host"`
    Path string `json:"path"`
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
        
        result := map[string]interface{}{
            "protocol":         endpoint.Protocol,
            "user":            endpoint.User,
            "password":        endpoint.Password,
            "host":            endpoint.Host,
            "port":            endpoint.Port,
            "path":            endpoint.Path,
            "insecureSkipTLS": endpoint.InsecureSkipTLS,
            "caBundle":        endpoint.CaBundle,
            "proxy":           endpoint.Proxy,
        }
        
        output, err := json.MarshalIndent(result, "", "  ")
        if err != nil {
            log.Fatal(err)
        }
        
        fmt.Println(string(output))
    }
    
    if err := scanner.Err(); err != nil {
        log.Fatal(err)
    }
}
