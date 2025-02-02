local lspconfig = require("lspconfig")

vim.g.digraph = true
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.textwidth = 120

lspconfig.tinymist.setup({
	settings = {
		formatterMode = "typstyle",
		formatterPrintWidth = vim.bo.textwidth,
		exportPdf = "onType",
		semanticTokens = "disable",
	},
})
