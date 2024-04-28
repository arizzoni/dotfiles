local util = {}

util.external = {
  terminal = "alacritty",
  editor = "nvim",
  editor_cmd = "neovide",
  file_manager = "alacritty -e xplr",
  screen_locker = "light-locker-command -l",
  browser = "firefox",
  mail = "evolution",
  screenshot = "maim -u -m 10 -i $(xdotool getactivewindow) | tee $HOME/pictures/screenshots/$(date +%FT%T).png | xclip -selection clipboard -t image/png",
  screenshot_region = "maim -u -s -m 10 | tee $HOME/pictures/screenshots/$(date +%FT%T).png | xclip -selection clipboard -t image/png",
  music = "alacritty -e ncmpcpp -s browser -S visualizer",
}

function util.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

return util
