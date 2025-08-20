return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = { theme = "auto", section_separators = "", component_separators = "|", globalstatus = true },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "diagnostics" },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
    },
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  { "folke/which-key.nvim",    opts = {} },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('bufferline').setup {}
    end
  },
}
