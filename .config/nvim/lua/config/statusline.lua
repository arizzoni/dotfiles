-- line.lua
-- Neovim status line configuration

---@class StatusLine
---@field buf_str string Cached buffer number string
---@field win_str string Cached window number string
---@field tab_str string Cached tabpage number string
---@field path_str string Cached filepath string
---@field git_str string Cached Git buffer and Git status string
---@field venv_str string Cached Python virtual environment string
---@field diagnostric_str string Cached buffer diagnostics string
---@field mode_str string Cached editor mode string
---@field file_info_str string Cached file info string
---@field cursor_pos_string string Cached cursor position string
---@field bufnr number Cached buffer number
---@field winnr number Cached window number
---@field tabnr number Cached tabpage number
local StatusLine = {}

StatusLine.bufnr = nil
StatusLine.winnr = nil
StatusLine.tabnr = nil

---@return self
function StatusLine.new()
	local self = setmetatable({}, StatusLine)
	StatusLine.__index = StatusLine
	self.bufnr = vim.api.nvim_get_current_buf()
	self.winnr = vim.api.nvim_get_current_win()
	self.tabnr = vim.api.nvim_get_current_tabpage()
	return self
end

---@private
---@param errmsg string Error message
function StatusLine.error(errmsg)
	local errstr = table.concat({ "Status Line Error: ", errmsg })
	vim.api.nvim_err_writeln(errstr)
end

---@return string file_info_str File encoding, format, and type
function StatusLine:get_file_info()
	local opts = { buf = self.bufnr }
	return table.concat({
		"%#StatusLineFileInfo#",
		" ( ",
		vim.api.nvim_get_option_value("fileencoding", opts),
		" | ",
		vim.api.nvim_get_option_value("fileformat", opts),
		" | ",
		vim.api.nvim_get_option_value("filetype", opts),
		" ) ",
	})
end

---@return string cursor_pos_str Cursor vertical and horizontal position
function StatusLine:get_cursor_pos()
	return table.concat({ "%#StatusLineCursorPos#", " %l/%L:%c/", vim.bo.textwidth, " " }) or ""
end

---@return string tabstr Tab numbers
function StatusLine:get_tab_number()
	local tabs = vim.api.nvim_list_tabpages()
	local current_tab = vim.api.nvim_tabpage_get_number(0)
	local tabstr = ""

	for tabnr, _ in ipairs(tabs) do
		if tabnr == current_tab then
			tabstr = table.concat({ tabstr, "%#TabLineCurrentTab#", " ", tabnr, " " })
		else
			tabstr = table.concat({ tabstr, "%#TabLineTabs#", " ", tabnr, " " })
		end
	end
	return tabstr
end

---@return string buf_str Buffer numbers
function StatusLine:get_buf_number()
	local bufs = vim.api.nvim_list_bufs()
	local current_buf = vim.api.nvim_get_current_buf()
	local buf_str = ""

	for bufnr, _ in ipairs(bufs) do
		if vim.api.nvim_buf_is_valid(bufnr) and vim.fn.bufwinnr(bufnr) ~= -1 then
			if bufnr == current_buf then
				buf_str = table.concat({ buf_str, "%#TabLineCurrentBuf#", " ", bufnr, " " })
			else
				buf_str = table.concat({ buf_str, "%#TabLineBufs#", " ", bufnr, " " })
			end
		end
	end
	return buf_str
end

---@return string path_str Filepath
function StatusLine:get_filepath()
	local fullpath = vim.fn.expand("%:p")
	local pathlist = {}
	local longpath = false
	local modstring = ""

	for element in string.gmatch(fullpath, "([^/\\]+)") do
		table.insert(pathlist, element)
	end

	while #pathlist > 2 do
		table.remove(pathlist, 1)
		longpath = true
	end
	local pathstring = table.concat(pathlist, "/")

	if longpath then
		pathstring = ".../" .. pathstring
	end
	if vim.bo.modified then
		modstring = " [+]"
	end
	return table.concat({ "%#StatusLineFilepath#", " ", pathstring, "%#StatusLineModified#", modstring })
