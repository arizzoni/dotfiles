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
      "pylint",
      "selene",
      "shellcheck",
      "vale",
      "yamllint",
    },
    automatic_installation = false,
    handlers = {},
  },
  init = function()
    require('lint').linters_by_ft = {
      c = { 'cpplint', },
      cpp = { 'cpplint', },
      cmake = { 'cmakelint', },
      json = { 'jsonlint', },
      python = { 'mypy', 'pylint' },
      markdown = { 'vale', },
      lua = { 'selene', },
      bash = { 'shellcheck', },
      sh = { 'shellcheck', },
      yaml = { 'yamllint', },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
