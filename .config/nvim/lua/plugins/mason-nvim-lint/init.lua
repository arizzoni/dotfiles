-- Autocompletion
return {
  "rshkarin/mason-nvim-lint",
  name = "mason-nvim-lint",
  dependencies = {
    "williamboman/mason.nvim", -- Snippet Engine
    "mfussenegger/nvim-lint",  -- Snippet Engine
  },
  opts = {
    ensure_installed = {
      "cmakelint",
      "cpplint",
      "jsonlint",
      "mypy",
      "proselint",
      "pylint",
      "selene",
      "shellcheck",
      "textlint",
      "yamllint",
    },
    automatic_installation = false,
    handlers = {},
  }
}
