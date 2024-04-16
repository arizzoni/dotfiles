-- Autocompletion
return {
  "rshkarin/mason-nvim-lint",
  name = "mason-nvim-lint",
  dependencies = {
    "williamboman/mason.nvim", -- Snippet Engine
    "mfussenegger/nvim-lint",  -- Linter
  },
  opts = {
    ensure_installed = {
      "cmakelint",
      "cpplint",
      "jsonlint",
      "shellcheck",
      "yamllint",
      "flake8",
    },
    automatic_installation = true,
    handlers = {},
  },
  init = function()
    require('lint').linters_by_ft = {
      bash = { 'shellcheck', },
      c = { 'cpplint', },
      cmake = { 'cmakelint', },
      cpp = { 'cpplint', },
      json = { 'jsonlint', },
      python = { 'flake8', },
      sh = { 'shellcheck', },
      yaml = { 'yamllint', },
    }

    local shellcheck = require('lint').linters.shellcheck
    shellcheck.args = {
      "-x"
    }

    vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
