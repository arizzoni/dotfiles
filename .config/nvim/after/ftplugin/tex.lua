vim.g.digraph = true
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }

vim.g.tex_flavor = "latex"

local root_dir = vim.fs.dirname(
  vim.fs.find({
    ".git",
    ".latexmkrc",
    ".texlabroot",
    "texlabroot",
    "Tectonic.toml",
  }, { upward = true })[1]
)

local texlab = vim.lsp.start({
  name = "texlab",
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_dir = root_dir,
  single_file_support = true,
  settings = {
    default_config = {
      cmd = { "texlab" },
      filetypes = { "tex", "plaintex", "bib" },
      root_dir = root_dir,
      single_file_support = true,
      settings = {
        texlab = {
          rootDirectory = nil,
          build = {
            executable = "latexmk",
            args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
            onSave = false,
            forwardSearchAfter = false,
          },
          forwardSearch = {
            executable = nil,
            args = {},
          },
          chktex = {
            onOpenAndSave = true,
            onEdit = true,
          },
          diagnosticsDelay = 10,
          latexFormatter = "latexindent",
          latexindent = {
            ["local"] = nil, -- local is a reserved keyword
            modifyLineBreaks = true,
          },
          bibtexFormatter = "texlab",
          formatterLineLength = 80,
        },
      },
    },
  },
  docs = {
    description = { "Texlab" }
  },
})
vim.lsp.buf_attach_client(0, texlab)

local ltex = vim.lsp.start({
  name = "LTeX LS",
  cmd = { "ltex-ls" },
  filetypes = { "tex" },
  root_dir = root_dir,
  single_file_support = true,
  settings = {},
  docs = {
    description = { "LTex LS" }
  },
})

vim.lsp.buf_attach_client(0, ltex)
