local Line = {}

-- TODO: Try to get everything to happen asynchronously
-- TODO: Rework the highlights so that they behave more like lualine

function Line.new()
	local self = setmetatable({}, Line)
	Line.__index = Line

	self.get_file_info = function()
		return "%#StatusLineFileInfo#"
			.. " ("
			.. vim.bo.fileencoding
			.. " | "
			.. vim.bo.fileformat
			.. " | "
			.. vim.bo.filetype
			.. ") "
	end

	self.get_cursor_pos = function()
		return "%#StatusLineCursorPos#" .. " R:%l/%L " .. "C:%c/" .. vim.bo.textwidth .. " "
	end

	self.get_tab_number = function()
		local tabs = vim.api.nvim_list_tabpages()
		local current_tab = vim.api.nvim_tabpage_get_number(0)
		local tabstr = ""

		for tabnr, _ in ipairs(tabs) do
			if tabnr == current_tab then
				tabstr = tabstr .. "%#TabLineCurrentTab#" .. " " .. tabnr .. " "
			else
				tabstr = tabstr .. "%#TabLineTabs#" .. " " .. tabnr .. " "
			end
		end
		return tabstr
	end

	self.get_buf_number = function()
		local bufs = vim.api.nvim_list_bufs()
		local current_buf = vim.api.nvim_get_current_buf()
		local bufstr = ""

		for bufnr, _ in ipairs(bufs) do
			if vim.api.nvim_buf_is_valid(bufnr) and vim.fn.bufwinnr(bufnr) ~= -1 then
				if bufnr == current_buf then
					bufstr = bufstr .. "%#TabLineCurrentBuf#" .. " " .. bufnr .. " "
				else
					bufstr = bufstr .. "%#TabLineBufs#" .. " " .. bufnr .. " "
				end
			end
		end
		return bufstr
	end

	self.get_filepath = function()
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
			modstring = "[+]"
		end
		return "%#StatusLineFilepath#" .. " " .. pathstring .. "%#StatusLineModified#" .. modstring
	end

	self.get_git_branch = function()
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
			return "%#StatusLineVersionControl#" .. " (git:" .. branch[1] .. character .. ")"
		end
	end

	self.get_lsp_info = function()
		local clients = vim.lsp.get_clients({ bufnr = 0 })
		local lsp_info = ""

		if #clients > 0 then
			local client = clients[1]
			local client_name = client.name or "Unknown LSP"
			lsp_info = "%#StatusLineLSP#" .. " " .. client_name
		else
			lsp_info = "%#StatusLineLSP#" .. " " .. "No LSP Client"
		end

		return lsp_info
	end

	self.get_virtual_env = function()
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
			return "%#StatusLineVersionControl#" .. " (venv:" .. venvpath[1] .. ")"
		end
	end

	self.get_diagnostics = function()
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
			diagnostic_str = diagnostic_str .. "E:" .. error_count .. " "
		end
		if warning_count > 0 then
			diagnostic_str = diagnostic_str .. "W:" .. warning_count .. " "
		end
		if info_count > 0 then
			diagnostic_str = diagnostic_str .. "I:" .. info_count .. " "
		end
		if hint_count > 0 then
			diagnostic_str = diagnostic_str .. "H:" .. hint_count .. " "
		end
		if #diagnostic_str ~= 0 then
			-- Return the constructed string, remove trailing space
			return "%#StatusLineDiagnostics#" .. " " .. diagnostic_str
		else
			return ""
		end
	end

	self.get_mode = function()
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

	return self
end

return Line
