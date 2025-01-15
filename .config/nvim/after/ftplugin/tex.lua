local bufnr = vim.api.nvim_get_current_buf()
local lspconfig = require("lspconfig")

vim.g.digraph = true
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }
vim.g.tex_flavor = "latex"
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.textwidth = 80

local root_dir = vim.fs.dirname(vim.fs.find({
	".git",
	".latexmkrc",
	".texlabroot",
}, { upward = true })[1])

lspconfig.texlab.setup({
	name = "TeXLab",
	cmd = { "texlab" },
	filetypes = { "tex", "plaintex", "bib" },
	root_dir = root_dir,
	single_file_support = true,
	settings = {
		default_config = {
			cmd = { "texlab" },
			filetypes = { "tex", "plaintex", "bib" },
			root_dir = root_dir,
			single_file_support = true,
			settings = {
				texlab = {
					rootDirectory = root_dir,
					build = {
						executable = "latexmk",
						args = { "-lualatex", "-bibtex=1.5", "synctex=1", "--shell-escape" },
						onSave = true,
						forwardSearchAfter = true,
					},
					forwardSearch = {
						executable = "/bin/zathura",
						args = { "--synctex-forward", "%l:1:%f", "%p" },
					},
					diagnosticsDelay = 10,
					experimental = {
						followPackageLinks = true,
						mathEnvironments = { "equation", "equation*" },
						verbatimEnvironments = { "python", "pythonq", "pythonrepl", "luacode" },
					},
				},
			},
		},
	},
	docs = {
		description = { "TeXLab" },
	},
})
