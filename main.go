package main

import (
	"fmt"
	"net/http"
	"time"
)

func hello(w http.ResponseWriter, req *http.Request) {
	time.Sleep(1 * time.Second)
	fmt.Fprintln(w,"hello");
}

func main() {
	http.HandleFunc("/hello", hello)

	fmt.Println("Server is listening on :8080")
	http.ListenAndServe(":8080", nil)
}
