import random
import strutils, strformat
import nimcolor

type
  Game* = ref object of RootObj
    secret_number: int
    game_over: bool = false
    attempts: int = 0
    max_attempts: int = 10

proc start*(self: Game) =
  randomize()
  self.secret_number = rand(1..100)

  echo "&gold;Добро пожаловать в игру \"Угадай число\"".color
  echo "&blue;Игра загадала число от 1 до 100. Попробуйте угадать ;)\n\n".color
  echo fmt("&blue;У вас есть {self.max_attempts} попыток\n").color

proc guess*(self: Game, num: int) =
  if self.secret_number == num:
    echo fmt("&green;Поздравляем! Вы угадали число {self.secret_number} с {self.attempts} попытки").color
    self.game_over = true
  elif num < self.secret_number:
    echo "&red;Не угадали. Загаданное число больше.".color
  else:
    echo "&red;Не угадали. Загаданное число меньше".color

proc run*(self: Game) =
  self.start()


  while not self.game_over:
    if self.attempts <= self.max_attempts:
      stdout.write(fmt("[{self.attempts}/{self.max_attempts}] Введите ваше предположение: "))
      var num: int
      try:
        num = parseInt(readLine(stdin))
      except ValueError:
        echo "&red;Введите число".color
        continue
      self.guess(num)
      inc(self.attempts)
    else:
      self.game_over = true
      echo "&red;Упс. Попытки закончились :(".color

  echo "\n&purple;Разработчик: https://www.github.com/HamletSargsyan".color
  echo "&purple;Репозиторий: https://www.github.com/HamletSargsyan/guess-the-number".color