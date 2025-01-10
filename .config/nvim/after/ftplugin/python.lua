local line = require("core.statusline")
local term = require("core.terminal")

local bufnr = vim.api.nvim_get_current_buf()

term.new()

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "virtualenvs/neovim/bin")
vim.bo.textwidth = 88

local root_dir = vim.fs.dirname(vim.fs.find({
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"ruff.toml",
	".ruff.toml",
	".git",
	".venv",
}, { upward = true })[1])

local ruff = vim.lsp.start({
	name = "ruff",
	cmd = { "/home/air/.local/share/virtualenvs/neovim/bin/ruff", "server" }, -- TODO get this working properly
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
					line_length = vim.bo.textwidth,
					indent_width = vim.bo.shiftwidth,
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
		description = { "Ruff LSP" },
	},
})

if ruff then
	if not vim.lsp.buf_attach_client(bufnr, ruff) then
		vim.api.nvim_err_writeln("Python: Ruff failed to attach to buffer")
	end
else
	vim.api.nvim_err_writeln("Python: Ruff failed to initialize")
end

local pylsp = vim.lsp.start({
	name = "pylsp",
	cmd = { vim.fn.expand("~/.local/share/virtualenvs/neovim/bin/pylsp") },
	filetypes = { "python" },
	root_dir = root_dir,
	single_file_support = true,
	settings = {
		pylsp = {
			filetypes = { "python" },
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
		description = { "Pylsp" },
	},
})

if pylsp then
	if not vim.lsp.buf_attach_client(bufnr, pylsp) then
		vim.api.nvim_err_writeln("Python: PyLSP failed to attach to buffer")
	end
else
	vim.api.nvim_err_writeln("Python: PyLSP failed to initialize")
end

-- Disable Ruff hover capability in favor of Pylsp
if ruff and pylsp then
	for _, client in ipairs(vim.lsp.get_clients({ id = ruff })) do
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.codeActionProvider = false
	end
	for _, client in ipairs(vim.lsp.get_clients({ id = pylsp })) do
		for _, capability in ipairs(client.server_capabilities) do
			if
				not capability == client.server_capabilities.hoverProvider
				or not capability == client.server_capabilities.codeActionProvider
			then
				capability = false
			end
		end
	end
end

-- Statusline
local statusline_group = vim.api.nvim_create_augroup("StatusLine", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	group = statusline_group,
	buffer = bufnr,
	callback = function()
		local statusline = line.new()
		function GetStatusLine()
			return table.concat({
				statusline:get_mode(),
				statusline:get_diagnostics(),
				statusline:get_lsp_info(),
				-- Horizontal fill
				"%#StatusLine#%=",
				statusline:get_file_info(),
				statusline:get_cursor_pos(),
			})
		end
		vim.wo.statusline = "%!v:lua.GetStatusLine()"
		local winbar = line.new()
		function GetWinBar()
			return table.concat({
				winbar:get_buf_number(),
				winbar:get_filepath(),
				winbar:get_git_branch(),
				winbar:get_virtual_env(),
				-- Horizontal fill
				"%#StatusLine#%=",
				winbar:get_tab_number(),
			})
		end
		vim.wo.winbar = "%!v:lua.GetWinBar()"
	end,
})
