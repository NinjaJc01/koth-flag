package main

import (
    "fmt"
	"net/http"
	"io/ioutil"
)

func main() {
    http.HandleFunc("/", returnKing)
    http.ListenAndServe(":9999", nil)
}

func returnKing(w http.ResponseWriter, r *http.Request) {
    w.Write(readKing())
}
func readKing() []byte{
	buff, err := ioutil.ReadFile("king.txt")
	if err != nil {
		fmt.Println(err.Error())
	}
	return buff
}