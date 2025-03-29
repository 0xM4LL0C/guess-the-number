use std::{io, process};
use rand::Rng;

pub struct Game {
    pub secret_number: i32,
    pub attempts: i32,
    pub max_attempts: i32,
    pub game_over: bool,
}

impl Game {
    pub fn new() -> Self {
        Self {
            secret_number: rand::thread_rng().gen_range(1..100),
            attempts: 0,
            max_attempts: 10,
            game_over: false,
        }
    }

    fn start(&self) {
        println!("\n\nДобро пожаловать в игру \"Угадай число\"");
        println!("Игра загадала число от 1 до 100. Попробуйте угадать ;");
        println!("У вас есть {} попыток", self.max_attempts);
        println!("Чтобы получить помощь, напишите `help`.");
    }

    fn get_user_input(&self) -> String {
        let mut input = String::new();
        io::stdin().read_line(&mut input).expect("Ошибка при чтении ввода.");
        input.trim().to_string()
    }

    fn handle_user_input(&mut self, input: String) {
        match input.to_lowercase().as_str() {
            "help" => self.help_command(),
            "exit" => process::exit(0),
            _ => match input.parse::<i32>() {
                Ok(guess) => self.check_guess(guess),
                Err(_) => println!("Пожалуйста, введите число или команду."),
            },
        }
    }

    fn help_command(&self) {
        println!("Команды:");
        println!(" - Введите число от 1 до 100, чтобы попытаться угадать.");
        println!(" - Напишите `help`, чтобы увидеть это сообщение.");
        println!(" - Напишите `exit`, чтобы выйти из игры.");
        println!("Правила игры:");
        println!(" - Я загадываю число от 1 до 100.");
        println!(" - У вас есть {} попыток, чтобы угадать число.", self.max_attempts);
        println!(" - После каждой попытки я скажу, больше или меньше ваше число загаданного.");
    }
    

    fn check_guess(&mut self, guess: i32) {
        self.attempts += 1;

        if guess == self.secret_number {
            println!("Поздравляем! Вы угадали число {} с {} попытки", self.secret_number, self.attempts);
            self.game_over = true;
        } else if guess < self.secret_number {
            println!("Не угадали. Загаданное число больше");
        } else {
            println!("Не угадали. Загаданное число меньше");
        }

        if self.attempts >= self.max_attempts {
            println!("\nУпс. Попытки закончились :(");
            self.game_over = true;
        }
    }

    pub fn run(&mut self) {
        self.start();

        while !self.game_over {
            let input = self.get_user_input();
            self.handle_user_input(input);
        }

        println!("Разработчик: https://www.github.com/0xM4LL0C");
        println!("Репозиторий: https://www.github.com/0xM4LL0C/guess-the-number");
    }
}

