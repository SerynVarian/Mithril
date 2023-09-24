const std = @import("std");
const testing = std.testing;

const Mithril = struct {
    export fn print() i32 {
        std.debug.print("Hello World!", .{});
    }
};
