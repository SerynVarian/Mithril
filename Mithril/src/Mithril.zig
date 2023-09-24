const std = @import("std");
const testing = std.testing;

const Mithril = struct {
    export fn print() void {
        std.debug.print("Hello World!", .{});
    }
};
