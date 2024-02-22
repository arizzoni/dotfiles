-- Git
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    "jemag/telescope-diff.nvim",
  },
  config = true,
  init = function()

    require("telescope").load_extension("diff")

    vim.keymap.set("n", "<leader>sC", function()
      require("telescope").extensions.diff.diff_files({ hidden = true })
    end, { desc = "Compare 2 files" })

    vim.keymap.set("n", "<leader>sc", function()
      require("telescope").extensions.diff.diff_current({ hidden = true })
    end, { desc = "Compare file with current" })

  end
}
