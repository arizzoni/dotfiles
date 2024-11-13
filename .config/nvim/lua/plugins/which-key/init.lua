-- Show pending keybinds
return {
  url = "https://www.github.com/folke/which-key.nvim",
  name = "which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.opt.timeout = true
    vim.opt.timeoutlen = 300
  end,
  opts = {
    preset = "modern",
    icons = {
      breadcrumb = "", -- symbol used in the command line area that shows your active key combo
      separator = ":", -- symbol used between a key and it's label
      group = "",      -- symbol prepended to a group,
      mappings = false,
    },
    win = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      no_overlap = true,
      border = "single", -- none, single, double, shadow
      padding = { 1, 0 }, -- extra window padding [top, right, bottom, left]
      title = true,
      title_pos = "center",
      zindex = 1000, -- positive value to position WhichKey above other floating windows.
    },
    layout = {
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 4,                    -- spacing between columns
      align = "center",               -- align columns left, center or right
    },
  },
}
