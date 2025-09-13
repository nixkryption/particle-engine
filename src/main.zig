const std = @import("std");
const sdl3 = @cImport({
    @cInclude("SDL3/SDL.h");
});

const Window = struct {
    windowTitle: [*c]const u8,
    windowWidth: i32,
    windowHeight: i32,
    flags: c_uint,

    pub fn init(windowTitle: [*c]const u8, windowWidth: i32, windowHeight: i32, flags: c_uint) Window {
        return Window{
            .windowTitle = windowTitle,
            .windowWidth = windowWidth,
            .windowHeight = windowHeight,
            .flags = flags,
        };
    }
};

pub fn main() void {
    // Init a window
    // var sdl_window: ?*sdl3.SDL_Window = null;

    var done: bool = false;

    if (!sdl3.SDL_Init(sdl3.SDL_INIT_VIDEO)) {
        std.debug.print("SDL_Init failed: {s}\n", .{sdl3.SDL_GetError()});
    }

    const windowInfo = Window.init("Init window", 640, 480, sdl3.SDL_WINDOW_OPENGL);

    const window = sdl3.SDL_CreateWindow(windowInfo.windowTitle, windowInfo.windowWidth, windowInfo.windowHeight, windowInfo.flags);

    if (window == null) {
        std.debug.print("Could not create window: {s}\n", .{sdl3.SDL_GetError()});
    }

    while (!done) {
        var event: sdl3.SDL_Event = undefined;

        while (sdl3.SDL_PollEvent(&event)) {
            if (event.type == sdl3.SDL_EVENT_QUIT) {
                done = true;
            }
        }
    }

    sdl3.SDL_DestroyWindow(window);

    sdl3.SDL_Quit();
}
