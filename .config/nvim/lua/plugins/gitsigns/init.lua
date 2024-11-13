local util = require('util')

return {
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  url = "https://www.github.com/lewis6991/gitsigns.nvim",
  name = "gitsigns.nvim",
  event = "VeryLazy",
  opts = {
    attach_to_untracked = true,
    signs = {
      add = { text = '+' }, -- +
      change = { text = 'Δ' }, -- ~ Δ
      delete = { text = '−' }, --  − 
      topdelete = { text = '=' }, -- =
      changedelete = { text = '⍙' }, -- ≃ ⍙
      untracked = { text = 'ø' } --  ≀ ⋅ ∘ × ⋯ ⋮  ∅ ø
    },
    on_attach = function(bufnr)
      util.nmap(']c', require('gitsigns').prev_hunk, bufnr, 'Go to Previous Hunk')
      util.nmap(']c', require('gitsigns').next_hunk, bufnr, 'Go to Next Hunk' )
      util.nmap('<leader>ph', require('gitsigns').preview_hunk, bufnr, '[P]review [H]unk' )
    end,
  },
}
