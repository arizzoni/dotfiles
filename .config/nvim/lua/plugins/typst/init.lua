return {
  "kaarmu/typst.vim",
  ft = "typst",
  lazy = false,
  config = function()
    vim.g.typst_syntax_highlight = 1
    vim.g.typst_cmd = "typst"
    vim.g.typst_pdf_viewer = "zathura"
    vim.g.typst_conceal = 0
    vim.g.typst_conceal_math = 0
    vim.g.typst_conceal_emoji = 0
    vim.g.typst_auto_close_toc = 0
    vim.g.typst_auto_open_quickfix = 1
    vim.g.typst_embedded_languages = { 'python', 'julia', 'matlab' }

    vim.keymap.set("n", "<leader>tw", function()
      vim.cmd(":TypstWatch")
    end, { desc = "[T]ypst [W]atch file" })
  end,
}
