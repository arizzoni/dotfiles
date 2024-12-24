local IndentMarker = {}
IndentMarker.__index = IndentMarker

local ns_id = vim.api.nvim_create_namespace("IndentMarker")

function IndentMarker.new()
	local self = setmetatable({}, IndentMarker)
	self.markers = {}
	return self
end

function IndentMarker:show()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for i, line in ipairs(lines) do
		local indent = line:match("^%s+")
		if indent then
			indent = string.len(indent)
			for j = 1, indent do
				local indent_markers = {
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
				local virt_opts = {
					virt_text = { indent_markers[j] },
					virt_text_win_col = 2 * j - 2,
				}
				vim.api.nvim_buf_set_extmark(0, ns_id, i - 1, 0, virt_opts)
			end
		end
	end
end

return IndentMarker
