-- if in git repo use git grep?
-- look at rgflow too for quickfix interaction?

if vim.fn.executable("grep") then
	local grep = "grep --recursive --with-filename --initial-tab --line-number --binary-files=without-match"

	if vim.o.ignorecase == true then
		grep = grep .. " --ignore-case"
	end

	grep = grep .. " $* ."
	vim.opt.grepprg = grep

	vim.keymap.set("n", "<leader>gg", ":copen | :silent :grep ")
	vim.keymap.set("n", "gn", ":cnext <CR>")
	vim.keymap.set("n", "gp", ":cprev <CR>")
end
