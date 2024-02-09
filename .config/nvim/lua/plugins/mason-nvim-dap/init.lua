-- Autocompletion
return {
  "jay-babu/mason-nvim-dap.nvim",
  name = "mason-nvim-dap",
  dependencies = {
    "williamboman/mason.nvim",         -- Snippet Engine
    "mfussenegger/nvim-dap",         -- Snippet Engine
  },
  opts = {
    ensure_installed = {
      "python",
      "stylua",
      "bash",
      "codelldb",
    },
    automatic_installation = true,
    handlers = {},
  }
}
