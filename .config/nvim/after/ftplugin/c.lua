local lspconfig = require("lspconfig")

vim.bo.shiftwidth = 2
vim.bo.tabstop = vim.bo.shiftwidth
vim.bo.softtabstop = vim.bo.tabstop

lspconfig.clangd.setup()