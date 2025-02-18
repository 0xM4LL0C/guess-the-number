package main

import (
	"fmt"
	"math/rand/v2"
	"os"
)

func RandRange(min, max int) int {
	return rand.IntN(max-min) + min
}

func Error(exit_code int, message ...any) {
	fmt.Println(message...)
	os.Exit(exit_code)
}

func Input(prompt string) string {
	fmt.Print(prompt)
	var text string

    fmt.Scanln(&text)

	return text
}
