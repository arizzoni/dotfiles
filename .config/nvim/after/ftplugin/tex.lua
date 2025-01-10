local term = require("core.terminal")
local line = require("core.statusline")

local bufnr = vim.api.nvim_get_current_buf()

term.new()

vim.g.digraph = true
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }

vim.g.tex_flavor = "latex"

local root_dir = vim.fs.dirname(vim.fs.find({
	".git",
	".latexmkrc",
	".texlabroot",
	"texlabroot",
	"Tectonic.toml",
}, { upward = true })[1])

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
		description = { "Texlab" },
	},
})

if texlab then
	if not vim.lsp.buf_attach_client(bufnr, texlab) then
		vim.api.nvim_err_writeln("LaTeX: TeXLab failed to attach to buffer")
	end
else
	vim.api.nvim_err_writeln("LaTeX: TeXLab failed to initialize")
end

local ltex = vim.lsp.start({
	name = "LTeX LS",
	cmd = { "ltex-ls" },
	filetypes = { "tex" },
	root_dir = root_dir,
	single_file_support = true,
	settings = {},
	docs = {
		description = { "LTex LS" },
	},
})

if ltex then
	if not vim.lsp.buf_attach_client(bufnr, ltex) then
		vim.api.nvim_err_writeln("LaTeX: LTeX failed to attach to buffer")
	end
else
	vim.api.nvim_err_writeln("LaTeX: LTeX failed to initialize")
end
