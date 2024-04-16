-- Set lualine as statusline
return {
  'folke/zen-mode.nvim',
  event = "VeryLazy",
  opts = {
    window = {
      backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
      width = 0.67, -- width of the Zen window
      height = 1, -- height of the Zen window
      options = {
        signcolumn = "no", -- disable signcolumn
        number = false, -- disable number column
        relativenumber = false, -- disable relative numbers
        cursorline = false, -- disable cursorline
        cursorcolumn = false, -- disable cursor column
        foldcolumn = "0", -- disable fold column
        list = false, -- disable whitespace characters
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false, -- disables the ruler text in the cmd line area
        showcmd = false, -- disables the command in the last line of the screen
        laststatus = 0,             -- turn off the statusline in zen mode
      },
      twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = false },   -- disables the tmux statusline
    },
    on_open = function() -- you can also pass the window to the function like: function(win)
      vim.cmd(":IBLDisable")
    end,
    on_close = function()
      vim.cmd(":IBLToggle")
    end,
  },
  init = function()
      vim.keymap.set("n", "<leader>zm", function()
        require("zen-mode").toggle()
      end, { desc = "[Z]en [M]ode" })
    end
}
