
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
vim.keymap.set("n", "<leader>?", function()
  require("telescope.builtin").oldfiles(require("telescope.themes").get_ivy {
      winblend = 10,
  })
end, { desc = "[?] Find recently opened files" })

vim.keymap.set("n", "<leader><space>", function()
    require("telescope.builtin").buffers(require("telescope.themes").get_ivy {
      winblend = 10,
  })
end, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>gf", function()
  require("telescope.builtin").git_files(require("telescope.themes").get_ivy {
    winblend = 10,
  })
end, { desc = "Search [G]it [F]iles" })

vim.keymap.set("n", "<leader>sf", function()
  require("telescope.builtin").find_files(require("telescope.themes").get_ivy {
    winblend = 10,
  })
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>sh", function()
  require("telescope.builtin").help_tags(require("telescope.themes").get_ivy {
    winblend = 10,
  })
end, { desc = "[S]earch [H]elp" })

vim.keymap.set("n", "<leader>sw", function()
  require("telescope.builtin").grep_string(require("telescope.themes").get_cursor {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[S]earch current [W]ord" })

vim.keymap.set("n", "<leader>sg", function()
  require("telescope.builtin").live_grep(require("telescope.themes").get_ivy {
    winblend = 10,
  })
end, { desc = "[S]earch by [G]rep" })

vim.keymap.set("n", "<leader>sd", function()
  require("telescope.builtin").diagnostics(require("telescope.themes").get_ivy {
    winblend = 10,
  })
end, { desc = "[S]earch [D]iagnostics" })

