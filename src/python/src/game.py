import random

from colorama import Fore, init


init(autoreset=True)


class Game:
    def __init__(self) -> None:
        self.secret_number: int
        self.game_over = False
        self.attempts = 0
        self.max_attempts = 10

    def start(self):
        self.secret_number = random.randint(1, 100)
        print(f'{Fore.GREEN}\n\nДобро пожаловать в игру "Угадай число"')
        print(f"{Fore.BLUE}Игра загадала число от 1 до 100. Попробуйте угадать ;)")
        print(f"{Fore.BLUE}У вас есть {self.max_attempts} попыток\n")

    def guess(self, number: int):
        if number == self.secret_number:
            print(
                f"{Fore.GREEN}Поздравляем! Вы угадали число {self.secret_number} с {self.attempts} попытки"
            )
            self.game_over = True
        elif number < self.secret_number:
            print(f"{Fore.RED}Не угадали. Загаданное число больше")
        else:
            print(f"{Fore.RED}Не угадали. Загаданное число меньше")

    def run(self):
        self.start()

        while not self.game_over:
            try:
                num = int(
                    input(
                        f"[{self.attempts}/{self.max_attempts}] Введите ваше предположение: "
                    )
                )
            except ValueError:
                print(f"{Fore.RED}Введите число")
                continue

            if self.attempts < self.max_attempts:
                self.guess(num)
                self.attempts += 1
            else:
                print(f"{Fore.RED}\nУпс. Попытки закончились :(")
                self.game_over = True

        print(f"{Fore.MAGENTA}\n\nРазработчик: https://www.github.com/0xM4LL0C")
        print(
            f"{Fore.MAGENTA}Репозиторий: https://www.github.com/0xM4LL0C/guess-the-number"
        )
