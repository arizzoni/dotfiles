local lspconfig = require("lspconfig")

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

lspconfig.lua_ls.setup({
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
				enable = false,
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
