local komment = require("kommentary.config")

komment.configure_language("rust", {
	single_line_comment_string = "//",
	multi_line_comment_strings = { "/*", "*/" },
})

komment.configure_language("zig", {
	single_line_comment_string = "//",
	prefer_single_line_comments = true,
})

komment.configure_language("vesti", {
	single_line_comment_string = "%",
	multi_line_comment_strings = { "%*", "*%" },
})
