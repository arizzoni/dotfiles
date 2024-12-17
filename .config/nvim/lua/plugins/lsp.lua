return {
	{
		url = "http://www.github.com/mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				python = { "ruff" },
				lua = { "selene" },
			}

			local shellcheck = lint.linters.shellcheck
			shellcheck.args = { "-x" }

			vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		url = "http://www.github.com/jmbuhr/otter.nvim",
		ft = { "tex", "typst", "tex.python" },
		event = "VeryLazy",
		opts = {
			lsp = {
				hover = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
				},
				-- `:h events` that cause the diagnostics to update. Set to:
				-- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
				-- but more instant diagnostic updates
				diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
				root_dir = function(_, bufnr)
					return vim.fs.root(bufnr or 0, {
						".git",
						"_quarto.yml",
						"package.json",
					}) or vim.fn.getcwd(0)
				end,
			},
			buffers = {
				-- if set to true, the filetype of the otterbuffers will be set.
				-- otherwise only the autocommand of lspconfig that attaches
				-- the language server will be executed without setting the filetype
				set_filetype = true,
				-- write <path>.otter.<embedded language extension> files
				-- to disk on save of main buffer.
				-- usefule for some linters that require actual files
				-- otter files are deleted on quit or main buffer close
				write_to_disk = true,
			},
			strip_wrapping_quote_characters = { "'", '"', "`" },
			-- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
			-- When true, otter handles these cases fully. This is a (minor) performance hit
			handle_leading_whitespace = true,
		},
		config = function()
			local otter = require("otter")
			-- table of embedded languages to look for.
			-- default = nil, which will activate
			-- any embedded languages found
			local languages = { "lua", "python", "bash" }

			-- enable completion/diagnostics
			-- defaults are true
			local completion = true
			local diagnostics = true
			-- treesitter query to look for embedded languages
			-- uses injections if nil or not set
			local tsquery = nil

			otter.activate(languages, completion, diagnostics, tsquery)
		end,
	}
}
