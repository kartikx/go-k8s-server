package main

import (
	"fmt"
	"net/http"
	"os"
)

func hello(w http.ResponseWriter, req *http.Request) {
	hostname, _ := os.Hostname()
    fmt.Fprintf(w, "Hello from %s\n", hostname)
}

func main() {
	http.HandleFunc("/", hello)
	fmt.Println("Server is listening on :8080")
	http.ListenAndServe(":8080", nil)
}
