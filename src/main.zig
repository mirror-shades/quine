const std = @import("std");
const printf = std.debug.print;

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const self: []const u8 =
        \\\\const std = @import("std");
        \\\\const printf = std.debug.print;
        \\\\
        \\\\pub fn main() void {
        \\\\    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        \\\\    const allocator = gpa.allocator();
        \\\\    defer _ = gpa.deinit();
        \\\\
        \\\\    const self: []const u8 = "q";
        \\\\
        \\\\    const args = std.process.argsAlloc(allocator) catch |err| {
        \\\\        printf("Error: {s}\n", .{@errorName(err)});
        \\\\        return;
        \\\\    };
        \\\\    defer std.process.argsFree(allocator, args);
        \\\\
        \\\\    if (args.len < 2) {
        \\\\        printf("Usage: {s} <file>\n", .{args[0]});
        \\\\        return;
        \\\\    }
        \\\\
        \\\\    const file = args[1];
        \\\\    var file_buffer: [256]u8 = undefined;
        \\\\    const file_contents = std.fs.cwd().readFile(file, file_buffer[0..]) catch |err| {
        \\\\        printf("Error: {s}\n", .{@errorName(err)});
        \\\\        return;
        \\\\    };
        \\\\    for (file_contents) |byte| {
        \\\\        switch (byte) {
        \\\\            'q' => {
        \\\\                var i: usize = 0;
        \\\\                while (i < self.len) : (i += 1) {
        \\\\                    if (self[i] == '"') {
        \\\\                        if ((self[i + 1] == 'q') and self[i + 2] == '"') {
        \\\\                            printf("\n", .{});
        \\\\                            for (self) |char| {
        \\\\                                if (char == '\\\\') {
        \\\\                                    printf("\\\\", .{});
        \\\\                                }
        \\\\                                printf("{c}", .{char});
        \\\\                            }
        \\\\                            i += 3;
        \\\\                            continue;
        \\\\                        }
        \\\\                    } else if (self[i] == '\\\\') {
        \\\\                        i += 1;
        \\\\                        continue;
        \\\\                    }
        \\\\                    printf("{c}", .{self[i]});
        \\\\                }
        \\\\            },
        \\\\            else => {},
        \\\\        }
        \\\\    }
        \\\\}
    ;

    const args = std.process.argsAlloc(allocator) catch |err| {
        printf("Error: {s}\n", .{@errorName(err)});
        return;
    };
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        printf("Usage: {s} <file>\n", .{args[0]});
        return;
    }

    const file = args[1];
    var file_buffer: [256]u8 = undefined;
    const file_contents = std.fs.cwd().readFile(file, file_buffer[0..]) catch |err| {
        printf("Error: {s}\n", .{@errorName(err)});
        return;
    };
    for (file_contents) |byte| {
        switch (byte) {
            'q' => {
                var i: usize = 0;
                while (i < self.len) : (i += 1) {
                    if (self[i] == '"') {
                        if ((self[i + 1] == 'q') and self[i + 2] == '"') {
                            printf("\n", .{});
                            for (self) |char| {
                                if (char == '\\') {
                                    printf("\\", .{});
                                }
                                printf("{c}", .{char});
                            }
                            i += 3;
                            continue;
                        }
                    } else if (self[i] == '\\') {
                        i += 1;
                        continue;
                    }
                    printf("{c}", .{self[i]});
                }
            },
            else => {},
        }
    }
}
