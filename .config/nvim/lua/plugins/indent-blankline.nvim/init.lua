return {
  "lukas-reineke/indent-blankline.nvim",
  name = "indent-blankline.nvim",
  main = "ibl",
  lazy = false,
  opts = {
    debounce = 100,
    indent = { char = { " ", "░", "▒", "▓", "█" } },
    whitespace = { remove_blankline_trail = true },
    scope = {
      show_start = true,
      show_end = false,
      show_exact_scope = true,
      highlight = { "Function" },
    },
  }
}
