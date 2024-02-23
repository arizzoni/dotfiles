-- Tagged To-Do comments
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signcolumn = false,
    keywords = {
      FIX  = { icon = "󰅗", color = "error", alt = { "BUG" } },
      TODO = { icon = "󰄲", color = "info", alt = { "DONE" } },
      HACK = { icon = "󰅨", color = "warning", alt = { "REFACTOR" } },
      WARN = { icon = "󰀧", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = "󰒔", color = "default", alt = { "OPT", "PERF", "OPTIMIZE", "PERFORMANCE" } },
      NOTE = { icon = "󰏬", color = "hint", alt = { "HINT", "REF", "INFO" } },
      TEST = { icon = "󰅫", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    colors = {
      error = { "DiagnosticError", "ErrorMsg" },
      warning = { "DiagnosticWarn", "WarningMsg" },
      info = { "DiagnosticInfo" },
      hint = { "DiagnosticHint" },
      default = { "Identifier" },
      test = { "Identifier" },
    },
    highlight = {
      multiline = true,
    },
  },
}
