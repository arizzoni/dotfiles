local StatusLine = {}

function StatusLine.new()
  local self = setmetatable({}, StatusLine)
  StatusLine.__index = StatusLine

  self.get_filepath = function()
    -- TODO get this to work the same as the one in my .bashrc
    local filepath = vim.fn.expand("%:p")
    if vim.bo.modified then
      filepath = filepath .. "[+]"
    end
    return "%#StatusLineFilepath#" .. " " .. filepath
  end

  self.get_git_branch = function()
    local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")
    if #branch ~= 1 then
      return "" -- Not in a git repository
    else
      local status = vim.fn.systemlist("git status --porcelain")
      local character = ""
      if #status ~= 0 then
        character = " ~" -- Dirty repo
      end
      return "%#StatusLineVersionControl#" .. " (git:" .. branch[1] .. character .. ")"
    end
  end

  self.get_virtual_env = function()
    local venv = vim.uv.os_getenv("VIRTUAL_ENV")

    if not venv then
      return ""
    else
      return "%#StatusLineVersionControl#" .. " (venv:" .. venv .. ")"
    end
  end

  self.get_diagnostics = function()
    local diagnostics = vim.diagnostic.get(0)

    local error_count = 0
    local warning_count = 0
    local info_count = 0
    local hint_count = 0

    for _, diagnostic in ipairs(diagnostics) do
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        error_count = error_count + 1
      elseif diagnostic.severity == vim.diagnostic.severity.WARN then
        warning_count = warning_count + 1
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        info_count = info_count + 1
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        hint_count = hint_count + 1
      end
    end

    local diagnostic_str = ""

    if error_count > 0 then
      diagnostic_str = diagnostic_str .. "E:" .. error_count .. " "
    end
    if warning_count > 0 then
      diagnostic_str = diagnostic_str .. "W:" .. warning_count .. " "
    end
    if info_count > 0 then
      diagnostic_str = diagnostic_str .. "I:" .. info_count .. " "
    end
    if hint_count > 0 then
      diagnostic_str = diagnostic_str .. "H:" .. hint_count .. " "
    end
    if #diagnostic_str ~= 0 then
      -- Return the constructed string, remove trailing space
      return "%#StatusLineDiagnostics#" .. " " .. diagnostic_str
    else
      return ""
    end
  end

  self.get_mode = function()
    local mode = vim.api.nvim_get_mode()
    local modes = {
      n = "%#StatusLineNormal# NORMAL ",
      i = "%#StatusLineInsert# INSERT ",
      v = "%#StatusLineVisual# VISUAL",
      V = "%#StatusLineVisual# VISUAL-LINE ",
      -- For Ctrl-V mode:
      ["\22"] = "%#StatusLineVisual# VISUAL-BLOCK ",
      c = "%#StatusLineCommand# COMMAND ",
      R = "%#StatusLineReplace# REPLACE ",
      s = "%#StatusLineSelect# SELECT ",
      S = "%#StatusLineSelect# SELECT-LINE ",
      t = "%#StatusLineTerminal# TERMINAL ",
    }
    return modes[mode.mode] or mode.mode
  end

  return self
end

return StatusLine
