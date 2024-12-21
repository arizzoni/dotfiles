local Terminal = {}

function Terminal.new(shell)
  local self = setmetatable({}, Terminal)
  Terminal.__index = Terminal

  self.win_opts = nil
  self.shell = nil
  self.win = nil
  self.buf = nil
  self.chan_id = nil

  if not self.win_opts then
    local parent_win = vim.api.nvim_get_current_win()
    self.win_opts = {
      width = math.floor(0.34 * vim.api.nvim_win_get_width(parent_win)),
      vertical = true,
      split = "right",
    }
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

  local term_group = vim.api.nvim_create_augroup("LocalTerm", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = term_group,
    callback = function()
      if self.buf == vim.api.nvim_get_current_buf() then
        vim.cmd("startinsert")
      end
    end,
  })

  self.open = function()
    if not self.buf or not vim.api.nvim_buf_is_valid(self.buf) then
      self.buf = vim.api.nvim_create_buf(false, true)
      self.win = vim.api.nvim_open_win(self.buf, true, self.win_opts)
      self.chan_id = vim.fn.termopen(self.shell)
      vim.api.nvim_set_option_value("number", false, { win = self.win })
      vim.api.nvim_set_option_value("relativenumber", false, { win = self.win })
    else
      self.win = vim.api.nvim_open_win(self.buf, true, self.win_opts)
    end
  end

  self.close = function()
    if self.buf and vim.api.nvim_buf_is_valid(self.buf) then
      vim.api.nvim_win_close(self.win, true)
    end
  end

  self.toggle = function()
    if self.buf and vim.api.nvim_buf_is_valid(self.buf) then
      if self.win and vim.api.nvim_win_is_valid(self.win) then
        self.close()
      else
        self.open()
      end
    else
      self.open()
    end
  end

  self.send_lines = function()
    if not self.buf or not vim.api.nvim_buf_is_valid(self.buf) then
      self.toggle()
    end

    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2] - 1
    local start_col = start_pos[3] - 1
    local end_line = end_pos[2]
    local end_col = -1

    vim.api.nvim_buf_add_highlight(0, -1, "IncSearch", start_line, start_col, end_col)
    vim.defer_fn(function()
      vim.api.nvim_buf_clear_highlight(0, -1, start_line - 1, end_line)
    end, 100)

    local lines = vim.api.nvim_buf_get_lines(self.buf, start_line, end_line, false)
    for _, line in ipairs(lines) do
      vim.api.nvim_chan_send(self.chan_id, line .. "\r")
    end
  end

  self.send_selection = function()
    if not self.buf or not vim.api.nvim_buf_is_valid(self.buf) then
      self.toggle()
    end

    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2] - 1
    local start_col = start_pos[3] - 1
    local end_line = end_pos[2]
    local end_col = end_pos[3]

    vim.api.nvim_buf_add_highlight(0, -1, "IncSearch", start_line, start_col, end_col)
    vim.defer_fn(function()
      vim.api.nvim_buf_clear_highlight(0, -1, start_line - 1, end_line)
    end, 100)

    local text = vim.api.nvim_buf_get_text(self.buf, start_line, start_pos[1], end_line, end_pos[1], false)
    vim.api.nvim_chan_send(self.chan_id, text .. "\r")
  end

  self.send_line = function()
    if not self.buf or not vim.api.nvim_buf_is_valid(self.buf) then
      self.toggle()
    end

    local current_buf = vim.api.nvim_get_current_buf()
    local cursor_pos = vim.fn.getpos(".")

    local start_line = cursor_pos[2] - 1
    local start_col = 0
    local end_line = cursor_pos[2]
    local end_col = -1

    vim.api.nvim_buf_add_highlight(0, -1, "IncSearch", start_line, start_col, end_col)
    vim.defer_fn(function()
      vim.api.nvim_buf_clear_highlight(0, -1, start_line - 1, end_line)
    end, 100)

    local line = vim.api.nvim_buf_get_lines(current_buf, cursor_pos[2] - 1, cursor_pos[2], false)[1]
    vim.api.nvim_chan_send(self.chan_id, line)
  end

  return self
end

return Terminal
