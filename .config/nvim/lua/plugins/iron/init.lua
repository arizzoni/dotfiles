return {
  'Vigemus/iron.nvim',
  init = function()
    local iron = require("iron.core")
    iron.setup {
      config = {
        scratch_repl = true,
        scope = require("iron.scope").path_based,
        repl_definition = {
          sh = {
            command = { "bash" }
          },
          python = require("iron.fts.python").ipython,
          julia = require("iron.fts.julia").julia,
          lua = require("iron.fts.lua").lua,
        },
        repl_open_cmd = require("iron.view").split.botright("33%"),
        ignore_blank_lines = true,
        highlight = {
          reverse = true,
        },
      },
    }
    vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
    vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
    vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
    vim.keymap.set(
      "n",
      "<leader>sc",
      ":lua require('iron.core').run_motion('send_motion')<CR><Esc>"
    )
    vim.keymap.set(
      "v",
      "<leader>sc",
      ":lua require('iron.core').visual_send()<CR><Esc>"
    )
    vim.keymap.set( -- Send file in buffer
      "n",
      "<leader>sb",
      ":lua require('iron.core').send_file()<CR><Esc>"
    )
    vim.keymap.set(
      "n",
      "<leader>sl",
      ":lua require('iron.core').send_line()<CR><Esc>"
    )
    vim.keymap.set(
      "n",
      "<leader>su",
      ":lua require('iron.core').send_until_cursor()<CR><Esc>"
    )
    vim.keymap.set(
      "n",
      "<leader>sm",
      ":lua require('iron.core').send_mark()<CR><Esc>"
    )
    vim.keymap.set(
      "n",
      "<leader>mc",
      ":lua require('iron.core').run_motion('mark_motion')<CR><Esc>"
    )
    vim.keymap.set(
      "v",
      "<leader>mc",
      ":lua require('iron.core').mark_visual()<CR><Esc>"
    )
    vim.keymap.set(
      "n",
      "<leader>md",
      ":lua require('iron.marks').drop_last()<CR><Esc>"
    )
    vim.keymap.set(
      "n",
      "<leader>sq",
      ":lua require('iron.core').close_repl()<CR><Esc>"
    )
  end
}
