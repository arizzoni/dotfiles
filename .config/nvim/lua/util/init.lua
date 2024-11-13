local M = {}

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

M.augroup = function(name, func)
  local group = vim.api.nvim_create_augroup(name, {})
  local function autocmd(event, opts)
    vim.api.nvim_create_autocmd(
      event,
      vim.tbl_extend("force", opts, { group = group })
    )
  end
  func(autocmd)
end

return M
