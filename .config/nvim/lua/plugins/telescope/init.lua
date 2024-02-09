-- Fuzzy Finder (files, lsp, etc)
return {
  "nvim-telescope/telescope.nvim",
  name = "telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "tsakirist/telescope-lazy.nvim",
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
        },
      },
    },
  },
  init = function()
    require("telescope").load_extension("fzf")
  end
}