end

---@return string git_str Git branch and Git status
function StatusLine:get_git_branch()
	local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")
	if #branch ~= 1 then
		-- Not in a git repository
		return ""
	else
		local status = vim.fn.systemlist("git status --porcelain")
		local character = ""
		if #status ~= 0 then
			-- Repo has uncommitted changes
			character = " ~"
		end
		return table.concat({ "%#StatusLineVersionControl#", " (git:", branch[1], character, ")" })
	end
end

---@return string lsp_str LSP info
function StatusLine:get_lsp_info()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	local lsp_info = ""

	if #clients > 0 then
		local client = clients[1]
		local client_name = client.name or "Unknown LSP"
		lsp_info = table.concat({ "%#StatusLineLSP#", " ( ", client_name, " ) " })
	else
		lsp_info = table.concat({ "%#StatusLineLSP#", " ( ", "No LSP Client", " ) " })
	end

	return lsp_info
end

---@return string venv_str Python virtual environment
function StatusLine:get_virtual_env()
	local venv = vim.uv.os_getenv("VIRTUAL_ENV")
	if not venv then
		return ""
	else
		local venvpath = {}
		for element in string.gmatch(venv, "([^/\\]+)") do
			table.insert(venvpath, element)
		end
		while #venvpath > 1 do
			table.remove(venvpath, 1)
		end
		return table.concat({ "%#StatusLineVersionControl#", " (venv:", venvpath[1], ")" })
	end
end

---@return string diagnostic_str Buffer diagnostics
function StatusLine:get_diagnostics()
	local diagnostics = vim.diagnostic.get(0)

	local error_count = 0
	local warning_count = 0
	local info_count = 0
	local hint_count = 0

	for _, diagnostic in ipairs(diagnostics) do
		if diagnostic.severity == vim.diagnostic.severity.ERROR then
			error_count = error_count + 1
		elseif diagnostic.severity == vim.diagnostic.severity.WARN then
			warning_count = warning_count + 1
		elseif diagnostic.severity == vim.diagnostic.severity.INFO then
			info_count = info_count + 1
		elseif diagnostic.severity == vim.diagnostic.severity.HINT then
			hint_count = hint_count + 1
		end
	end

	local diagnostic_str = ""

	if error_count > 0 then
		diagnostic_str = table.concat({ diagnostic_str, "E:", error_count, " " })
	end
	if warning_count > 0 then
		diagnostic_str = table.concat({ diagnostic_str, "W:", warning_count, " " })
	end
	if info_count > 0 then
		diagnostic_str = table.concat({ diagnostic_str, "I:", info_count, " " })
	end
	if hint_count > 0 then
		diagnostic_str = table.concat({ diagnostic_str, "H:", hint_count, " " })
	end
	if #diagnostic_str ~= 0 then
		return table.concat({ "%#StatusLineDiagnostics#", " ", diagnostic_str })
	else
		return ""
	end
end

---@return string mode_str Editor mode
function StatusLine:get_mode()
	local mode = vim.api.nvim_get_mode()
	local modes = {
		n = "%#StatusLineNormal# NORMAL ",
		i = "%#StatusLineInsert# INSERT ",
		v = "%#StatusLineVisual# VISUAL",
		V = "%#StatusLineVisual# VISUAL-LINE ",
		-- For Ctrl-V mode:
		["\22"] = "%#StatusLineVisual# VISUAL-BLOCK ",
		c = "%#StatusLineCommand# COMMAND ",
		R = "%#StatusLineReplace# REPLACE ",
		s = "%#StatusLineSelect# SELECT ",
		S = "%#StatusLineSelect# SELECT-LINE ",
		t = "%#StatusLineTerminal# TERMINAL ",
	}
	return modes[mode.mode] or mode.mode
end

return StatusLine
