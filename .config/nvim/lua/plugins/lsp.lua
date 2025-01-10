return {
	{
		url = "http://www.github.com/mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				sh = { "shellcheck" },
				python = { "ruff" },
				lua = { "selene" },
				c = { "clangtidy" },
			}

			local shellcheck = lint.linters.shellcheck
			shellcheck.args = { "-x" }

			vim.api.nvim_create_autocmd({ "LspAttach", "TextChanged", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
	{
		url = "http://www.github.com/jmbuhr/otter.nvim",
		ft = { "tex" },
		enabled = false,
		event = "VeryLazy",
		opts = {
			lsp = {
				diagnostic_update_events = { "BufWritePost", "InsertLeave" },
				root_dir = function(_, bufnr)
					return vim.fs.root(bufnr or 0, {
						".git",
						".latexmkrc",
						"_quarto.yml",
						"package.json",
					}) or vim.fn.getcwd(0)
				end,
			},
			buffers = {
				set_filetype = true,
				write_to_disk = false,
			},
			strip_wrapping_quote_characters = { "'", '"', "`" },
			handle_leading_whitespace = true,
		},
		config = function()
			local otter = require("otter")
			local languages = { "lua", "python", "bash" }
			local completion = true
			local diagnostics = true
			local tsquery = nil

			otter.activate(languages, completion, diagnostics, tsquery)
		end,
	},
	{
		url = "https://www.github.com/stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff" },
				sh = { "shfmt" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = { timeout_ms = 500 },
		},
	},
}
