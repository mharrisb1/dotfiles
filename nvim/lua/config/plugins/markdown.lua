return {
  "dhruvasagar/vim-table-mode",
  ft = { "markdown", "mdx", "vimwiki" },
  init = function()
    -- Cleaner corners for GitHub-style tables
    vim.g.table_mode_corner = "|"
    vim.g.table_mode_corner_corner = "|"
    vim.g.table_mode_always_active = 0
  end,
  config = function()
    -- Auto-enable & realign tables on save for Markdown-like files
    local grp = vim.api.nvim_create_augroup("TableModeMd", { clear = true })
    vim.api.nvim_create_autocmd("BufReadPost", {
      group = grp,
      pattern = { "*.md", "*.markdown", "*.mdx" },
      callback = function() vim.cmd([[silent! TableModeEnable]]) end,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = grp,
      pattern = { "*.md", "*.markdown", "*.mdx" },
      callback = function() vim.cmd([[silent! TableModeRealign]]) end,
    })
  end,
}
