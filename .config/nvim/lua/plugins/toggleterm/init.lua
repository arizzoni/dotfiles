return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.33
      end
    end,
    open_mapping = [[<c-\>]],
    -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
    -- on_open = fun(t: Terminal), -- function to run when the terminal opens
    -- on_close = fun(t: Terminal), -- function to run when the terminal closes
    -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
    -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
    -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
    hide_numbers = true,      -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    autochdir = true,         -- when neovim changes it current directory the terminal will change it's own when next it's opened
    shade_terminals = false,  -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    start_in_insert = true,
    insert_mappings = false,   -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
    direction = 'vertical',
    close_on_exit = true,     -- close the terminal window when the process exits
    -- Change the default shell. Can be a string or a function returning a string
    shell = vim.o.shell,
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
  },
  init = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    local xplr = Terminal:new({ cmd = "xplr", hidden = true, direction = "float" })
    local aerc = Terminal:new({ cmd = "aerc", hidden = true, direction = "float" })
    local ncmpcpp = Terminal:new({ cmd = "ncmpcpp", hidden = true, direction = "float" })
    local ipython = Terminal:new({ cmd = "ipython", hidden = true, direction = "vertical" })
    local julia = Terminal:new({ cmd = "julia", hidden = true, direction = "vertical" })
    local lua = Terminal:new({ cmd = "lua", hidden = true, direction = "vertical" })
    local bash = Terminal:new({ cmd = "bash", hidden = true, direction = "vertical" })

    function lazygit_toggle()
      lazygit:toggle()
    end

    function xplr_toggle()
      xplr:toggle()
    end

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
      elseif vim.bo.filetype == "bash" then
        bash:toggle()
      end
    end

    vim.api.nvim_set_keymap("n", "<leader>gt", "<cmd>lua lazygit_toggle()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>em", "<cmd>lua aerc_toggle()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>mp", "<cmd>lua ncmpcpp_toggle()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>xp", "<cmd>lua xplr_toggle()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", [[<C-Enter>]], "<cmd>lua repl_toggle()<CR>", { noremap = true, silent = true })

    local term_enter_group = vim.api.nvim_create_augroup("TerminalEnter", { clear = true })
    vim.api.nvim_create_autocmd({ "TermOpen" }, {
      pattern = { "*" },
      group = term_enter_group,
      callback = function()
        if vim.opt.buftype:get() == "terminal" then
          local opts = { buffer = 0 }
          vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
          vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
          vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
          vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
          vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
          vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)

          local trim_spaces = false
          vim.keymap.set("v", "<space>s", function()
            require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
          end)
          -- Replace with these for the other two options
          -- require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
          -- require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })

          -- For use as an operator map:
          -- Send motion to terminal
          vim.keymap.set("n", [[<leader><c-\>]], function()
            set_opfunc(function(motion_type)
              require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
            end)
            vim.api.nvim_feedkeys("g@", "n", false)
          end)
          -- Double the command to send line to terminal
          vim.keymap.set("n", [[<leader><c-\><c-\>]], function()
            set_opfunc(function(motion_type)
              require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
            end)
            vim.api.nvim_feedkeys("g@_", "n", false)
          end)
          -- Send whole file
          vim.keymap.set("n", [[<leader><leader><c-\>]], function()
            set_opfunc(function(motion_type)
              require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
            end)
            vim.api.nvim_feedkeys("ggg@G''", "n", false)
          end)
        end
      end
    })
  end
}
