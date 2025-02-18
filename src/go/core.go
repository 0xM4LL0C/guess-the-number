package main

import (
	"fmt"
	"strconv"

	"github.com/fatih/color"
)

type Game struct {
	SecredNumber int
	GameOver     bool
	Attempts     int
	MaxAttempts  int
}

func NewGame() *Game {
	return &Game{
		GameOver:    false,
		Attempts:    1,
		MaxAttempts: 10,
	}
}

func (g *Game) Start() {
	g.SecredNumber = RandRange(1, 100)

	color.Green("Добро пожаловать в игру \"Угадай число\"")
	color.Blue("Игра загадала число от 1 до 100. Попробуйте угадать ;)\n\n")
	color.Blue(fmt.Sprintf("У вас есть %v попыток\n", g.MaxAttempts))
}

func (g *Game) Guess(num int) {
	if g.SecredNumber == num {
		color.Green(fmt.Sprintf("Поздравляем! Вы угадали число %v с %v попытки", g.SecredNumber, g.Attempts))
		g.GameOver = true
	} else if g.SecredNumber > num {
		color.Red("Не угадали. Загаданное число больше")
	} else {
		color.Red("Не угадали. Загаданное число меньше")
	}
}

func (g *Game) Run() {
	g.Start()

	for !g.GameOver {
		if g.Attempts <= g.MaxAttempts {
			input := Input(fmt.Sprintf("[%v/%v] Введите ваше предположение: ", g.Attempts, g.MaxAttempts))
			num, err := strconv.Atoi(input)
			if err != nil {
				color.Red("Ошибка ввода. Введите число")
				continue
			}
			g.Guess(num)
			g.Attempts++
		} else {
			g.GameOver = true
			color.Red("Упс. Попытки закончились :(")
		}
	}

	color.Magenta("Разработчик: https://www.github.com/HamletSargsyan")
	color.Magenta("Репозиторий: https://www.github.com/HamletSargsyan/guess-the-number")
}
