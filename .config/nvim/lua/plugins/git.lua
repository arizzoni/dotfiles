local util = require("util")

return {
  {
    "tpope/vim-fugitive",
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    url = "https://www.github.com/lewis6991/gitsigns.nvim",
    name = "gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      attach_to_untracked = true,
      signs = {
        add = { text = "+" }, -- +
        change = { text = "Δ" }, -- ~ Δ
        delete = { text = "−" }, --  −
        topdelete = { text = "=" }, -- =
        changedelete = { text = "⍙" }, -- ≃ ⍙
        untracked = { text = "ø" } --  ≀ ⋅ ∘ × ⋯ ⋮  ∅ ø
      },
      on_attach = function(bufnr)
        local gs = require('gitsigns')
        -- util.nmap("hn", gs.nav_hunk('next'), bufnr, "Go to Previous Hunk")
        -- util.nmap("hp", gs.nav_hunk('prev'), bufnr, "Go to Next Hunk")
        util.nmap("<leader>hv", gs.preview_hunk, bufnr, "Pre[V]iew [H]unk")
        util.nmap("<leader>tb", gs.toggle_current_line_blame, bufnr, "[T]oggle Line [B]lame")
        util.nmap("<leader>tB", function()
          gs.blame_line({full = true})
        end, bufnr, "[T]oggle Buffer [B]lame")
        util.nmap("<leader>hs", gs.stage_hunk, bufnr, "[S]tage [H]unk")
        util.nmap("<leader>hr", gs.reset_hunk, bufnr, "[R]eset [H]unk")
        util.vmap("<leader>hs", function()
          gs.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
        end, bufnr, "[S]tage [H]unk")
        util.vmap("<leader>hr", function()
          gs.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
        end, bufnr, "[R]eset [H]unk")
        util.nmap("<leader>hS", gs.stage_buffer, bufnr, "[S]tage [B]uffer")
        util.nmap("<leader>hu", gs.undo_stage_hunk, bufnr, "[U]ndo Stage [H]unk")
        util.nmap("<leader>hR", gs.reset_buffer, bufnr, "[R]eset Buffer")
        util.nmap("<leader>hd", gs.diffthis, bufnr, "[D]iff [H]unk")
        util.nmap("<leader>hD", gs.reset_buffer, bufnr, "[D]iff File")
        util.nmap("<leader>td", gs.toggle_deleted, bufnr, "[T]oggle [D]eleted")
      end,
    },
  },
}
