local utils = require("utils")


Game = {
    is_running = false,
    attempts = 0,
    max_attempts = 10,
}


function Game:new()
    self.secret_number = math.random(100)
end

---@param guess number
function Game:check_guess(guess)
    self.attempts = self.attempts + 1

    if guess == self.secret_number then
        print("Поздравляем! Вы угадали число " .. self.secret_number .. " с " .. self.attempts .. "попытки")
        self.is_running = false
    elseif guess <= self.secret_number then
        print("Не угадали. Загаданное число больше")
    else
        print("Не угадали. Загаданное число меньше")
    end

    if self.attempts >= self.max_attempts then
        print("\nУпс. Попытки закончились :(")
        self.is_running = false
    end
end

---@param input string
function Game:handle_input(input)
    if input == "help" then
        self:help()
    elseif input == "exit" then
        os.exit(0)
    else
        local guess = tonumber(input)
        if guess then
            self:check_guess(guess)
        else
            error("Пожалуйста, введите число или команду")
        end
    end
end

function Game:help()
    print("Команды:")
    print(" - `help` - помощь")
    print(" - `exit` - выход")
    print("Правила игры")
    print(" - Я загадываю число от 1 до 100.")
    print(" - У вас есть " .. tostring(self.max_attempts) .. "попыток, чтобы угадать число")
    print("После каждой попытки я скажу, больше или меньше ваше число загаданного")
end

function Game:run()
    print("\n\nДобро пожаловать в игру 'Угадай число'!")
    print("Я загадал число от 1 до 100. Попробуй угадать!\n\n")

    self.is_running = true

    while self.is_running do
        local input = utils.input(">>> ")
        input = input:gsub("%s+", "")


        if #input ~= 0 then
            local success, result = pcall(function() self:handle_input(input) end)

            if not success then
                print("Ошибка:", result)
            end
        end
    end

    print("\n\nРазработчик: https://www.github.com/HamletSargsyan")
    print("Репозиторий: https://www.github.com/HamletSargsyan/guess-the-number")
end

return Game;
