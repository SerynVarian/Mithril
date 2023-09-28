const std = @import("std");
const Mithril = @import("Mithril");

var count: i64 = 0;

pub fn init() !void {
    // your init code
    count = 0;
}

pub fn run() !void {
    // your game state updating code
    std.debug.print("Test Run Instance: {}\n", .{count});
    count += 1;
}

pub fn deinit() void {
    // your deinit code

}
