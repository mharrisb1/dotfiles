return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash","c","cpp","css","dockerfile","go","html","java",
      "javascript","json","lua","markdown","python","rust","toml","tsx","typescript","yaml"
    },
    highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = { init_selection = "gnn", node_incremental = "g.", node_decremental = "g,", scope_incremental = "gs" },
    },
  },
}
