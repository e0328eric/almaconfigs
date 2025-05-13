const std = @import("std");
const fs = std.fs;
const process = std.process;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const argv = try process.argsAlloc(allocator);
    defer allocator.free(argv);

    if (argv.len != 2) {
        std.debug.print("ERROR: give an image path\n", .{});
        return error.InvalidArguments;
    }

    const img_path = argv[1];
    if (fs.path.isAbsolute(img_path)) {
        std.debug.print("ERROR: image path should be a relative\n", .{});
        return error.ImgPathIsAbsolute;
    }

    var buf = [_]u8{0} ** 1024;

    inline for (&.{ ".wallpaper_current", ".wallpaper_modified" }) |to_modify_path| {
        var to_modify = try fs.cwd().openFile(to_modify_path, .{ .mode = .write_only });
        defer to_modify.close();

        var image = try fs.cwd().openFile(img_path, .{});
        defer image.close();
        var read_len: usize = undefined;

        while (blk: {
            read_len = try image.read(&buf);
            break :blk read_len != 0;
        }) {
            _ = try to_modify.write(buf[0..read_len]);
        }
    }
}
