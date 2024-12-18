-- Neovim Options
vim.o.termguicolors = false
vim.o.title = true
vim.o.writebackup = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.timeout = true
vim.o.timeoutlen = 30
vim.g.shell = "bash"
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/virtualenvs/neovim/bin/python")
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.autochdir = true
vim.g.browsedir = "current"
vim.o.completeopt = "menuone,noselect"
vim.o.signcolumn = "yes"
vim.o.breakindent = true
vim.g.cmdwinheight = 3
vim.o.cmdheight = 0
vim.o.colorcolumn = "+1"
vim.o.concealcursor = "nvc"
vim.o.copyindent = true
vim.o.cursorcolumn = false
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.g.equalalways = false
vim.o.expandtab = true
vim.g.fillchars = "lastline:."
vim.g.hlsearch = false
vim.g.ignorecase = true
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftround = true
vim.o.showbreak = "↵   "
vim.g.showcmd = false
vim.g.showtabline = 2
vim.g.smartcase = true
vim.g.splitbelow = true
vim.g.splitright = true
vim.g.timeoutlen = 10
vim.g.virtualedit = "block,insert"

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinResized" }, {
  callback = function()
    vim.o.scrolloff = math.floor(0.34 * vim.o.winheight)
    vim.g.sidescrolloff = math.floor(0.34 * vim.o.winwidth)
  end
})
