local line = require("core.statusline")

local bufnr = vim.api.nvim_get_current_buf()

vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "virtualenvs/neovim/bin")
vim.bo.textwidth = 88

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
