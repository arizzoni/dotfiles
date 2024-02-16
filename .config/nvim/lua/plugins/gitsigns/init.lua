return {
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  "lewis6991/gitsigns.nvim",
  name = "gitsigns.nvim",
  lazy = false,
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' }, -- 󰐖   +
      change = { text = '~' }, -- 󱗜  ~
      delete = { text = '–' }, -- 󰍵  –
      topdelete = { text = '=' }, -- 󰇽 󰦓  =
      changedelete = { text = '≃' }, --  󰾟 󰇕  ≃
      untracked = { text = '×' } -- 󰅗   ×
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to Previous Hunk' })
      vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to Next Hunk' })
      vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
        { buffer = bufnr, desc = '[P]review [H]unk' })
    end,
  },
}
