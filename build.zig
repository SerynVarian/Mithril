const std = @import("std");
const Mithril = @import("./Mithril/build.zig");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Build option to specify the project
    const project = b.option([]const u8, "project", "Project to build") orelse "Sandbox";

    // Common build steps can go here

    if (std.mem.eql(u8, project, "Sandbox")) {
        buildSandbox(b, target, optimize);
    } else if (std.mem.eql(u8, project, "Test")) {
        buildTest(b, target, optimize);
    } else {
        @panic("Invalid project specified.");
    }
}

//zig build -Dproject=Sandbox run
fn buildSandbox(b: *Builder, target: std.zig.CrossTarget, optimize: std.builtin.OptimizeMode) void {
    const exe = Mithril.createApplication(
        b,
        "Sandbox",
        "./Sandbox/src/Sandbox.zig",
        target,
        optimize,
    );
    const install_cmd = b.addInstallArtifact(exe, .{});

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(&install_cmd.step);

    const run_step = b.step("run", "Run game");
    run_step.dependOn(&run_cmd.step);
}

//zig build -Dproject=Test run
fn buildTest(b: *Builder, target: std.zig.CrossTarget, optimize: std.builtin.OptimizeMode) void {
    const exe = Mithril.createApplication(
        b,
        "Test",
        "./Test/src/Test.zig",
        target,
        optimize,
    );
    const install_cmd = b.addInstallArtifact(exe, .{});

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(&install_cmd.step);

    const run_step = b.step("run", "Run game");
    run_step.dependOn(&run_cmd.step);
}
