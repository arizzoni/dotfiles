local term = require("core.terminal")

vim.bo.shiftwidth = 2
vim.bo.tabstop = vim.bo.shiftwidth
vim.bo.softtabstop = vim.bo.tabstop

local bufnr = vim.api.nvim_get_current_buf()

term.new()

local root_dir = vim.fs.dirname(vim.fs.find({
	"compile_commands.json",
	"compile_flags.txt",
	"configure.ac", -- AutoTools
	".git",
}, { upward = true })[1])

local ccls = vim.lsp.start({
	name = "ccls",
	cmd = { "ccls" }, -- TODO get this working properly
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_dir = root_dir,
	single_file_support = false,
	init_options = {
		index = {
			threads = 0,
		},
		cache = { directory = ".ccls-cache" },
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},

	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = { "utf-32" },
	},
	docs = {
		description = { "CCLS" },
	},
})

if ccls then
	if not vim.lsp.buf_attach_client(bufnr, ccls) then
		vim.api.nvim_err_writeln("C: CCLS failed to attach to buffer")
	end
else
	vim.api.nvim_err_writeln("C: CCLS failed to initialize")
end
