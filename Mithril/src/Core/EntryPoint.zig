const std = @import("std");
const builtin = @import("builtin");
const App = @import("Application");
const Mithril = @import("../Mithril.zig");
const log = std.log;

// Validate exposed game api
comptime {
    if (!@hasDecl(App, "init") or
        !@hasDecl(App, "run") or
        !@hasDecl(App, "deinit"))
    {
        @compileError(
            \\You must provide following 3 public api in your game code:
            \\    pub fn init() !void
            \\    pub fn run() !void
            \\    pub fn deinit() !void
        );
    }
    switch (@typeInfo(@typeInfo(@TypeOf(App.init)).Fn.return_type.?)) {
        .ErrorUnion => |info| if (info.payload != void) {
            @compileError("`init` must return !void");
        },
        else => @compileError("`init` must return !void"),
    }
    switch (@typeInfo(@typeInfo(@TypeOf(App.run)).Fn.return_type.?)) {
        .ErrorUnion => |info| if (info.payload != void) {
            @compileError("`run` must return !void");
        },
        else => @compileError("`run` must return !void"),
    }
    switch (@typeInfo(@typeInfo(@TypeOf(App.deinit)).Fn.return_type.?)) {
        .Void => {},
        else => @compileError("`deinit` must return void"),
    }
}

pub fn main() !void {
    // Init game object
    App.init() catch |err| {
        log.err("Init game failed: {}", .{err});
        if (@errorReturnTrace()) |trace| {
            std.debug.dumpStackTrace(trace.*);
            std.os.abort();
        }
    };
    defer App.deinit();

    // Start game loop
    while (true) {
        try App.run();
    }
}
