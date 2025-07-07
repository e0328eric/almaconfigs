const std = @import("std");
const fs = std.fs;
const path = fs.path;
const mem = std.mem;

const alloc = std.heap.page_allocator;

pub fn main() !void {
    var i: usize = 0;
    try walker(fs.cwd(), ".", &i);
}

fn walker(dir_: fs.Dir, dir_path: []const u8, i: *usize) !void {
    var dir = try dir_.openDir(dir_path, .{ .iterate = true });
    defer dir.close();
    var iter = dir.iterate();

    while (try iter.next()) |entry| : (i.* += 1) {
        if (entry.kind == .directory) {
            if (entry.name[0] == '.') continue;
            try walker(dir, entry.name, i);
        }
        if (entry.kind != .file) continue;
        if (mem.eql(u8, path.extension(entry.name), ".png")) {
            const real_path = try dir.realpathAlloc(alloc, entry.name);
            defer alloc.free(real_path);
            std.debug.print("{}.: {s}\n", .{ i.*, real_path });
        }
    }
}
