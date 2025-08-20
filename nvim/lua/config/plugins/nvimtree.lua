return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeOpen" },
  opts = {
    view = { width = 36 },
    renderer = { highlight_git = true, group_empty = true },
    filters = { dotfiles = false },
    actions = {
      open_file = { quit_on_open = false },
      system_open = { cmd = nil },
    },
    git = { ignore = false },
  },
}

