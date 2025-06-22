const std = @import("std");
const fmt = std.fmt;
const root = @import("root");
const chameleon = @import("chameleon");

const stdin = std.io.getStdIn().reader();
const stdout = std.io.getStdOut().writer();

pub const Game = struct {
    secret_number: u8,
    game_over: bool = false,
    attempts: u8 = 0,
    max_attempts: u8 = 10,

    pub fn init() Game {
        var rng = std.Random.DefaultPrng.init(@intCast(std.time.nanoTimestamp()));
        const random = rng.random();
        const secret_number = random.intRangeAtMost(u8, 1, 100);

        return Game{
            .secret_number = secret_number,
        };
    }

    pub fn start(self: *Game) !void {
        try root.c.green().printOut("Добро пожаловать в игру \"Угадай число\"\n", .{});
        try root.c.blue().printOut("Игра загадала число от 1 до 100. Попробуйте угадать ;)\n\n", .{});
        try root.c.blue().printOut("У вас есть {} попыток\n", .{self.max_attempts});
    }

    pub fn guess(self: *Game, num: u8) !void {
        if (num == self.secret_number) {
            try root.c.green().printOut(
                "Поздравляем! Вы угадали число {} с {} попытки\n",
                .{ self.secret_number, self.attempts },
            );
            self.game_over = true;
        } else if (num < self.secret_number) {
            try root.c.red().printOut("Не угадали. Загаданное число больше\n", .{});
        } else {
            try root.c.red().printOut("Не угадали. Загаданное число меньше\n", .{});
        }
    }

    pub fn run(self: *Game) !void {
        try self.start();

        while (!self.game_over) {
            if (self.attempts <= self.max_attempts) {
                try fmt.format(
                    stdout,
                    "[{}/{}] Введите ваше предположение: ",
                    .{ self.attempts, self.max_attempts },
                );

                var buf: [3]u8 = undefined;
                const in = try stdin.readUntilDelimiter(&buf, '\n');
                const num = try fmt.parseInt(u8, in, 10);

                try self.guess(num);
                self.attempts += 1;
            } else {
                self.game_over = true;
                try root.c.red().printOut("Упс. Попытки закончились :(\n", .{});
            }
        }

        try root.c.hex(chameleon.HexColors.REBECCAPURPLE).printOut(
            "\nРазработчик: https://www.github.com/0xM4LL0C\n",
            .{},
        );
        try root.c.hex(chameleon.HexColors.REBECCAPURPLE).printOut(
            "Репозиторий: https://www.github.com/0xM4LL0C/guess-the-number\n",
            .{},
        );
    }
};
