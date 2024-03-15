--[[ Neovim init.lua ]]

-- No startup message (has to be first)
vim.opt.shortmess:append("I")

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable the builtin filetype plugin
vim.g.do_filetype_lua = true

-- Install package manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

-- Setup packages
require("lazy").setup("plugins")

-- Setup configuration
require("core")
