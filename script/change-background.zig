const std = @import("std");
const builtin = @import("builtin");
const win = @cImport({
    @cDefine("WIN32_LEAN_AND_MEAN", {});
    @cInclude("windows.h");
});
const unicode = std.unicode;

const DynLib = std.DynLib;

pub fn main() !void {
    if (builtin.os.tag != .windows) {
        @compileError("only windows can run this program");
    }

    const alloc = std.heap.page_allocator;

    var user32 = try DynLib.open("user32.dll");
    defer user32.close();

    const SystemParametersInfoW = user32.lookup(
        *const fn (c_uint, c_uint, ?*anyopaque, c_uint) callconv(.c) c_int,
        "SystemParametersInfoW",
    ) orelse return error.CannotGetFunction;

    const args = try std.process.argsAlloc(alloc);
    defer std.process.argsFree(alloc, args);

    if (args.len != 2) {
        std.debug.print("{s} <img-name>\n", .{args[0]});
        return error.InvalidArgument;
    }

    const img_path_u8 = try std.fs.cwd().realpathAlloc(alloc, args[1]);
    defer alloc.free(img_path_u8);

    const img_path = try unicode.utf8ToUtf16LeAllocZ(alloc, img_path_u8);
    defer alloc.free(img_path);

    if (SystemParametersInfoW(
        win.SPI_SETDESKWALLPAPER,
        0,
        @ptrCast(img_path),
        win.SPIF_UPDATEINIFILE | win.SPIF_SENDWININICHANGE,
    ) != win.TRUE) {
        return error.FailedToChageBackgroud;
    }

    std.debug.print("Background image changed into {s}\n", .{img_path_u8});
}
