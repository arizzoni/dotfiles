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
      -- "selene",
      "shellcheck",
      "vale",
      "yamllint",
    },
    automatic_installation = false,
    handlers = {},
  },
  init = function()
    require('lint').linters_by_ft = {
      bash = { 'shellcheck', },
      c = { 'cpplint', },
      cmake = { 'cmakelint', },
      cpp = { 'cpplint', },
      json = { 'jsonlint', },
      lua = { 'selene', },
      markdown = { 'vale', },
      python = { 'mypy', 'pylint' },
      sh = { 'shellcheck', },
      tex = { 'proselint' },
      yaml = { 'yamllint', },
    }

    vim.api.nvim_create_autocmd({ "LspAttach", "TextChanged" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
