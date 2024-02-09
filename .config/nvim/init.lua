-- /.config/nvim/init.lua

---@diagnostic disable-next-line undefined-global
local vim = vim

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable the builtin filetype plugin
-- vim.bo.filetype = true
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
require("config")

