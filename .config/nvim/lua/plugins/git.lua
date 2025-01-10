local util = require("util")

return {
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		url = "https://www.github.com/lewis6991/gitsigns.nvim",
		name = "gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			attach_to_untracked = false,
			signs = {
				add = { text = util.gitchars.add },
				change = { text = util.gitchars.change },
				delete = { text = util.gitchars.delete },
				topdelete = { text = util.gitchars.topdelete },
				changedelete = { text = util.gitchars.changedelete },
				untracked = { text = util.gitchars.untracked },
			},
			on_attach = function(bufnr)
				local gs = require("gitsigns")
				-- util.nmap("hn", gs.nav_hunk('next'), bufnr, "Go to Previous Hunk")
				-- util.nmap("hp", gs.nav_hunk('prev'), bufnr, "Go to Next Hunk")
				util.nmap("<leader>gv", gs.preview_hunk, bufnr, "Pre[V]iew [H]unk")
				util.nmap("<leader>tb", gs.toggle_current_line_blame, bufnr, "[T]oggle Line [B]lame")
				util.nmap("<leader>tB", function()
					gs.blame_line({ full = true })
				end, bufnr, "[T]oggle Buffer [B]lame")
				util.nmap("<leader>gs", gs.stage_hunk, bufnr, "[S]tage [H]unk")
				util.nmap("<leader>gr", gs.reset_hunk, bufnr, "[R]eset [H]unk")
				util.vmap("<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, bufnr, "[S]tage [H]unk")
				util.vmap("<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, bufnr, "[R]eset [H]unk")
				util.nmap("<leader>gS", gs.stage_buffer, bufnr, "[S]tage [B]uffer")
				util.nmap("<leader>gu", gs.undo_stage_hunk, bufnr, "[U]ndo Stage [H]unk")
				util.nmap("<leader>gR", gs.reset_buffer, bufnr, "[R]eset Buffer")
				util.nmap("<leader>gd", gs.diffthis, bufnr, "[D]iff [H]unk")
				util.nmap("<leader>gD", gs.reset_buffer, bufnr, "[D]iff File")
				util.nmap("<leader>td", gs.toggle_deleted, bufnr, "[T]oggle [D]eleted")
			end,
		},
	},
}
