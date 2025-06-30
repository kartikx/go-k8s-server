package main

import (
	"fmt"
	"net/http"
	"time"
	"os"
)

func hello(w http.ResponseWriter, req *http.Request) {
	fmt.Println("Handing request ...")
	time.Sleep(1 * time.Second)
	hostname, _ := os.Hostname()
    fmt.Fprintf(w, "Hello from pod: %s\n", hostname)
}

func main() {
	http.HandleFunc("/hello", hello)

	fmt.Println("Server is listening on :8080")
	http.ListenAndServe(":8080", nil)
}
