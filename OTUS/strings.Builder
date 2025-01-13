/*
Домашнее задание

# Распаковка строки

Создать Go функцию, осуществляющую примитивную распаковку строки, содержащую повторяющиеся символы / руны, например:

* "a4bc2d5e" => "aaaabccddddde"

* "abcd" => "abcd"

* "45" => "" (некорректная строка)

Дополнительное задание: поддержка escape - последовательности

* `qwe\4\5` => `qwe45` (*)

* `qwe\45` => `qwe44444` (*)

* `qwe\\5` => `qwe\\\\\` (*)
*/
package unpack

import (
	"strconv"
	"strings"
	"unicode"
)

// Unpack string. "a4bc2d5e" => "aaaabccddddde" and `qwe\4\5` => `qwe45`
func Unpack(str string) string {
	var builder strings.Builder
	reader := strings.NewReader(str)
	prevChar, _, _ := reader.ReadRune()
	if unicode.IsDigit(prevChar) {
		return ""
	}
	for {
		currChar, _, readErr := reader.ReadRune()
		if readErr != nil {
			builder.WriteRune(prevChar)
			break
		}

		digit, atoiErr := strconv.Atoi(string(currChar))
		if atoiErr == nil {
			builder.WriteString(strings.Repeat(string(prevChar), digit))
		} else {
			builder.WriteRune(prevChar)
		}

		if currChar == '\\' || atoiErr == nil {
			prevChar, _, readErr = reader.ReadRune()
			if readErr != nil {
				break
			}
		} else {
			prevChar = currChar
		}
	}
	return builder.String()
}
