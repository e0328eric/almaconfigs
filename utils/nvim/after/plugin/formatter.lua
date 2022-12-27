local formatter = require("formatter")
local format_kind = function(ext)
	return require("formatter.filetypes." .. ext)
end

formatter.setup({
	logging = true,
	log_level = vim.log.levels.WARN,

	filetype = {
		lua = format_kind("lua").stylua,
		rust = format_kind("rust").rustfmt,
		cpp = format_kind("cpp").clangformat,
		["*"] = format_kind("any").remove_trailing_whitespace,
	},
})

vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])
