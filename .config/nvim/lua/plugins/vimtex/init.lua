return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_syntax_enabled = 0
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_format_enabled = true
    vim.g.vimtex_compiler_latexmk_engines = {
      _ = '-lualatex'
    }
    vim.g.vimtex_compiler_latexmk = {
      aux_dir = "aux",
      out_dir = ".",
      continuous = 0,
      options = {
        "-verbose",
        "-file-line-error",
        "-shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-f",
      },
    }
  end,
}
