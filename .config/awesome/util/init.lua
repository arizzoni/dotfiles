local util = {}

util.external = {
  terminal = "alacritty",
  editor = os.getenv("EDITOR") or "nvim",
  editor_cmd = "alacritty -e nvim",
  file_manager = "thunar",
  browser = "firefox",
  mail = "thunderbird",
  screenshot = "screenshot -c",
  music = "ncmpcpp -s media_library -S visualizer",
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
