-- Neovim Options
vim.o.termguicolors = false
vim.opt.updatetime = 1 -- Decrease update time
vim.g.transparent_enabled = true
vim.opt.title = true
vim.opt.writebackup = true
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.timeout = true
vim.opt.timeoutlen = 10
vim.g.shell = "bash"
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/virtualenvs/neovim/bin/python") -- Python executable
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.typst_embedded_languages = {
	"python",
	"matlab",
	"lua",
	"bash",
}
vim.g.autochdir = true
vim.g.browsedir = "current"
vim.opt.completeopt = "menuone,noselect"
vim.opt.signcolumn = "yes"
-- vim.wo.breakindent = true
vim.g.cmdwinheight = 3
vim.o.cmdheight = 0
vim.o.colorcolumn = "+1"
vim.wo.concealcursor = "nvc"
vim.bo.copyindent = true
vim.wo.cursorcolumn = false
vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"
vim.g.equalalways = false
vim.o.expandtab = true
vim.g.fillchars = "lastline:."
vim.g.hlsearch = false
vim.g.ignorecase = true
vim.wo.linebreak = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.g.scroll = 0
vim.o.scrolloff = math.floor(0.34 * vim.o.lines)
vim.o.shiftround = true
vim.o.showbreak = "↵   "
vim.g.showcmd = false
vim.g.showtabline = 2
vim.g.sidescrolloff = math.floor(0.34 * vim.o.columns)
vim.g.smartcase = true
vim.g.splitbelow = true
vim.g.splitright = true
vim.g.timeoutlen = 10
vim.g.virtualedit = "block,insert"
