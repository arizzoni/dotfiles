-- Set lualine as statusline
return {
  url = "https://www.github.com/NeogitOrg/neogit",
  dependencies = {
    {
      url = "https://www.github.com/nvim-lua/plenary.nvim",
    },
    {
    url = "https://www.github.com/sindrets/diffview.nvim",
    },
    {
    url = "https://www.github.com/nvim-telescope/telescope.nvim",
    },
  },
  event = "VeryLazy",
  config = true,
  opts = {
    -- Hides the hints at the top of the status buffer
    disable_hint = false,
    -- Disables changing the buffer highlights based on where the cursor is.
    disable_context_highlighting = false,
    -- Disables signs for sections/items/hunks
    disable_signs = false,
    -- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
    -- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
    -- normal mode.
    disable_insert_on_commit = "auto",
    -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
    -- events.
    filewatcher = {
      interval = 1000,
      enabled = true,
    },
    graph_style = "unicode",
    git_services = {
      ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
      ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
      ["gitlab.com"] =
      "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
      ["azure.com"] =
      "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
    },
    telescope_sorter = function()
      return require("telescope").extensions.fzy.native_fzy_sorter()
    end,
    remember_settings = true,
    use_per_project_settings = true,
    ignored_settings = {
      "NeogitPushPopup--force-with-lease",
      "NeogitPushPopup--force",
      "NeogitPullPopup--rebase",
      "NeogitCommitPopup--allow-empty",
      "NeogitRevertPopup--no-edit",
    },
    highlight = {
      italic = true,
      bold = true,
      underline = true
    },
    use_default_keymaps = true,
    auto_refresh = true,
    -- Value used for `--sort` option for `git branch` command
    -- By default, branches will be sorted by commit date descending
    -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
    -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
    sort_branches = "-committerdate",
    kind = "split",
    -- Disable line numbers and relative line numbers
    disable_line_numbers = true,
    -- The time after which an output console is shown for slow running commands
    console_timeout = 2000,
    -- Automatically show console if a command takes more than console_timeout milliseconds
    auto_show_console = true,
    -- Automatically close the console if the process exits with a 0 (success) status
    auto_close_console = true,
    status = {
      show_head_commit_hash = true,
      recent_commit_count = 10,
      HEAD_padding = 10,
      HEAD_folded = false,
      mode_padding = 3,
      mode_text = {
        M = "modified",
        N = "new file",
        A = "added",
        D = "deleted",
        C = "copied",
        U = "updated",
        R = "renamed",
        DD = "unmerged",
        AU = "unmerged",
        UD = "unmerged",
        UA = "unmerged",
        DU = "unmerged",
        AA = "unmerged",
        UU = "unmerged",
        ["?"] = "",
      },
    },
    commit_editor = {
      kind = "tab",
      show_staged_diff = true,
      -- Accepted values:
      -- "split" to show the staged diff below the commit editor
      -- "vsplit" to show it to the right
      -- "split_above" Like :top split
      -- "vsplit_left" like :vsplit, but open to the left
      -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
      staged_diff_split_kind = "split"
    },
    commit_select_view = {
      kind = "tab",
    },
    commit_view = {
      kind = "vsplit",
      verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
    },
    log_view = {
      kind = "tab",
    },
    rebase_editor = {
      kind = "auto",
    },
    reflog_view = {
      kind = "tab",
    },
    merge_editor = {
      kind = "auto",
    },
    tag_editor = {
      kind = "auto",
    },
    preview_buffer = {
      kind = "split",
    },
    popup = {
      kind = "split",
    },
    signs = {
      -- { CLOSED, OPENED }
      hunk = { "", "" },
      item = { ">", "v" },
      section = { ">", "v" },
    },
  }
}
