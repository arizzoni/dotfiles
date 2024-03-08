-- Git
return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    "jemag/telescope-diff.nvim",
  },
  config = true,
  event = "VeryLazy",
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
