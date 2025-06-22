const std = @import("std");
const core = @import("core.zig");

const Chameleon = @import("chameleon");

pub var c: Chameleon.RuntimeChameleon = undefined;

pub fn main() !void {
    c = Chameleon.initRuntime(.{ .allocator = std.heap.page_allocator });
    defer c.deinit();

    var allocator = std.heap.page_allocator; // Example allocator
    var game: *core.Game = try allocator.create(core.Game);
    game.* = core.Game.init();
    try game.run();
    defer allocator.destroy(game);
}
