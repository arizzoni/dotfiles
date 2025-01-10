local M = {}

---@param context string
---@param errmsg string
---@return string errstr
M.error = function(context, errmsg)
	local errstr = table.concat({ context .. " Error: ", errmsg })
	vim.api.nvim_err_writeln(errstr)
	return errstr or ""
end

M.nmap = function(keys, func, bufnr, desc)
	if desc then
		desc = "N: " .. desc
	end
	vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
end

M.imap = function(keys, func, bufnr, desc)
	if desc then
		desc = "I: " .. desc
	end
	vim.keymap.set("i", keys, func, { buffer = bufnr, desc = desc })
end

M.vmap = function(keys, func, bufnr, desc)
	if desc then
		desc = "V: " .. desc
	end
	vim.keymap.set("v", keys, func, { buffer = bufnr, desc = desc })
end

M.tmap = function(keys, func, bufnr, desc)
	if desc then
		desc = "T: " .. desc
	end
	vim.keymap.set("t", keys, func, { buffer = bufnr, desc = desc })
end

M.umap = function(keys, func, bufnr, desc)
	if desc then
		desc = "U: " .. desc
	end
	M.nmap(keys, func, bufnr, desc)
	M.vmap(keys, func, bufnr, desc)
	M.imap(keys, func, bufnr, desc)
	M.tmap(keys, func, bufnr, desc)
end

M.augroup = function(name, func)
	local group = vim.api.nvim_create_augroup(name, {})
	local function autocmd(event, opts)
		vim.api.nvim_create_autocmd(event, vim.tbl_extend("force", opts, { group = group }))
	end
	func(autocmd)
end

M.gitchars = {
	add = "+",
	change = "∆",
	delete = "-",
	topdelete = "=",
	changedelete = "⍙",
	untracked = "ø",
}

return M
