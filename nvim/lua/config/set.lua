local opt = vim.opt

-- Tabs & indentation
opt.expandtab = true   -- Use spaces instead of tabs
opt.tabstop = 2        -- Number of spaces tabs count for
opt.shiftwidth = 2     -- Size of an indent
opt.softtabstop = 2    -- Number of spaces when pressing <Tab> in insert mode
opt.smartindent = true -- Insert indents automatically
opt.autoindent = true  -- Copy indent from current line when starting new one

-- Prevent auto-formatting on paste
opt.formatoptions:remove({ 'c', 'r', 'o' })

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Misc
opt.termguicolors = true
opt.wrap = false
opt.cursorline = true
opt.signcolumn = "yes"
opt.updatetime = 250

-- Clipboard integration
opt.clipboard = "unnamedplus"

-- Column guides
opt.colorcolumn = "80"

-- Diagnostics: keep buffer clean; use float popups
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = false,
  float = { border = "rounded" },
})

-- === Formatting on save for ALL LSPs (if supported) ===
local fmt_group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = fmt_group,
  callback = function(args)
    local bufnr = args.buf
    -- Prefer real formatter capability
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if client.supports_method and client:supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ async = false, bufnr = bufnr })
        return
      end
    end
    -- Fallback: trigger code action fixes for servers like ruff
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if client.name == "ruff" then
        -- Apply all available fixes (requires Neovim 0.9+)
        vim.lsp.buf.code_action({ context = { only = { "source.fixAll" } }, apply = true })
        return
      end
    end
  end,
})

-- Extra: organize imports for Go on save (gopls)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = fmt_group,
  pattern = { "*.go" },
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
  end,
})

-- Enable bracketed paste to preserve indentation when pasting
vim.cmd [[
  set t_BE=
]]

-- Paste toggle keymaps (F2 or <leader>tp)
vim.keymap.set("n", "<F2>", ":set paste! paste?<CR>", { silent = true, desc = "Toggle paste mode" })
vim.keymap.set("i", "<F2>", "<C-o>:set paste! paste?<CR>", { silent = true, desc = "Toggle paste mode" })
vim.keymap.set("n", "<leader>tp", ":set paste! paste?<CR>", { silent = true, desc = "Toggle paste mode" })
