-- context.lua
-- Neovim treesitter context highlighter

-- Define the ContextHighlighter class
local ContextHighlighter = {}
ContextHighlighter.__index = ContextHighlighter

-- Constructor for the ContextHighlighter class
function ContextHighlighter.new()
	local self = setmetatable({}, ContextHighlighter)
	self.ns_id = vim.api.nvim_create_namespace("context_highlighter")
	self.last_highlighted_range = nil -- Store the last highlighted range
	self.debounce_timer = nil -- For debouncing the cursor movement
	self.parser = nil -- Cache the Treesitter parser
	return self
end

-- Function to get or initialize the Treesitter parser
function ContextHighlighter:get_parser()
	if not self.parser then
		-- Create a new parser if not cached
		self.parser = vim.treesitter.get_parser(0)
	end
	return self.parser
end

-- Function to get the current node under the cursor using Treesitter
function ContextHighlighter:get_cursor_node()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row, col = cursor[1] - 1, cursor[2] -- Adjust for 0-indexing

	-- Get the cached parser
	local parser = self:get_parser()
	local tree = parser:parse()[1]
	local root = tree:root()

	return root:named_descendant_for_range(row, col, row, col)
end

-- Function to highlight the scope under the cursor
function ContextHighlighter:highlight_scope()
	-- Get the current node under the cursor
	local node = self:get_cursor_node()
	if not node then
		return
	end

	-- Find the start and end of the scope
	local start_row, start_col, end_row, end_col = node:range()

	-- If the scope hasn't changed, skip the update
	if
		self.last_highlighted_range
		and self.last_highlighted_range.start_row == start_row
		and self.last_highlighted_range.start_col == start_col
		and self.last_highlighted_range.end_row == end_row
		and self.last_highlighted_range.end_col == end_col
	then
		return
	end

	-- Clear previous highlights if needed
	if self.last_highlighted_range then
		vim.api.nvim_buf_clear_namespace(
			0,
			self.ns_id,
			self.last_highlighted_range.start_row,
			self.last_highlighted_range.end_row + 1
		)
	end

	-- Underline the start and end of the node's scope
	self:underline_node(start_row, start_col, end_row, end_col)

	-- Update the last highlighted range
	self.last_highlighted_range = {
		start_row = start_row,
		start_col = start_col,
		end_row = end_row,
		end_col = end_col,
	}
end

-- Function to underline the start and end of a node
function ContextHighlighter:underline_node(start_row, start_col, end_row, end_col)
	-- Underline the start of the scope
	vim.api.nvim_buf_add_highlight(0, self.ns_id, "Underlined", start_row, start_col, end_col)

	-- Underline the end of the scope
	vim.api.nvim_buf_add_highlight(0, self.ns_id, "Underlined", end_row, start_col, end_col)
end

-- Function to handle CursorMoved with debouncing
function ContextHighlighter:start_highlighting()
	vim.api.nvim_create_autocmd("CursorMoved", {
		callback = function()
			if self.debounce_timer then
				vim.fn.timer_stop(self.debounce_timer)
			end
			self.debounce_timer = vim.fn.timer_start(100, function()
				self:highlight_scope()
			end, { ["repeat"] = 0 })
		end,
	})

	-- Invalidate the parser cache when the buffer is changed (edit or reload)
	vim.api.nvim_create_autocmd({ "TextChanged", "BufWritePost", "BufEnter" }, {
		callback = function()
			self.parser = nil -- Invalidate parser cache
		end,
	})
end

-- Return the module
return ContextHighlighter
