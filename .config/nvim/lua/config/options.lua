local uname = vim.uv.os_uname()
if uname.sysname == "Windows" then
  vim.opt.shell = "powershell.exe"
else
  vim.opt.shell = "/bin/bash"
end

vim.o.title = true
vim.o.writebackup = true
vim.o.undofile = true
vim.o.timeout = true
vim.o.timeoutlen = 30
vim.o.signcolumn = "yes"
vim.o.breakindent = true
vim.o.cmdheight = 0
vim.o.colorcolumn = "+1"
vim.o.concealcursor = "nvc"
vim.o.copyindent = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.expandtab = true
vim.o.linebreak = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftround = true
vim.o.showbreak = "↵   "

vim.g.python3_host_prog = vim.fn.expand("~/.local/share/virtualenvs/neovim/bin/python")
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.browsedir = "current"
vim.g.cmdwinheight = 3
vim.g.equalalways = false
vim.g.showcmd = false
vim.g.showtabline = 1
vim.g.splitbelow = true
vim.g.splitright = true
vim.g.virtualedit = "block,insert"
vim.g.smartcase = true

vim.api.nvim_create_autocmd({ "BufNew", "BufWinEnter", "WinResized" }, {
  callback = function()
    vim.g.scrolloff = math.floor(0.34 * vim.api.nvim_win_get_height(0))
    vim.g.sidescrolloff = math.floor(0.34 * vim.api.nvim_win_get_width(0))
  end
})
