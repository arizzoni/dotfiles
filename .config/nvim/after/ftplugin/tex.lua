vim.g.digraph = true
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2
vim.bo.textwidth = 80

vim.b.tex_flavor = "latex"
vim.b.compiler = "tex"

-- if using latex, add each (sub(sub)) section to jumplist/marks
-- other jumplists for figures and tables?

-- tree-sitter text objects - start with vimtex stuff
-- specify a compile command
-- neovim built-in build tooling -> use both make and latexmk
-- compile-on-write, output -> temp buffer
-- errors -> quickfix
