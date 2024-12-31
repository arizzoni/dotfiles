-- statusline.lua
-- Neovim status line configuration

-- TODO:
-- Figure out how to render without global variables

local util = require("util")

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

--- Constructor for the StatusLine class
---@return self
function StatusLine.new()
	local self = setmetatable({}, StatusLine)
	StatusLine.__index = StatusLine
	vim.o.showmode = false
	self.bufnr = vim.api.nvim_get_current_buf()
	self.winnr = vim.api.nvim_get_current_win()
	self.tabnr = vim.api.nvim_get_current_tabpage()
	return self
end

--- Local method to handle errors
---@private
---@param errmsg string
function StatusLine.error(errmsg)
	local errstr = table.concat({ "Status Line Error: ", errmsg })
	vim.api.nvim_err_writeln(errstr)
end

--- File encoding, format, and type
---@return string file_info_str
function StatusLine:get_file_info()
	local opts = { buf = self.bufnr }
	return table.concat({
		"%#StatusLineFileInfo#",
		"(",
		vim.api.nvim_get_option_value("fileencoding", opts),
		"|",
		vim.api.nvim_get_option_value("fileformat", opts),
		"|",
		vim.api.nvim_get_option_value("filetype", opts),
		") ",
	})
end

--- Cursor vertical and horizontal position
---@return string cursor_pos_str
function StatusLine:get_cursor_pos()
	return table.concat({ "%#StatusLineCursorPos#", " %l/%L:%c/", vim.bo[self.bufnr].textwidth, " " }) or ""
end

--- Tab numbers
---@return string tabstr
function StatusLine:get_tab_number()
	local tabs = vim.api.nvim_list_tabpages()
	local tabstr = ""
	for _, tabnr in ipairs(tabs) do
		if tabnr == self.tabnr then
			tabstr = table.concat({ tabstr, "%#TabLineCurrentTab#", " ", tabnr, " " })
		else
			tabstr = table.concat({ tabstr, "%#TabLineTabs#", " ", tabnr, " " })
		end
	end
	return tabstr
end

--- Buffer numbers
---@return string buf_str
function StatusLine:get_buf_number()
	local bufs = vim.api.nvim_list_bufs()
	local buf_str = ""
	for _, bufnr in ipairs(bufs) do
		if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_option(bufnr, "buftype") == "" then
			local mod_str = ""
			if vim.api.nvim_buf_get_option(bufnr, "modified") then
				mod_str = "+"
			end
			if bufnr == self.bufnr then
				buf_str = table.concat({ buf_str, "%#TabLineCurrentBuf#", " ", bufnr, mod_str, " " })
			else
				buf_str = table.concat({ buf_str, "%#TabLineBufs#", " ", bufnr, mod_str, " " })
			end
		end
	end
	return buf_str
end

--- Filepath
---@return string path_str
function StatusLine:get_filepath()
	local attached_buffer = vim.api.nvim_win_get_buf(self.winnr)
	local buftype = vim.bo[attached_buffer].buftype

	if buftype ~= "" then
		return table.concat({ "%#StatusLineFilepath#", " ", (buftype:gsub("^%l", buftype:sub(1, 1):upper())), " " })
	else
		local filename = vim.api.nvim_buf_get_name(attached_buffer)
		local fullpath = vim.uv.fs_realpath(filename)
		local pathlist = {}
		local longpath = false
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
		return table.concat({ "%#StatusLineFilepath#", " ", pathstring })
	end
end

--- Git branch and Git status
---@return string git_str
function StatusLine:get_git_branch()
	local attached_buffer = vim.api.nvim_win_get_buf(self.winnr)
	local buftype = vim.bo[attached_buffer].buftype
	if buftype ~= "" then
		return ""
	else
		local branch = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }):wait()
		if branch.code == 0 then
			local status = vim.system({ "git", "status", "--porcelain" }, { text = true }):wait()
			local branch_str = vim.trim(branch.stdout)
			local char_str = ""
			if status.code == 0 and status.stdout then
				-- Repo has uncommitted changes
				char_str = " " .. util.gitchars.change
			end
			return table.concat({ "%#StatusLineVersionControl#", " (git:", branch_str, char_str, ")" })
		else
			-- Not in a git repository
			return ""
		end
	end
end

--- LSP name
---@return string lsp_str
function StatusLine:get_lsp_info()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	local lsp_info = ""
	if #clients > 0 then
		local client = clients[1]
		local client_name = client.name or "Unknown LSP"
		lsp_info = table.concat({ "%#StatusLineLSP#", " (", client_name, ") " })
	else
		if vim.bo.buftype ~= "" then
			lsp_info =
				table.concat({ "%#StatusLineLSP#", " (", (vim.bo.buftype:gsub("^%l", vim.bo.buftype.upper)), ") " })
		else
			lsp_info = ""
		end
	end
	return lsp_info
end

--- Python virtual environment
---@return string venv_str
function StatusLine:get_virtual_env()
	if vim.bo.buftype == "terminal" then
		return ""
	else
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
end

--- Buffer diagnostics
---@return string diagnostic_str
function StatusLine:get_diagnostics()
	local diagnostics = vim.diagnostic.get(0)
	local diagnostic_str = ""
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
	if error_count > 0 then
		diagnostic_str = table.concat({ diagnostic_str, "%#DiagnosticError# E:", error_count, " " })
	end
	if warning_count > 0 then
		diagnostic_str = table.concat({ diagnostic_str, "%#DiagnosticWarn# W:", warning_count, " " })
	end
	if info_count > 0 then
		diagnostic_str = table.concat({ diagnostic_str, "%#DiagnosticInfo# I:", info_count, " " })
	end
	if hint_count > 0 then
		diagnostic_str = table.concat({ diagnostic_str, "%#DiagnosticHint# H:", hint_count, " " })
	end
	return diagnostic_str
end

--- Editor mode
---@return string mode_str
function StatusLine:get_mode()
	local mode = vim.api.nvim_get_mode()
	local modes = {
		n = "%#StatusLineNormal# NORMAL ",
		i = "%#StatusLineInsert# INSERT ",
		v = "%#StatusLineVisual# VISUAL ",
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

--- Render the statusline and winbar
---@return boolean success
function StatusLine:render()
	local statusline = StatusLine.new()
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
	local winbar = StatusLine.new()
	function GetWinBar()
		return table.concat({
			winbar:get_buf_number(),
			winbar:get_filepath(),
			winbar:get_git_branch(),
			-- Horizontal fill
			"%#StatusLine#%=",
			winbar:get_tab_number(),
		})
	end
	vim.wo.winbar = "%!v:lua.GetWinBar()"
	return true
end

return StatusLine
