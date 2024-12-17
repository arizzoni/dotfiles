local root_dir = vim.fs.dirname(
	vim.fs.find({
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"ruff.toml",
		".ruff.toml",
		".git",
		".venv",
	}, { upward = true })[1]
)

local ruff = vim.lsp.start({
	name = "ruff",
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_dir = root_dir,
	single_file_support = true,
	settings = {
		init_options = {
			settings = {
				logLevel = "debug",
				analyze = {
					preview = true,
				},
				format = {
					line_length = 88,
					indent_width = 4,
					indent_style = "spaces",
					quote_style = "double",
					preview = true,
				},
				lint = {
					select = {
						"E",
						"W", -- pycodestyle rules
						"C90", -- mccabe rules
						"I", -- isort rules
						"N", -- pep8-naming rules
						"D", -- pydocstyle rules
						"PL", -- pylint rules
						"NPY", -- numpy rules
						"RUF", -- ruff rules
					},
					preview = true,
					pydocstyle = {
						convention = "numpy",
					},
				},
			},
		},
	},
	docs = {
		description = { "Ruff LSP" }
	},
})

vim.lsp.buf_attach_client(0, ruff)

local pylsp = vim.lsp.start({
	name = "pylsp",
	cmd = { "pylsp" },
	filetypes = { "python" },
	root_dir = root_dir,
	single_file_support = true,
	settings = {
		pylsp = {
			filetypes = { "py", "pytxcode" },
			plugins = {
				autopep8 = {
					enabled = false,
				},
				flake8 = {
					enabled = false,
					executable = "flake8",
				},
				pylsp_isort = {
					enabled = false,
				},
				jedi_completion = {
					enabled = true,
					fuzzy = true,
				},
				mccabe = {
					enabled = false,
				},
				pylsp_mypy = {
					enabled = false,
				},
				pycodestyle = {
					enabled = false,
				},
				pydocstyle = {
					enabled = false,
					convention = "numpy",
				},
				pyflakes = {
					enabled = false,
				},
				pylint = {
					enabled = false,
					executable = "pylint",
				},
				rope_autoimport = {
					completions = { enabled = false },
					code_actions = { enabled = true },
				},
			},
		},
	},
	docs = {
		description = { "Pylsp" }
	},
})

vim.lsp.buf_attach_client(0, pylsp)

-- Disable Ruff hover capability in favor of Pylsp
local client = vim.lsp.get_client_by_id(args.data.client_id)
if client.name == "ruff" then
	-- Disable hover in favor of Py_lsp
	client.server_capabilities.hoverProvider = false
else
	return
end
