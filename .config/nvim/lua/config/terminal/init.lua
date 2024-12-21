local term = require("config.terminal.terminal")
local util = require("util")

local bash = term.new()
util.nmap(
  [[<C-enter>]],
  bash.toggle,
  vim.api.nvim_get_current_buf(),
  "Toggle REPL"
)

util.nmap(
  "<leader>sl",
  bash.send_line,
  vim.api.nvim_get_current_buf(),
  "[S]end Selected [L]ine to REPL"
)

util.vmap(
  "<leader>sl",
  bash.send_lines,
  vim.api.nvim_get_current_buf(),
  "[S]end Selected [L]ines to REPL"
)

util.vmap(
  "<leader>ss",
  bash.send_selection,
  vim.api.nvim_get_current_buf(),
  "[S]end [S]election to REPL"
)

local term_enter_group = vim.api.nvim_create_augroup(
  "TerminalEnter",
  { clear = true }
)

vim.api.nvim_create_autocmd(
  { "TermOpen" },
  {
    pattern = { "*" },
    group = term_enter_group,
    callback = function()
      if vim.opt.buftype:get() == "terminal" then
        util.tmap(
          "<esc>",
          [[<C-\><C-n>]],
          vim.api.nvim_get_current_buf(),
          ""
        )

        util.tmap(
          "<C-w>h",
          [[<Cmd>wincmd h<CR>]],
          vim.api.nvim_get_current_buf(),
          ""
        )

        util.tmap(
          "<C-w>j",
          [[<Cmd>wincmd j<CR>]],
          vim.api.nvim_get_current_buf(),
          ""
        )

        util.tmap(
          "<C-w>k",
          [[<Cmd>wincmd k<CR>]],
          vim.api.nvim_get_current_buf(),
          ""
        )

        util.tmap(
          "<C-w>l",
          [[<Cmd>wincmd l<CR>]],
          vim.api.nvim_get_current_buf(),
          ""
        )

        util.tmap(
          "<C-w>w",
          [[<C-\><C-n><C-w>]],
          vim.api.nvim_get_current_buf(),
          ""
        )

        util.tmap(
          [[<C-enter>]],
          bash.toggle,
          vim.api.nvim_get_current_buf(),
          ""
        )
      end
    end
  })
