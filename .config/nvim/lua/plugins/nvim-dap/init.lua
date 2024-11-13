local util = require('util')

return {
  url = "https://www.github.com/mfussenegger/nvim-dap",
  name = "nvim-dap",
  event = "VeryLazy",
  -- opts = {},
  dependencies = {
    {
      url = "https://www.github.com/jay-babu/mason-nvim-dap.nvim",
      name = "mason-nvim-dap",
      event = "VeryLazy",
      dependencies = {
        {
          url = "https://www.github.com/williamboman/mason.nvim",
          event = "VeryLazy",
        },
      },
      opts = {
        ensure_installed = {
          "python",
          "bash",
        },
        automatic_installation = true,
        handlers = {},
      }
    },
  },
  config = function()
    local dap = require('dap')

    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
          type = 'server',
          port = assert(port, '`connect.port` is required for a python `attach` configuration'),
          host = host,
          options = {
            source_filetype = 'python',
          },
        })
      else
        cb({
          type = 'executable',
          command = '/home/air/.local/share/virtualenvs/neovim/bin/python', -- must be absolute path
          args = { '-m', 'debugpy.adapter' },
          options = {
            source_filetype = 'python',
          },
        })
      end
    end

    dap.configurations.python = {
      {
        -- The first three options are required by nvim-dap
        type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
        request = 'launch',
        name = "Launch file",
        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
          local virtual_env = os.getenv("VIRTUAL_ENV")
          if virtual_env ~= nil then
            return virtual_env .. "/bin/python"
          else
            return '/home/air/.local/share/virtualenvs/neovim/bin/python'
          end
        end,
      },
    }

    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    dap.configurations.c = {
      {
        name = "Launch",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = "Select and attach to process",
        type = "gdb",
        request = "attach",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
          local name = vim.fn.input('Executable name (filter): ')
          return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = '${workspaceFolder}'
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}'
      },
    }
    dap.adapters.bashdb = {
      type = 'executable',
      command = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/bash-debug-adapter',
      name = 'bashdb',
    }
    dap.configurations.sh = {
      {
        type = 'bashdb',
        request = 'launch',
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb',
        pathBashdbLib = vim.fn.stdpath("data") .. '/mason/packages/bash-debug-adapter/extension/bashdb_dir',
        trace = true,
        file = "${file}",
        program = "${file}",
        cwd = '${workspaceFolder}',
        pathCat = "cat",
        pathBash = "/bin/bash",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        args = {},
        env = {},
        terminalKind = "integrated",
      }
    }

    -- Keymaps

    util.nmap("<leader>db", function()
      dap.toggle_breakpoint()
    end, vim.api.nvim_get_current_buf(), "[D]ebugger toggle [b]reakpoint" )

    util.nmap("<leader>dd", function()
      dap.continue()
    end, vim.api.nvim_get_current_buf(), "[Dd]ebugger continue" )

    util.nmap("<leader>dt", function()
      dap.run_to_cursor()
    end, vim.api.nvim_get_current_buf(), "[D]ebugger Run [T]o Cursor" )

    util.nmap("<leader>dB", function()
      dap.clear_breakpoints()
    end, vim.api.nvim_get_current_buf(), "[D]ebugger Clear [B]reakpoints" )

    util.nmap("<leader>dO", function()
      dap.step_out()
    end, vim.api.nvim_get_current_buf(), "[D]ebugger step [O]ut" )

    util.nmap("<leader>do", function()
      dap.step_over()
    end, vim.api.nvim_get_current_buf(), "[D]ebugger step [o]ver" )

    util.nmap("<leader>di", function()
      dap.step_into()
    end, vim.api.nvim_get_current_buf(), "[D]ebugger step [i]nto" )

    util.nmap("<leader>ds", function()
      dap.step_back()
    end, vim.api.nvim_get_current_buf(), "[D]ebugger [s]tep back" )

    util.nmap("<leader>ds", function()
      dap.step_back()
    end, vim.api.nvim_get_current_buf(), "[D]ebugger [s]tep back" )
  end
}
