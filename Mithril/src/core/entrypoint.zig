usingnamespace @import("Application.zig").Mithril;

pub const Mithril = struct {
    pub fn main() !void {
        var app = try Mithril.Application.init();
        defer app.deinit();
        try app.run();
    }
};
