-- line no
vim.o.number = true
vim.o.relativenumber = true

-- gutters
vim.o.signcolumn = "yes"

-- undo/redo
vim.o.undofile = true

-- automatic reload
vim.o.autoread = true

-- tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

