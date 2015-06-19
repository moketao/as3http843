package main
import (
    "fmt"
    "log"
    "net"
    "bufio"
)
func handleConnection(conn net.Conn) {
	fmt.Println(conn.RemoteAddr().String()+" in.")
    data, err := bufio.NewReader(conn).ReadString('\n')
    if err != nil {
        log.Println("get client data error: ", err)
    }
    fmt.Printf("%#v\n", data)
    fmt.Fprintf(conn, "hello client\n")
    conn.Close()
}
func main() {
    ln, err := net.Listen("tcp", ":8000")
	fmt.Printf("printServer run... port:8000")
    if err != nil {
        panic(err)
    }
    for {
        conn, err := ln.Accept()
        if err != nil {
            log.Println("get client connection error: ", err)
        }
        go handleConnection(conn)
    }
}