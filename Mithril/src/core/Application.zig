const std = @import("std");

pub const Mithril = struct {
    pub const Application = struct {
        // Member variables
        is_running: bool,
        counter: i64 = 0,

        // "Constructor" - Initializes an Application instance
        pub fn init() Application {
            return Application{ .is_running = true };
        }

        // "Destructor" - Cleans up resources
        pub fn deinit(self: *Application) void {
            _ = self;
            // Cleanup code here
        }

        // Run the application
        pub fn run(self: *Application) !void {
            while (self.is_running) {
                try self.update();
            }
        }

        // Update the application (called within the run loop)
        fn update(self: *Application) !void {
            // Your update code here
            self.counter += 1;
            std.debug.print("Running! Count: {}\n", .{self.counter});
            // For demonstration, setting is_running to false to terminate the loop
            //self.is_running = false;
        }
    };
};
