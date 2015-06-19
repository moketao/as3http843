package main

import (
	"log"
	"net/http"
	"github.com/Unknwon/macaron"
)

var path string

func main() {
	path = ""
	m := macaron.Classic()
	m.Get("/", myHandler)
	m.Use(macaron.Static("img"))

	log.Println("as3http843 Server is running... (port:4000)")
	log.Println(http.ListenAndServe("0.0.0.0:4000", m))
}

func myHandler(ctx *macaron.Context) string {
	return "the request path is: " + ctx.Req.RequestURI
}
