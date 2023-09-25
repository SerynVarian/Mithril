const Mithril = @import("Mithril");

// Function to create a new Sandbox application.
pub fn createSandboxApp() !Mithril.Application {
    // Initialize your sandbox application here
    return Mithril.Application.init();
}

pub const SandboxApp = struct {
    pub fn init() void {
        Mithril.Application.create_application_fn = createSandboxApp;
    }
};
