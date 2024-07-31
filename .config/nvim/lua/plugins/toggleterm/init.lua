return {
  'akinsho/toggleterm.nvim',
  version = "*",
  event = "VeryLazy",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.33
      end
    end,
    open_mapping = [[<c-enter>]],
    hide_numbers = true,
    autochdir = false,
    shade_terminals = false,
    start_in_insert = true,
    insert_mappings = false,
    terminal_mappings = true,
    persist_size = true,
    persist_mode = true,
    direction = 'vertical',
    close_on_exit = true,
    shell = vim.o.shell,
    auto_scroll = true,
  },
  init = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local aerc = Terminal:new({ cmd = "aerc", hidden = true, direction = "tab" })
    local ncmpcpp = Terminal:new({ cmd = "ncmpcpp", hidden = true, direction = "float" })
    local ipython = Terminal:new({ cmd = "ipython", hidden = true })
    local julia = Terminal:new({ cmd = "julia", hidden = true })
    local lua = Terminal:new({ cmd = "lua", hidden = true })

    function ncmpcpp_toggle()
      ncmpcpp:toggle()
    end

    function aerc_toggle()
      aerc:toggle()
    end

    function repl_toggle()
      if vim.bo.filetype == "python" then
        ipython:toggle()
      elseif vim.bo.filetype == "julia" then
        julia:toggle()
      elseif vim.bo.filetype == "lua" then
        lua:toggle()
      else
        if ipython:is_open() then
          ipython:toggle()
        elseif julia:is_open() then
          julia:toggle()
        elseif lua:is_open() then
          lua:toggle()
        end
      end
    end

    vim.api.nvim_set_keymap("n", "<leader>E", "<cmd>lua aerc_toggle()<CR>", { noremap = true, silent = true, desc = '[E]-mail' })
    vim.api.nvim_set_keymap("n", "<leader>mp", "<cmd>lua ncmpcpp_toggle()<CR>", { noremap = true, silent = true, desc = '[M]usic [P]layer' })
    vim.api.nvim_set_keymap("n", [[<C-\>]], "<cmd>lua repl_toggle()<CR>", { noremap = true, silent = true, desc = 'Toggle REPL' })
    vim.api.nvim_set_keymap("v", "<leader>sl", "<cmd>ToggleTermSendVisualLines<CR>", { noremap = true, silent = true, desc = '[S]end Selected [L]ines to REPL' })
    vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>ToggleTermSendCurrentLine<CR>", { noremap = true, silent = true, desc = '[S]end [C]urrent Line to REPL' })
    vim.api.nvim_set_keymap("v", "<leader>ss", "<cmd>ToggleTermSendVisualSelection<CR>", { noremap = true, silent = true, desc = '[S]end [S]election to REPL' })

    local term_enter_group = vim.api.nvim_create_augroup("TerminalEnter", { clear = true })
    vim.api.nvim_create_autocmd({ "TermOpen" }, {
      pattern = { "*" },
      group = term_enter_group,
      callback = function()
        if vim.opt.buftype:get() == "terminal" then
          local opts = { buffer = 0 }
          vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
          vim.keymap.set('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
          vim.keymap.set('t', '<C-w>w', [[<C-\><C-n><C-w>]], opts)
          vim.keymap.set('t', [[<C-\>]], "<cmd>lua repl_toggle()<CR>", opts)
        end
      end
    })
  end
}
