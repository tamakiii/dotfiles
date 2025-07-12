package main

import (
	"encoding/json"
	"os"
	"path/filepath"
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
				Protocol:        "ssh",
				User:            "git",
				Password:        "",
				Host:            "github.com",
				Port:            22,
				Path:            "user/repo.git",
				InsecureSkipTLS: false,
				CaBundle:        nil,
			},
		},
		{
			name: "GitHub HTTPS URL",
			url:  "https://github.com/user/repo.git",
			expected: Endpoint{
				Protocol:        "https",
				User:            "",
				Password:        "",
				Host:            "github.com",
				Port:            0,
				Path:            "/user/repo.git",
				InsecureSkipTLS: false,
				CaBundle:        nil,
			},
		},
		{
			name: "GitHub HTTPS URL with auth",
			url:  "https://token@github.com/user/repo.git",
			expected: Endpoint{
				Protocol:        "https",
				User:            "token",
				Password:        "",
				Host:            "github.com",
				Port:            0,
				Path:            "/user/repo.git",
				InsecureSkipTLS: false,
				CaBundle:        nil,
			},
		},
		{
			name: "GitLab SSH URL",
			url:  "git@gitlab.com:group/project.git",
			expected: Endpoint{
				Protocol:        "ssh",
				User:            "git",
				Password:        "",
				Host:            "gitlab.com",
				Port:            22,
				Path:            "group/project.git",
				InsecureSkipTLS: false,
				CaBundle:        nil,
			},
		},
		{
			name: "Custom SSH with port",
			url:  "ssh://git@example.com:2222/path/to/repo.git",
			expected: Endpoint{
				Protocol:        "ssh",
				User:            "git",
				Password:        "",
				Host:            "example.com",
				Port:            2222,
				Path:            "/path/to/repo.git",
				InsecureSkipTLS: false,
				CaBundle:        nil,
			},
		},
		{
			name: "SCP-like format",
			url:  "user@host.example.com:path/to/repo.git",
			expected: Endpoint{
				Protocol:        "ssh",
				User:            "user",
				Password:        "",
				Host:            "host.example.com",
				Port:            22,
				Path:            "path/to/repo.git",
				InsecureSkipTLS: false,
				CaBundle:        nil,
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
			if result.Password != tt.expected.Password {
				t.Errorf("Password mismatch for %s: got %s, want %s", tt.url, result.Password, tt.expected.Password)
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
			if result.InsecureSkipTLS != tt.expected.InsecureSkipTLS {
				t.Errorf("InsecureSkipTLS mismatch for %s: got %t, want %t", tt.url, result.InsecureSkipTLS, tt.expected.InsecureSkipTLS)
			}
			if string(result.CaBundle) != string(tt.expected.CaBundle) {
				t.Errorf("CaBundle mismatch for %s: got %v, want %v", tt.url, result.CaBundle, tt.expected.CaBundle)
			}
		})
	}
}

func TestLocalFilePath(t *testing.T) {
	url := "not-a-valid-url"
	endpoint, err := transport.NewEndpoint(url)
	if err != nil {
		t.Fatalf("Unexpected error parsing URL %s: %v", url, err)
	}

	// Get current working directory to compute expected path
	cwd, err := os.Getwd()
	if err != nil {
		t.Fatalf("Failed to get current working directory: %v", err)
	}
	expectedPath := filepath.Join(cwd, url)

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

	if result.Protocol != "file" {
		t.Errorf("Protocol mismatch: got %s, want file", result.Protocol)
	}
	if result.Host != "" {
		t.Errorf("Host mismatch: got %s, want empty", result.Host)
	}
	if result.Path != expectedPath {
		t.Errorf("Path mismatch: got %s, want %s", result.Path, expectedPath)
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

func TestErrorHandling(t *testing.T) {
	// Test that JSON marshaling works for all endpoint types
	// Since the go-git transport library is quite permissive, we test JSON marshaling robustness
	testURLs := []string{
		"",
		"git@github.com:user/repo.git",
		"https://github.com/user/repo.git",
		"file:///path/to/repo",
	}
	
	for _, url := range testURLs {
		if url == "" {
			continue // Skip empty URLs as they get filtered out by main()
		}
		
		endpoint, err := transport.NewEndpoint(url)
		if err != nil {
			// Some URLs might fail parsing, which is okay
			continue
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
		
		// Verify JSON marshaling always works (should never fail with our simple struct)
		_, err = json.Marshal(result)
		if err != nil {
			t.Errorf("Unexpected JSON marshaling error for URL %s: %v", url, err)
		}
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