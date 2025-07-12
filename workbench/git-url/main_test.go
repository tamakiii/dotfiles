package main

import (
	"encoding/json"
	"testing"

	"github.com/go-git/go-git/v5/plumbing/transport"
)

func TestGitURLParsing(t *testing.T) {
	tests := []struct {
		name     string
		url      string
		expected Endpoint
	}{
		{
			name: "GitHub SSH URL",
			url:  "git@github.com:user/repo.git",
			expected: Endpoint{
				Protocol: "ssh",
				User:     "git",
				Host:     "github.com",
				Port:     22,
				Path:     "user/repo.git",
			},
		},
		{
			name: "GitHub HTTPS URL",
			url:  "https://github.com/user/repo.git",
			expected: Endpoint{
				Protocol: "https",
				Host:     "github.com",
				Path:     "/user/repo.git",
			},
		},
		{
			name: "GitHub HTTPS URL with auth",
			url:  "https://token@github.com/user/repo.git",
			expected: Endpoint{
				Protocol: "https",
				User:     "token",
				Host:     "github.com",
				Path:     "/user/repo.git",
			},
		},
		{
			name: "GitLab SSH URL",
			url:  "git@gitlab.com:group/project.git",
			expected: Endpoint{
				Protocol: "ssh",
				User:     "git",
				Host:     "gitlab.com",
				Port:     22,
				Path:     "group/project.git",
			},
		},
		{
			name: "Custom SSH with port",
			url:  "ssh://git@example.com:2222/path/to/repo.git",
			expected: Endpoint{
				Protocol: "ssh",
				User:     "git",
				Host:     "example.com",
				Port:     2222,
				Path:     "/path/to/repo.git",
			},
		},
		{
			name: "SCP-like format",
			url:  "user@host.example.com:path/to/repo.git",
			expected: Endpoint{
				Protocol: "ssh",
				User:     "user",
				Host:     "host.example.com",
				Port:     22,
				Path:     "path/to/repo.git",
			},
		},
		{
			name: "Local file path",
			url:  "not-a-valid-url",
			expected: Endpoint{
				Protocol: "file",
				Host:     "",
				Path:     "/Users/tamakiii/.dotfiles/workbench/git-url/not-a-valid-url",
			},
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			endpoint, err := transport.NewEndpoint(tt.url)
			
			if err != nil {
				t.Fatalf("Unexpected error parsing URL %s: %v", tt.url, err)
			}

			result := Endpoint{
				Protocol:        endpoint.Protocol,
				User:           endpoint.User,
				Password:       endpoint.Password,
				Host:           endpoint.Host,
				Port:           endpoint.Port,
				Path:           endpoint.Path,
				InsecureSkipTLS: endpoint.InsecureSkipTLS,
				CaBundle:       endpoint.CaBundle,
			}

			if result.Protocol != tt.expected.Protocol {
				t.Errorf("Protocol mismatch for %s: got %s, want %s", tt.url, result.Protocol, tt.expected.Protocol)
			}
			if result.User != tt.expected.User {
				t.Errorf("User mismatch for %s: got %s, want %s", tt.url, result.User, tt.expected.User)
			}
			if result.Host != tt.expected.Host {
				t.Errorf("Host mismatch for %s: got %s, want %s", tt.url, result.Host, tt.expected.Host)
			}
			if result.Port != tt.expected.Port {
				t.Errorf("Port mismatch for %s: got %d, want %d", tt.url, result.Port, tt.expected.Port)
			}
			if result.Path != tt.expected.Path {
				t.Errorf("Path mismatch for %s: got %s, want %s", tt.url, result.Path, tt.expected.Path)
			}
		})
	}
}

func TestJSONMarshaling(t *testing.T) {
	endpoint := Endpoint{
		Protocol: "ssh",
		User:     "git",
		Host:     "github.com",
		Path:     "/user/repo.git",
		Port:     22,
	}

	data, err := json.Marshal(endpoint)
	if err != nil {
		t.Fatalf("Failed to marshal JSON: %v", err)
	}

	var unmarshaled Endpoint
	err = json.Unmarshal(data, &unmarshaled)
	if err != nil {
		t.Fatalf("Failed to unmarshal JSON: %v", err)
	}

	if endpoint.Protocol != unmarshaled.Protocol ||
		endpoint.User != unmarshaled.User ||
		endpoint.Password != unmarshaled.Password ||
		endpoint.Host != unmarshaled.Host ||
		endpoint.Port != unmarshaled.Port ||
		endpoint.Path != unmarshaled.Path ||
		endpoint.InsecureSkipTLS != unmarshaled.InsecureSkipTLS ||
		string(endpoint.CaBundle) != string(unmarshaled.CaBundle) {
		t.Errorf("JSON round-trip failed: got %+v, want %+v", unmarshaled, endpoint)
	}
}

func TestEmptyFields(t *testing.T) {
	endpoint := Endpoint{
		Protocol: "https",
		Host:     "github.com",
		Path:     "/user/repo.git",
	}

	data, err := json.MarshalIndent(endpoint, "", "  ")
	if err != nil {
		t.Fatalf("Failed to marshal JSON: %v", err)
	}

	var result map[string]interface{}
	err = json.Unmarshal(data, &result)
	if err != nil {
		t.Fatalf("Failed to unmarshal to map: %v", err)
	}

	if result["user"] != "" {
		t.Errorf("Expected empty user field to be empty string, got %v", result["user"])
	}
	if result["password"] != "" {
		t.Errorf("Expected empty password field to be empty string, got %v", result["password"])
	}
	if result["port"] != float64(0) {
		t.Errorf("Expected empty port field to be 0, got %v", result["port"])
	}
}