--[[ Netrw File Manager ]]

-- Netrw Settings
vim.g.netrw_browse_split = 4
vim.g.netrw_fastbrowse = 0
vim.g.netrw_sort_by = "exten"
vim.g.netrw_mousemaps = 0
vim.g.netrw_winsize = 18
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 1
vim.g.netrw_sort_sequence = [[[\/]$,*]] -- Show directories first (sorting)
vim.g.netrw_sizestyle = "H"
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()
vim.g.netrw_hide = 0
vim.g.netrw_preview = 1
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_localmkdir = "mkdir -p"
vim.g.netrw_localrmdir = "rm -r"
vim.api.nvim_set_hl(0, "netrwMarkFile", { link = "Search" })

