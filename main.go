package main

import (
	// "fmt"
	"io"
	"os"
)

func main() {
	os.Exit(handle(os.Args, os.Stdin, os.Stdout, os.Stderr))
}

func handle(args []string, stdin io.Reader, stdout, stderr io.Writer) int {
	return 1
}