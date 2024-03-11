---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.
version = "0.21.5" -- Define script version for compatibility checks
---@diagnostic enable

local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path
  .. ";"
  .. xpm_path
  .. "/?.lua;"
  .. xpm_path
  .. "/?/init.lua"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)

require("xpm").setup({
  plugins = {
    -- Let xpm manage itself
    'dtomvan/xpm.xplr',
    { name = 'gitlab:hartan/web-devicons.xplr' },
    { name = 'sayanarijit/fzf.xplr' },
    { name = 'sayanarijit/alacritty.xplr' },
    { name = 'sayanarijit/xclip.xplr' },
  },
  auto_install = true,
  auto_cleanup = true,
})

require("fzf").setup{
  mode = "default",
  key = "ctrl-f",
  bin = "fzf",
  args = "--preview 'pistol {}'",
  recursive = false,  -- If true, search all files under $PWD
  enter_dir = false,  -- Enter if the result is directory
}

require("alacritty").setup{
  mode = "default",
  key = "ctrl-n",
  send_focus = true,
  send_selection = true,
  send_vroot = true,
  alacritty_bin = "alacritty",
  extra_alacritty_args = "",
  xplr_bin = "xplr",
  extra_xplr_args = "",
}

require("xclip").setup{
  copy_command = "xclip-copyfile",
  copy_paths_command = "xclip -sel clip",
  paste_command = "xclip-pastefile",
  keep_selection = false,
}

xplr.config.node_types.directory.meta.icon = ""
xplr.config.node_types.file.meta.icon = ""
xplr.config.node_types.symlink.meta.icon = ""

-- # Configuration

-- Set it to `true` if you want to enable a safety feature that will save you
-- from yourself when you type recklessly.
--
-- Type: boolean
xplr.config.general.enable_recover_mode = true

-- Type of the borders by default.
--
-- Type: nullable [Border Type](https://xplr.dev/en/borders#border-type)
xplr.config.general.panel_ui.default.border_type = "Plain"
