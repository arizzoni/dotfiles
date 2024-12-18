local util = require("util")

return {
  url = "https://www.github.com/mfussenegger/nvim-dap",
  name = "nvim-dap",
  ft = { "python", "sh" },
  event = "VeryLazy",
  config = function()
    local dap = require("dap")

    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
          type = "server",
          port = assert(port, "'connect.port' is required for a python 'attach' configuration"),
          host = host,
          options = {
            source_filetype = "python",
          },
        })
      else
        cb({
          type = "executable",
          command = "/home/air/.local/share/virtualenvs/neovim/bin/python", -- must be absolute path
          args = { "-m", "debugpy.adapter" },
          options = {
            source_filetype = "python",
          },
        })
      end
    end

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          local virtual_env = os.getenv("VIRTUAL_ENV")
          if virtual_env ~= nil then
            return virtual_env .. "/bin/python"
          else
            return "/home/air/.local/share/virtualenvs/neovim/bin/python"
          end
        end,
      },
    }

    dap.adapters.bashdb = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
      name = "bashdb",
    }

    dap.configurations.sh = {
      {
        type = "bashdb",
        request = "launch",
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
        pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
        trace = true,
        file = "${file}",
        program = "${file}",
        cwd = "${workspaceFolder}",
        pathCat = "cat",
        pathBash = "/bin/bash",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        args = {},
        env = {},
        terminalKind = "integrated",
      }
    }

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "sh" },
      callback = function()
        util.nmap(
          "<leader>db",
          dap.toggle_breakpoint,
          vim.api.nvim_get_current_buf(),
          "[D]ebugger toggle [b]reakpoint"
        )

        util.nmap(
          "<leader>dd",
          dap.continue,
          vim.api.nvim_get_current_buf(),
          "[Dd]ebugger Continue"
        )

        util.nmap(
          "<leader>dt",
          dap.run_to_cursor,
          vim.api.nvim_get_current_buf(),
          "[D]ebugger Run [T]o Cursor"
        )

        util.nmap(
          "<leader>dB",
          dap.clear_breakpoints,
          vim.api.nvim_get_current_buf(),
          "[D]ebugger Clear [B]reakpoints"
        )

        util.nmap(
          "<leader>dO",
          dap.step_out,
          vim.api.nvim_get_current_buf(),
          "[D]ebugger step [O]ut"
        )

        util.nmap(
          "<leader>do",
          dap.step_over,
          vim.api.nvim_get_current_buf(),
          "[D]ebugger step [o]ver"
        )

        util.nmap(
          "<leader>di",
          dap.step_into,
          vim.api.nvim_get_current_buf(),
          "[D]ebugger step [i]nto"
        )

        util.nmap(
          "<leader>ds",
          dap.step_back,
          vim.api.nvim_get_current_buf(),
          "[D]ebugger [s]tep back"
        )
      end
    })
  end
}
