--[[ Editor Settings ]]

vim.g.autochdir = true
vim.g.browsedir = "current"
vim.opt.completeopt = "menuone,noselect"         -- Set completeopt to have a better completion experience
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.wo.breakindent = true
vim.g.cmdwinheight = 3
vim.o.cmdheight = 1
vim.g.colorcolumn = "+1"
vim.wo.concealcursor = "nvc"
vim.bo.copyindent = true
vim.wo.cursorcolumn = false
vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"
vim.g.equalalways = false
vim.g.expandtab = true
vim.g.fillchars = "lastline:."
vim.g.hlsearch = false
vim.g.ignorecase = true
vim.wo.linebreak = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.scroll = 0
vim.g.scrolloff = 8
vim.g.shiftround = true
vim.g.shiftwidth = 2
vim.g.showbreak = "↵"
vim.g.showcmd = false
vim.g.showtabline = 2
vim.g.sidescrolloff = 8
vim.g.smartcase = true
vim.g.smartindent = true
vim.g.splitbelow = true
vim.g.splitright = true
vim.g.timeoutlen = 300
vim.g.undofile = true
vim.g.virtualedit = "block,insert"

-- Disable arrow keys
vim.keymap.set({ "n", "v", "i" }, "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "i" }, "<Right>", "<Nop>", { noremap = true, silent = true })

-- Prevent space in normal and visual modes
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remaps for dealing with word wrap
vim.keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
vim.keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
