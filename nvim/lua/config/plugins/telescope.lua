return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
        layout_config = { horizontal = { preview_width = 0.6 } },
      },
      pickers = {
        find_files = { hidden = true },
      },
    }
  end,
}
