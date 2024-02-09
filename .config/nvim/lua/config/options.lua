-- [[ Settings ]]

-- Options
vim.opt.shortmess = "I" -- Disable short message (start screen)
vim.opt.scrolloff = 4
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
vim.opt.termguicolors = true                                                -- Make sure the terminal supports this
vim.opt.number = true                                                       -- Line numbers
vim.opt.expandtab = true                                                    -- Expand tabs to spaces
vim.opt.modeline = true                                                     -- Enable modeline
vim.g.python3_host_prog = "/home/air/.local/share/python/neovim/bin/python" -- Python executable
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- Netrw Settings
vim.g.netrw_browse_split = 4
vim.g.netrw_fastbrowse = 0
vim.g.netrw_sort_by = "exten"
vim.g.netrw_mousemaps = 0
vim.g.netrw_winsize = 18
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 1                                      -- Keep the current directory and the browsing directory synced.
vim.g.netrw_sort_sequence = [[[\/]$,*]]                      -- Show directories first (sorting)
vim.g.netrw_sizestyle = "H"                                  -- Human-readable files size
vim.g.netrw_liststyle = 3                                    -- tree style listing
vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()     -- Patterns for hiding files, e.g. node_modules
vim.g.netrw_hide = 0                                         -- show all files
vim.g.netrw_preview = 1                                      -- Preview files in a vertical split window
vim.g.netrw_localcopydircmd = "cp -r"                        -- Enable recursive copy of directories in *nix systems
vim.g.netrw_localmkdir = "mkdir -p"                          -- Enable recursive creation of directories in *nix systems
vim.g.netrw_localrmdir = "rm -r"                             -- Enable recursive removal of directories in *nix systems
vim.api.nvim_set_hl(0, "netrwMarkFile", { link = "Search" }) -- Highlight marked files in the same way search matches are

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

-- Theming Settings
vim.g.transparent_enabled = true
vim.cmd.colorscheme("patched-lushwal")

