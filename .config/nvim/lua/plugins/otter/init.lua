return {
  "jmbuhr/otter.nvim",
  ft = 'tex',
  opts = {
    lsp = {
      hover = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      },
      -- `:h events` that cause the diagnostics to update. Set to:
      -- { "BufWritePost", "InsertLeave", "TextChanged" } for less performant
      -- but more instant diagnostic updates
      diagnostic_update_events = { "InsertLeave" },
    },
    buffers = {
      -- if set to true, the filetype of the otterbuffers will be set.
      -- otherwise only the autocommand of lspconfig that attaches
      -- the language server will be executed without setting the filetype
      set_filetype = true,
      -- write <path>.otter.<embedded language extension> files
      -- to disk on save of main buffer.
      -- usefule for some linters that require actual files
      -- otter files are deleted on quit or main buffer close
      write_to_disk = false,
    },
    strip_wrapping_quote_characters = { "'", '"', "`" },
    -- Otter may not work the way you expect when entire code blocks are indented (eg. in Org files)
    -- When true, otter handles these cases fully. This is a (minor) performance hit
    handle_leading_whitespace = false,
  },
  config = function()
    local otter = require('otter')
    -- table of embedded languages to look for.
    -- default = nil, which will activate
    -- any embedded languages found
    local languages = { 'python', 'lua', 'matlab', 'julia' }

    -- enable completion/diagnostics
    -- defaults are true
    local completion = true
    local diagnostics = true
    -- treesitter query to look for embedded languages
    -- uses injections if nil or not set
    local tsquery = nil

    otter.activate(languages, completion, diagnostics, tsquery)
  end,


}
