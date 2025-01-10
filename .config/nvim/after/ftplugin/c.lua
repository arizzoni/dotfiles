local term = require("core.terminal")

vim.bo.shiftwidth = 2
vim.bo.tabstop = vim.bo.shiftwidth
vim.bo.softtabstop = vim.bo.tabstop

local bufnr = vim.api.nvim_get_current_buf()

term.new()
local function switch_source_header(bufnr)
	local method_name = "textDocument/switchSourceHeader"
	bufnr = util.validate_bufnr(bufnr)
	local client = util.get_active_client_by_name(bufnr, "ccls")
	if not client then
		return vim.notify(
			("method %s is not supported by any servers active on the current buffer"):format(method_name)
		)
	end
	local params = vim.lsp.util.make_text_document_params(bufnr)
	client.request(method_name, params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			vim.notify("corresponding file cannot be determined")
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end, bufnr)
end
local root_dir = vim.fs.dirname(vim.fs.find({
	"compile_commands.json",
	"compile_flags.txt",
	"configure.ac", -- AutoTools
	".git",
}, { upward = true })[1]) or vim.fn.getcwd()

local ccls = vim.lsp.start({
	name = "ccls",
	cmd = { "ccls" }, -- TODO get this working properly
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	root_dir = root_dir,
	single_file_support = false,
	init_options = {
		index = {
			threads = 0,
		},
		cache = { directory = vim.env.XDG_CACHE_HOME .. "ccls/cache" },
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},
	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = { "utf-32" },
	},
	commands = {
		CclsSwitchSourceHeader = {
			function()
				switch_source_header(0)
			end,
			description = "Switch between source/header",
		},
	},
	docs = {
		description = { "CCLS" },
	},
})

if ccls then
	if not vim.lsp.buf_attach_client(bufnr, ccls) then
		vim.api.nvim_err_writeln("C: CCLS failed to attach to buffer")
	end
else
	vim.api.nvim_err_writeln("C: CCLS failed to initialize")
end
