const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption();

    const exe = b.addExecutable("Mithril", "src/core/Entrypoint.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);

    exe.install();
}
