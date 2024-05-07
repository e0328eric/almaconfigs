const std = @import("std");
const fmt = std.fmt;
const fs = std.fs;
const process = std.process;

const DEFAULT_BRIGTNESS = 0.85;
const BACKLIGHT_RECORDER = .{
    .pathname = ".cache",
    .filename = "current_backlight.💡",
};

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    var args = process.args();
    _ = args.skip();

    const home_dir = try process.getEnvVarOwned(allocator, "HOME");
    defer allocator.free(home_dir);

    const backlight_path = try fs.path.join(allocator, &.{
        home_dir,
        BACKLIGHT_RECORDER.pathname,
        BACKLIGHT_RECORDER.filename,
    });
    defer allocator.free(backlight_path);

    var current_backlight_file = fs.openFileAbsolute(
        backlight_path,
        .{ .mode = .read_write },
    ) catch |err| switch (err) {
        fs.File.OpenError.FileNotFound => try fs.createFileAbsolute(backlight_path, .{ .read = true }),
        else => return err,
    };
    defer current_backlight_file.close();

    var file_buf = [_]u8{0} ** 10;
    if (try current_backlight_file.read(&file_buf) == 0) {
        _ = fmt.bufPrint(&file_buf, "{d:.5}", .{DEFAULT_BRIGTNESS}) catch unreachable;
    }
}
