// This program runs a webserver on port 8080 and responds 
// to any request for / with a printout of its environment variables. 

package main

import (
	"fmt"
	"net/http"
	"os"
	"strings"
)

func env(w http.ResponseWriter, req *http.Request) {

	for _, e := range os.Environ() {
		pair := strings.SplitN(e, "=", 2)
		fmt.Fprintln(w,pair[0],"=",pair[1])
	}
}

func main() {

	http.HandleFunc("/", env)
	http.ListenAndServe(":8080", nil)
}

