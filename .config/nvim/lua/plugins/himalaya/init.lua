return {
  url = "https://git.sr.ht/~soywod/himalaya-vim",
  config = function()
    vim.g.himalaya_executable = "/usr/bin/himalaya"
    vim.g.himalaya_folder_picker = "telescope"
    vim.g.himalaya_folder_picker_telescope_preview = 1
  end
}
