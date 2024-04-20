-- Tagged To-Do comments
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signcolumn = false,
    keywords = {
      ERROR  = { icon = "󰅗", color = "error", alt = { "BUG", "FIX", "FIXME" } },
      WARN = { icon = "󰀧", color = "warning", alt = { "WARNING", "XXX" } },
      INFO = { icon = "󰏬", color = "info", alt = { "REF", "NOTE" } },
      HINT = { icon = "󰞋", color = "hint", alt = { "HELP" } },
      TODO = { icon = "󰄲", color = "default", alt = { "DONE" } },
      HACK = { icon = "󰅨", color = "default", alt = { "REFACTOR" } },
      PERF = { icon = "󰒔", color = "default", alt = { "OPT", "PERF", "OPTIMIZE", "PERFORMANCE" } },
      TEST = { icon = "󰅫", color = "default", alt = { "TESTING", "PASSED", "FAILED" } },
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

-- ERROR: 
-- WARN:
-- INFO:
-- HINT:
-- TODO:
-- HACK:
-- PERF:
-- TEST:
