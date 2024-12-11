return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_syntax_enabled = 0
    vim.g.tex_flavor = "latex"
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_format_enabled = true
    vim.g.vimtex_compiler_latexmk_engines = { _ = "-lualatex" }
  end,
}
