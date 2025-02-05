-- ~/.config/nvim/lua/core/filemanager.lua
-- Neovim file manager wrapper around netrw

-- TODO:
-- Maintain one netrw buffer
--  Don't create/destroy a buffer each time
--  1.  Create hidden netrw buffer
--      1.  Call vim.api.nvim_command(:hide explore)
--  2.  When the open() method is called:
--      1.  Create a new window with win_opts like in core/terminal.lua
--      2.  Load the netrw buffer into the new window
--  3.  When the close() method is called:
--      1.  Hide the netrw buffer
--      2.  Close (destroy) the window but keep the buffer

local util = require("util")

---@class FileManager
---@field directory string
---@field bufnr number
---@field winnr number
local FileManager = {}

FileManager.directory = nil
FileManager.bufnr = nil
FileManager.winnr = nil

--- Constructor for the FileManager class
---@param directory? string Directory to start the file manager in
---@return self
function FileManager.new(directory)
	local self = setmetatable({}, FileManager)
	FileManager.__index = FileManager
	self.directory = directory or vim.fn.getcwd()
	vim.g.netrw_liststyle = 3
	vim.g.netrw_browse_split = 4
	vim.g.netrw_banner = 0
	vim.g.netrw_sort_by = 1
	vim.g.netrw_fastbrowse = 0
	vim.g.netrw_preview = 1
	vim.g.netrw_alto = 1
	vim.g.netrw_altv = 0
	vim.g.netrw_keepdir = 1
	vim.g.netrw_winsize = 17

	local netrw_group = vim.api.nvim_create_augroup("NetrwGroup", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = netrw_group,
		pattern = "netrw",
		callback = function()
			util.nmap([[<c-\>]], function()
				self:toggle()
			end, self.bufnr, "[F]ile [M]anager")
			vim.wo.statusline = " "
			vim.wo.winbar = nil
			vim.wo.number = false
			vim.wo.relativenumber = false
		end,
	})

	vim.api.nvim_create_autocmd("BufWinEnter", {
		group = netrw_group,
		pattern = "*",
		callback = function()
			util.umap([[<c-\>]], function()
				self:toggle()
			end, self.bufnr, "[F]ile [M]anager")
		end,
	})

	return self
end

--- Open the netrw file browser at the given directory
---@return boolean success
function FileManager:open()
	if not self.bufnr then
		self.bufnr = vim.api.nvim_create_buf(false, true)
	end
	self.winnr = vim.api.nvim_open_win(self.bufnr, true, {
		split = "left",
		vertical = true,
		width = math.floor(0.17 * vim.o.columns),
	})
	vim.api.nvim_command("b" .. self.bufnr .. " | Explore " .. self.directory)
	return true
end

-- Close the netrw file browser
---@return boolean success
function FileManager:close()
	if self.winnr then
		vim.api.nvim_win_close(self.winnr, true)
		self.winnr = nil
	end
	return true
end

-- Toggle the netrw file browser
---@return boolean success
function FileManager:toggle()
	if self.winnr then
		self:close()
	else
		self:open()
	end
	return true
end

return FileManager
