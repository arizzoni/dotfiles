-- Neovide Settings
vim.o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:Cursor/lCursor"
vim.o.guifont = "monospace:h16"
vim.o.termguicolors = true

vim.g.neovide_theme = "auto"
vim.g.neovide_opacity = 0.9
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_position_animation_length = 0.125
vim.g.neovide_scroll_animation_length = 0.125
vim.g.neovide_cursor_animation_length = 0.125
vim.g.neovide_cursor_unfocused_outline_width = 0.125
vim.g.neovide_cursor_smooth_blink = true
vim.g.neovide_cursor_trail_size = 0.5
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_padding_top = 4
vim.g.neovide_padding_bottom = 4
vim.g.neovide_padding_right = 4
vim.g.neovide_padding_left = 4

vim.api.nvim_set_keymap("v", "<sc-c>", '"+y', { noremap = true })
vim.api.nvim_set_keymap("n", "<sc-v>", 'l"+P', { noremap = true })
vim.api.nvim_set_keymap("v", "<sc-v>", '"+P', { noremap = true })
vim.api.nvim_set_keymap("c", "<sc-v>", '<C-o>l<C-o>"+<C-o>P<C-o>l', { noremap = true })
vim.api.nvim_set_keymap("i", "<sc-v>", '<ESC>l"+Pli', { noremap = true })
vim.api.nvim_set_keymap("t", "<sc-v>", '<C-\\><C-n>"+Pi', { noremap = true })
