--[[ core/init.lua ]]

--[[ Settings ]]
vim.g.shortmess = "IfilnxtToOF"
vim.opt.updatetime = 250 -- Decrease update time
vim.g.transparent_enabled = true
vim.cmd.colorscheme("patched-lushwal")
vim.opt.termguicolors = true -- Make sure the terminal supports this
vim.g.guicursor = "n-v-c-sm:block,i-ci-ve:ver25-Cursor,r-cr-o:hor20"

-- Backup and undo
vim.opt.writebackup = true
vim.opt.undofile = true -- Save undo history

-- Searching
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true

-- Input
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Language support
vim.g.shell = "bash"
vim.g.python3_host_prog = "/home/air/.local/share/python/neovim/bin/python" -- Python executable
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

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

-- [[ Core Modules ]]
require("core.editor")
require("core.terminal")
require("core.netrw")
require("core.treesitter")
