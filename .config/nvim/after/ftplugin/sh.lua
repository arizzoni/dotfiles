local term = require("core.terminal")
local line = require("core.statusline")

local bufnr = vim.api.nvim_get_current_buf()

term.new()

vim.bo.textwidth = 80
vim.bo.softtabstop = 4
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

local root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1])

local bashls = vim.lsp.start({
	name = "bash-language-server",
	cmd = { "bash-language-server", "start" },
	filetypes = { "bash", "sh" },
	root_dir = root_dir,
	single_file_support = true,
	settings = {
		bashIde = {
			globPattern = vim.env.GLOB_PATTERN or "*@(.sh|.inc|.bash|.command)",
		},
	},
	docs = {
		description = { "BashLS" },
	},
})

if bashls then
	if not vim.lsp.buf_attach_client(bufnr, bashls) then
		vim.api.nvim_err_writeln("Bash: BashLS failed to attach to buffer")
	end
else
	vim.api.nvim_err_writeln("Bash: BashLS failed to initialize")
end
