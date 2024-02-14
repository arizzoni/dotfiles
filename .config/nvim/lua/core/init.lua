-- [[ Settings ]]

-- Theming Settings
vim.g.transparent_enabled = true
vim.cmd.colorscheme("patched-lushwal")

-- Options
vim.opt.shortmess = "I" -- Disable short message (start screen)
vim.opt.scrolloff = 8
vim.opt.undofile = true
vim.opt.wrap = true
vim.opt.writebackup = true
vim.opt.hlsearch = true    -- Set highlight on search
vim.opt.number = true      -- Make relative line numbers default
vim.opt.relativenumber = true
vim.opt.breakindent = true -- Enable break indent
vim.opt.undofile = true    -- Save undo history
vim.opt.ignorecase = true  -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250   -- Decrease update time
vim.opt.timeout = true
vim.opt.timeoutlen = 300
vim.opt.completeopt = "menuone,noselect"                                    -- Set completeopt to have a better completion experience
vim.opt.termguicolors = true -- Make sure the terminal supports this
vim.opt.expandtab = true                                                    -- Expand tabs to spaces
vim.opt.modeline = true                                                     -- Enable modeline
vim.g.python3_host_prog = "/home/air/.local/share/python/neovim/bin/python" -- Python executable
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Neovide Settings
if vim.g.neovide then
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_background_color = "#000000"
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_cursor_animation_length = 0.125
  vim.g.neovide_cursor_trail_size = 0.5
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_vfx_mode = ""
end

-- [[ Configurations ]]
require("core.keymaps")
require("core.autocommands")
require("core.netrw")
