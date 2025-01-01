-- indent.lua
-- Neovim indentation guides

--- @class IndentMarker
--- @field indent_markers table|string
--- @field ns_id number
local IndentMarker = {}

IndentMarker.ns_id = nil
IndentMarker.indent_markers = {}

--- @param indent_markers? table|string table of tuples (or just one) of an indent marker character and highlight group
--- @return self
function IndentMarker.new(indent_markers)
	local self = setmetatable({}, IndentMarker)
	IndentMarker.__index = IndentMarker
	if indent_markers ~= nil then
		self.indent_markers = indent_markers
	else
		self.indent_markers = {
			{ " ", "IndentMarker" },
			{ "░", "IndentMarker" },
			{ "▒", "IndentMarker" },
			{ "▓", "IndentMarker" },
			{ "█", "IndentMarker" },
			{ "▓", "IndentMarker" },
			{ "▒", "IndentMarker" },
			{ "░", "IndentMarker" },
			{ " ", "IndentMarker" },
			{ "░", "IndentMarker" },
			{ "▒", "IndentMarker" },
			{ "▓", "IndentMarker" },
			{ "█", "IndentMarker" },
			{ "▓", "IndentMarker" },
			{ "▒", "IndentMarker" },
			{ "░", "IndentMarker" },
			{ " ", "IndentMarker" },
		}
	end
	self.ns_id = vim.api.nvim_create_namespace("IndentMarker")
	self:show()
	return self
end

--- @return boolean success
function IndentMarker:show()
	local bufnr = 0
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, true)

	local added_extmarks = {}

	for i, line in ipairs(lines) do
		if vim.bo.expandtab == false then
			local tabs = line:match("^%s+")
			if tabs then
				for j = 1, #tabs do
					local index = (j % #self.indent_markers) + 1
					if not added_extmarks[i - 1] or not added_extmarks[i - 1][index] then
						vim.api.nvim_buf_set_extmark(
							bufnr,
							self.ns_id,
							i - 1,
							j - 1,
							{ virt_text = { self.indent_markers[index] }, virt_text_pos = "overlay" }
						)
						added_extmarks[i - 1] = added_extmarks[i - 1] or {}
						added_extmarks[i - 1][index] = true
					end
				end
			end
		else
			local spaces = line:match("^%s+")
			if spaces then
				for j = 1, #spaces do
					local index = math.floor(((j % #self.indent_markers) + 1) / 2 * vim.bo.softtabstop)
					if not added_extmarks[i - 1] or not added_extmarks[i - 1][index] then
						vim.api.nvim_buf_set_extmark(
							bufnr,
							self.ns_id,
							i - 1,
							j - 1,
							{ virt_text = { self.indent_markers[index] }, virt_text_pos = "overlay" }
						)
						added_extmarks[i - 1] = added_extmarks[i - 1] or {}
						added_extmarks[i - 1][index] = true
					end
				end
			end
		end
	end
	return true
end

return IndentMarker
