-- ~/.config/nvim/lua/core/terminal.lua
-- Neovim terminal configuration

-- TODO:
-- !Bug: On shell exit close terminal
-- Terminal background color:
--  Can the terminal have a different background color than the rest of Neovim?
-- Horizontal/vertical orientation autocommand:
--  Automatically change the terminal orientation on window resize, if necessary
-- Error handling

local util = require("util")

---@class Terminal
---@field shell string
---@field bufnr number
---@field term number
---@field winnr number
---@field chan_id number
---@field win_opts table
---@field group number
---@field ns_id number
local Terminal = {}

Terminal.shell = nil
Terminal.bufnr = nil
Terminal.term = nil
Terminal.winnr = nil
Terminal.chan_id = nil
Terminal.win_opts = nil
Terminal.group = nil
Terminal.ns_id = nil

--- Constructor for the Terminal class. Initializes a terminal buffer and sets autocommands and keymaps.
--- @param shell? string Program for the terminal to run, defaults to vim.opt.shell
--- @return self
function Terminal.new(shell)
	local self = setmetatable({}, Terminal)
	Terminal.__index = Terminal

	if not self.group then
		self.group = vim.api.nvim_create_augroup("LocalTerm", { clear = true })
	end

	if not shell then
		if vim.o.shell then
			self.shell = vim.o.shell
		elseif vim.env.SHELL then
			self.shell = vim.env.SHELL
		else
			self.shell = "/bin/bash"
		end
	end

	if not self.win_opts then
		self.win_opts = {
			width = math.floor(0.34 * vim.o.columns),
			vertical = true,
			split = "right",
		}
	end

	if not self.ns_id then
		self.ns_id = vim.api.nvim_create_namespace("Terminal")
	end

	vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
		pattern = { "*" },
		group = self.group,
		callback = function()
			util.nmap([[<C-enter>]], function()
				self:toggle()
			end, self.bufnr, "Toggle Terminal")
			util.nmap("<leader>sl", function()
				self:send_line()
			end, self.bufnr, "[S]end Current [L]ine to Terminal")
			util.vmap("<leader>sl", function()
				self:send_lines()
			end, self.bufnr, "[S]end Selected [L]ines to Terminal")
			util.vmap("<leader>ss", function()
				self:send_selection()
			end, self.bufnr, "[S]end [S]election to Terminal")
		end,
	})

	vim.api.nvim_create_autocmd({ "TermOpen" }, {
		pattern = { "*" },
		group = self.group,
		callback = function()
			if vim.api.nvim_get_current_buf() == self.bufnr then
				vim.api.nvim_set_option_value("number", false, { win = self.winnr })
				vim.api.nvim_set_option_value("relativenumber", false, { win = self.winnr })
				vim.api.nvim_set_option_value("scrolloff", 0, { win = self.winnr })
				vim.api.nvim_set_option_value("sidescrolloff", 0, { win = self.winnr })

				util.tmap("<esc>", [[<C-\><C-n>]], self.bufnr, "")
				util.tmap("<C-w>h", [[<Cmd>wincmd h<CR>]], self.bufnr, "")
				util.tmap("<C-w>j", [[<Cmd>wincmd j<CR>]], self.bufnr, "")
				util.tmap("<C-w>k", [[<Cmd>wincmd k<CR>]], self.bufnr, "")
				util.tmap("<C-w>l", [[<Cmd>wincmd l<CR>]], self.bufnr, "")
				util.tmap("<C-w>w", [[<C-\><C-n><C-w>]], self.bufnr, "")
				util.tmap([[<C-enter>]], function()
					self:toggle()
				end, self.bufnr, "")
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = { "*" },
		group = self.group,
		callback = function()
			if vim.api.nvim_get_current_buf() == self.bufnr then
				vim.cmd("startinsert")
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "WinResized", "WinLeave", "WinEnter" }, {
		pattern = { "*" },
		group = self.group,
		callback = function()
			if self.winnr == vim.api.nvim_get_current_win() then
				local target_width = math.floor(0.34 * vim.o.columns) -- or 84
				local target_height = vim.o.lines
				local windows = vim.api.nvim_list_wins()
				local window_index = nil

				if vim.api.nvim_win_get_width(self.winnr) ~= target_width then
					vim.api.nvim_win_set_width(self.winnr, target_width)
				end
				if vim.api.nvim_win_get_height(self.winnr) ~= target_height then
					vim.api.nvim_win_set_height(self.winnr, target_height)
				end

				for index, window in ipairs(windows) do
					if window == self.winnr then
						window_index = index
					end
				end
				if window_index then
					table.remove(windows, window_index)
				end
				table.insert(windows, self.winnr)
				vim.api.nvim_set_current_win(windows[#windows])
				vim.api.nvim_win_set_cursor(self.winnr, { 1, 0 })
			end
		end,
	})

	vim.api.nvim_create_autocmd("TermClose", {
		group = self.group,
		callback = function()
			if self.bufnr == vim.api.nvim_get_current_buf() then
				vim.api.nvim_buf_delete(self.bufnr, { force = true, unload = false })
			end
		end,
	})

	return self
end

--- Show the terminal
---@return boolean success
function Terminal:open()
	if not self.bufnr or not vim.api.nvim_buf_is_valid(self.bufnr) then
		self.bufnr = vim.api.nvim_create_buf(false, false)
	end
	if not self.winnr or not vim.api.nvim_win_is_valid(self.winnr) then
		self.winnr = vim.api.nvim_open_win(self.bufnr, true, self.win_opts)
	end
	if not self.chan_id then
		self.chan_id = vim.fn.termopen(self.shell)
	end
	return true
end

--- Hide the terminal
---@return boolean success
function Terminal:close()
	if self.winnr or vim.api.nvim_win_is_valid(self.winnr) then
		vim.api.nvim_win_close(self.winnr, true)
	end
	return true
end

--- Toggle whether the terminal is hidden or shown
---@return boolean success
function Terminal:toggle()
	if self.bufnr and vim.api.nvim_buf_is_valid(self.bufnr) then
		if self.winnr and vim.api.nvim_win_is_valid(self.winnr) then
			self:close()
		else
			self:open()
		end
	else
		self:open()
	end
	return true
end

--- Send the selected lines to the terminal
---@return boolean success
function Terminal:send_lines()
	if not self.bufnr or not vim.api.nvim_buf_is_valid(self.bufnr) then
		self:toggle()
	end

	local current_buf = vim.api.nvim_get_current_buf()

	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line = start_pos[2] - 1
	local start_col = start_pos[3] - 1
	local end_line = end_pos[2]
	local end_col = -1

	vim.api.nvim_buf_add_highlight(current_buf, self.ns_id, "IncSearch", start_line, start_col, end_col)

	local lines = vim.api.nvim_buf_get_lines(current_buf, start_line, end_line, false)
	for _, line in ipairs(lines) do
		vim.api.nvim_chan_send(self.chan_id, line .. "\r")
	end

	vim.defer_fn(function()
		vim.api.nvim_buf_clear_namespace(current_buf, self.ns_id, start_line - 1, end_line)
	end, 100)

	return true
end

--- Send the visual selection to the terminal
---@return boolean success
function Terminal:send_selection()
	if not self.bufnr or not vim.api.nvim_buf_is_valid(self.bufnr) then
		self:toggle()
	end

	local current_buf = vim.api.nvim_get_current_buf()

	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line = start_pos[2] - 1
	local start_col = start_pos[3] - 1
	local end_line = end_pos[2]
	local end_col = end_pos[3]

	vim.api.nvim_buf_add_highlight(current_buf, self.ns_id, "IncSearch", start_line, start_col, end_col)
	vim.defer_fn(function()
		vim.api.nvim_buf_clear_namespace(current_buf, self.ns_id, start_line - 1, end_line)
	end, 100)

	local text = vim.api.nvim_buf_get_text(current_buf, start_line, start_pos[1], end_line, end_pos[1], {})
	vim.api.nvim_chan_send(self.chan_id, text .. "\r")
	return true
end

--- Send the line under the cursor to the terminal
---@return boolean success
function Terminal:send_line()
	if not self.bufnr or not vim.api.nvim_buf_is_valid(self.bufnr) then
		self:toggle()
	end

	local current_buf = vim.api.nvim_get_current_buf()
	local cursor_pos = vim.fn.getpos(".")

	local start_line = cursor_pos[2] - 1
	local start_col = 0
	local end_line = cursor_pos[2]
	local end_col = -1

	vim.api.nvim_buf_add_highlight(current_buf, self.ns_id, "IncSearch", start_line, start_col, end_col)
	vim.defer_fn(function()
		vim.api.nvim_buf_clear_namespace(current_buf, self.ns_id, start_line - 1, end_line)
	end, 100)

	local line = vim.api.nvim_buf_get_lines(current_buf, cursor_pos[2] - 1, cursor_pos[2], false)[1]
	vim.api.nvim_chan_send(self.chan_id, line)
	return true
end

return Terminal
