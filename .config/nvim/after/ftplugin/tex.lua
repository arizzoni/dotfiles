local lspconfig = require("lspconfig")

vim.g.digraph = true
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }
vim.g.tex_flavor = "latex"
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.textwidth = 80

lspconfig.texlab.setup({
	settings = {
		texlab = {
			build = {
				args = {},
				executable = "latexmk",
				onSave = true,
				forwardSearchAfter = true,
			},
			chktex = {
				onEdit = false,
				onOpenAndSave = false,
			},
			diagnosticsDelay = 10,
			formatterLineLength = 80,
			forwardSearch = {
				executable = "/bin/zathura",
				args = { "--synctex-forward", "%l:1:%f", "%p" },
			},
			latexFormatter = "latexindent",
			latexindent = {
				modifyLineBreaks = false,
			},
		},
	},
})
