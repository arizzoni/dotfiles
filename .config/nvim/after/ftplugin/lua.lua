local term = require("core.terminal")

local bufnr = vim.api.nvim_get_current_buf()

term.new()

vim.bo.textwidth = 120
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2

local root_dir = vim.fs.dirname(vim.fs.find({
	".luarc.json",
	".luarc.jsonc",
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
}, { upward = true })[1])

local luals = vim.lsp.start({
	name = "LuaLS",
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_dir = root_dir,
	single_file_support = true,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			hint = {
				enable = true,
			},
			workspace = {
				checkThirdParty = false,
				library = {
					[vim.env.VIMRUNTIME] = true,
				},
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
					tab_width = "2",
					quote_style = "double",
					max_line_length = "120",
				},
			},
			diagnostics = {
				globals = { "vim" },
				neededFileStatus = "Any",
			},
			telemetry = { enable = false },
		},
		log_level = vim.lsp.protocol.MessageType.Info,
	},
	docs = {
		description = { "LuaLS" },
	},
})

if luals then
	if not vim.lsp.buf_attach_client(bufnr, luals) then
		vim.api.nvim_err_writeln("Lua: LuaLS failed to attach to buffer")
	end
else
	vim.api.nvim_err_writeln("Lua: LuaLS failed to initialize")
end
