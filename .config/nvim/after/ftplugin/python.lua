vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "virtualenvs/neovim/bin")

vim.bo.textwidth = 88

local root_dir = vim.fs.dirname(
  vim.fs.find({
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "ruff.toml",
    ".ruff.toml",
    ".git",
    ".venv",
  }, { upward = true })[1]
)

local ruff = vim.lsp.start({
  name = "ruff",
  cmd = { "/home/air/.local/share/virtualenvs/neovim/bin/ruff", "server" }, -- TODO get this working properly
  filetypes = { "python" },
  root_dir = root_dir,
  single_file_support = true,
  settings = {
    init_options = {
      settings = {
        logLevel = "debug",
        analyze = {
          preview = true,
        },
        format = {
          line_length = vim.bo.textwidth,
          indent_width = vim.bo.shiftwidth,
          indent_style = "spaces",
          quote_style = "double",
          preview = true,
        },
        lint = {
          select = {
            "E",
            "W",   -- pycodestyle rules
            "C90", -- mccabe rules
            "I",   -- isort rules
            "N",   -- pep8-naming rules
            "D",   -- pydocstyle rules
            "PL",  -- pylint rules
            "NPY", -- numpy rules
            "RUF", -- ruff rules
          },
          preview = true,
          pydocstyle = {
            convention = "numpy",
          },
        },
      },
    },
  },
  docs = {
    description = { "Ruff LSP" }
  },
})

vim.lsp.buf_attach_client(0, ruff)

local pylsp = vim.lsp.start({
  name = "pylsp",
  cmd = { vim.fn.expand("~/.local/share/virtualenvs/neovim/bin/pylsp") },
  filetypes = { "python" },
  root_dir = root_dir,
  single_file_support = true,
  settings = {
    pylsp = {
      filetypes = { "python" },
      plugins = {
        autopep8 = {
          enabled = false,
        },
        flake8 = {
          enabled = false,
          executable = "flake8",
        },
        pylsp_isort = {
          enabled = false,
        },
        jedi_completion = {
          enabled = true,
          fuzzy = true,
        },
        mccabe = {
          enabled = false,
        },
        pylsp_mypy = {
          enabled = false,
        },
        pycodestyle = {
          enabled = false,
        },
        pydocstyle = {
          enabled = false,
          convention = "numpy",
        },
        pyflakes = {
          enabled = false,
        },
        pylint = {
          enabled = false,
          executable = "pylint",
        },
        rope_autoimport = {
          completions = { enabled = false },
          code_actions = { enabled = true },
        },
      },
    },
  },
  docs = {
    description = { "Pylsp" }
  },
})

vim.lsp.buf_attach_client(0, pylsp)

-- Disable Ruff hover capability in favor of Pylsp
for _, client in ipairs(vim.lsp.get_active_clients()) do
  if client.name == "ruff" then
    -- Disable hover in favor of Py_lsp
    client.server_capabilities.hoverProvider = false
  end
end

local term = require("config.terminal")

local ipy_cmd = function()
  if os.getenv("VIRTUAL_ENV") ~= nil then
    return os.getenv("VIRTUAL_ENV") .. "/bin/ipython"
  elseif os.getenv("WORKON_HOME") ~= nil then
    return os.getenv("WORKON_HOME") .. "/ipython/bin/ipython"
  else
    return "ipython"
  end
end

local ipython = term.new(ipy_cmd)
