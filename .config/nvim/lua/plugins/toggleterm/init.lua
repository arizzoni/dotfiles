local util = require("util")

return {
  url = "https://www.github.com/akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.382 -- 1/(Golden Ratio)
      end
    end,
    open_mapping = nil,
    hide_numbers = true,
    autochdir = false,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = false,
    terminal_mappings = true,
    persist_size = false,
    persist_mode = false,
    direction = "vertical",
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
  },
  init = function()
    local ipy_cmd = function()
      if os.getenv("VIRTUAL_ENV") ~= nil then
        return os.getenv("VIRTUAL_ENV") .. "/bin/ipython"
      elseif os.getenv("WORKON_HOME") ~= nil then
        return os.getenv("WORKON_HOME") .. "/ipython/bin/ipython"
      else
        return "ipython"
      end
    end

    local Terminal = require("toggleterm.terminal").Terminal
    local ipython = Terminal:new({ cmd = ipy_cmd(), hidden = true })
    local julia = Terminal:new({ cmd = "julia --banner=no", hidden = true })
    local bash = Terminal:new({ cmd = "bash", hidden = true })
    local matlab = Terminal:new({ cmd = "matlab -nodesktop", hidden = true })

    repl_toggle = function()
      if vim.bo.filetype == "python" then
        ipython:toggle()
      elseif vim.bo.filetype == "julia" then
        julia:toggle()
      elseif vim.bo.filetype == "matlab" then
        matlab:toggle()
      elseif ipython:is_open() then
        ipython:toggle()
      elseif julia:is_open() then
        julia:toggle()
      elseif matlab:is_open() then
        matlab:toggle()
      else
        bash:toggle()
      end
    end

    vim.api.nvim_set_keymap("n", [[<C-enter>]], "<cmd>lua repl_toggle()<CR>",
      { noremap = true, silent = true, desc = "Toggle REPL" })
    vim.api.nvim_set_keymap("v", "<leader>sl", "<cmd>ToggleTermSendVisualLines<CR>",
      { noremap = true, silent = true, desc = "[S]end Selected [L]ines to REPL" })
    vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>ToggleTermSendCurrentLine<CR>",
      { noremap = true, silent = true, desc = "[S]end [C]urrent Line to REPL" })
    vim.api.nvim_set_keymap("v", "<leader>ss", "<cmd>ToggleTermSendVisualSelection<CR>",
      { noremap = true, silent = true, desc = "[S]end [S]election to REPL" })

    local term_enter_group = vim.api.nvim_create_augroup("TerminalEnter", { clear = true })
    vim.api.nvim_create_autocmd({ "TermOpen" }, {
      pattern = { "*" },
      group = term_enter_group,
      callback = function()
        if vim.opt.buftype:get() == "terminal" then
          util.tmap("<esc>", [[<C-\><C-n>]], vim.api.nvim_get_current_buf(), "")
          util.tmap("<C-w>h", [[<Cmd>wincmd h<CR>]], vim.api.nvim_get_current_buf(), "")
          util.tmap("<C-w>j", [[<Cmd>wincmd j<CR>]], vim.api.nvim_get_current_buf(), "")
          util.tmap("<C-w>k", [[<Cmd>wincmd k<CR>]], vim.api.nvim_get_current_buf(), "")
          util.tmap("<C-w>l", [[<Cmd>wincmd l<CR>]], vim.api.nvim_get_current_buf(), "")
          util.tmap("<C-w>w", [[<C-\><C-n><C-w>]], vim.api.nvim_get_current_buf(), "")
          util.tmap([[<C-enter>]], "<cmd>lua repl_toggle()<CR>", vim.api.nvim_get_current_buf(), "")
        end
      end
    })

    -- require('util').augroup("toggleterm", function(autocmd)
    --   autocmd("WinResized", { callback = function()
    --     -- if vim.winwidth(0) > vim.winheight(0) then
    --       require('toggleterm').toggle_all()
    --       require('toggleterm').toggle_all()
    --     -- end
    --   end
    --   })
    -- end
    -- )
  end
}
