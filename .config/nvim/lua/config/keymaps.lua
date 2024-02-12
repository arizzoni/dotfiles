-- [[ Basic Keymaps ]]

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

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Telescope Keymaps
local pickers = require("telescope.builtin")
local themes = require("telescope.themes")

vim.keymap.set("n", "<leader>?", function()
  pickers.oldfiles(themes.get_ivy {
    winblend = 10,
  })
end, { desc = "[?] Find recently opened files" })

vim.keymap.set("n", "<leader><space>", function()
  pickers.buffers(themes.get_ivy {
    winblend = 10,
  })
end, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>/", function()
  pickers.current_buffer_fuzzy_find(themes.get_ivy {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", function()
  pickers.git_files(themes.get_ivy {
    winblend = 10,
  })
end, { desc = "Search [G]it [F]iles" })

vim.keymap.set("n", "<leader>sf", function()
  pickers.find_files(themes.get_ivy {
    winblend = 10,
  })
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>sh", function()
  pickers.help_tags(themes.get_ivy {
    winblend = 10,
  })
end, { desc = "[S]earch [H]elp" })

vim.keymap.set("n", "<leader>sw", function()
  pickers.grep_string(themes.get_cursor {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[S]earch current [W]ord" })

vim.keymap.set("n", "<leader>sg", function()
  pickers.live_grep(themes.get_ivy {
    winblend = 10,
  })
end, { desc = "[S]earch by [G]rep" })

vim.keymap.set("n", "<leader>sd", function()
  pickers.diagnostics(themes.get_ivy {
    winblend = 10,
  })
end, { desc = "[S]earch [D]iagnostics" })
