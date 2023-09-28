const std = @import("std");
const builtin = @import("builtin");

/// Create Application executable
pub fn createApplication(
    b: *std.Build,
    name: []const u8,
    root_file: []const u8,
    target: std.zig.CrossTarget,
    optimize: std.builtin.Mode,
) *std.Build.CompileStep {

    // Initialize Mithril module
    const Mithril = b.createModule(.{
        .source_file = .{ .path = thisDir() ++ "/src/Mithril.zig" },
        .dependencies = &.{},
    });

    // Initialize executable
    const exe = b.addExecutable(.{
        .name = name,
        .root_source_file = .{ .path = "Mithril/src/Core/EntryPoint.zig" },
        .target = target,
        .optimize = optimize,
    });
    exe.addModule("Mithril", Mithril);
    exe.addModule("Application", b.createModule(.{
        .source_file = .{ .path = root_file },
        .dependencies = &.{
            .{ .name = "Mithril", .module = Mithril },
        },
    }));

    return exe;
}

inline fn thisDir() []const u8 {
    return comptime std.fs.path.dirname(@src().file) orelse ".";
}
