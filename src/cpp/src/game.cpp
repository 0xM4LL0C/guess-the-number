#include <iostream>
#include "game.h"
#include "termcolor/termcolor.hpp"
#include "GRand/grand.h"


void Game::start() {
    GRand rand;
    secretNumber = rand.i(100);
    std::cout << termcolor::green << "\n\nДобро пожаловать в игру \"Угадай число\"" << std::endl;
    std::cout << termcolor::blue << "Игра загадала число от 1 до 100. Попробуйте угадать ;)\n\n" << std::endl;
    std::cout << "У вас есть " << maxAttempts << " попыток" << termcolor::reset << std::endl;
}

void Game::guess(int number) {
    if (number == secretNumber) {
        std::cout << termcolor::green << "Поздравляем! Вы угадали число " << secretNumber << " с " << attempts << " попытки";
        gameOver = true;
    } else if (number < secretNumber) {
        std::cout << termcolor::red << "Не угадали. Загаданное число больше";
    } else {
        std::cout << termcolor::red << "Не угадали. Загаданное число меньше";
    }

    std::cout << termcolor::reset << std::endl;
}

int Game::run() {
    start();
    while (!gameOver) {
        int guessNumber;
        std::cout << "[" << attempts << "/" << maxAttempts << "] " << "Введите ваше предположение: ";
        std::cin >> guessNumber;
        if (attempts < maxAttempts) {
            guess(guessNumber);
            attempts++;
        } else {
            std::cout << termcolor::red << "Упс. Попытки закончились :(" << std::endl;
            return 1;
        }
    }

    std::cout << std::endl;
    std::cout << termcolor::magenta << "Разработчик: https://www.github.com/0xM4LL0C" << std::endl;
    std::cout << "Репозиторий: https://www.github.com/0xM4LL0C/guess-the-number" << termcolor::reset << std::endl;
    return 0;
}
