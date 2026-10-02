-- lsp
vim.lsp.enable({ "clangd" })
vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Actions and Navigation',
  callback = function(event)
    -- Helper to quickly set buffer-local keymaps
    local map = function(modes, lhs, rhs, desc)
      vim.keymap.set(modes, lhs, rhs, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- =========================================================================
    -- THE COMMON "GO TO" COMMANDS
    -- =========================================================================

    -- Jump to the definition of the symbol under the cursor
    map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')

    -- Jump to the declaration (useful in C/C++ header files)
    map('n', 'gD', vim.lsp.buf.declaration, 'Go to Declaration')

    -- Jump to the implementation (useful for interfaces/abstract classes)
    map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')

    -- Jump to the definition of the underlying type
    map('n', 'go', vim.lsp.buf.type_definition, 'Go to Type Definition')

    -- List all references to the symbol in the quickfix list
    map('n', 'gr', vim.lsp.buf.references, 'Go to References')

    -- =========================================================================
    -- DOCUMENTATION & ASSISTANCE
    -- =========================================================================

    -- Show hover information (documentation/types)
    map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')

    -- Show signature help (function arguments) in insert/normal mode
    map({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
  end,
})

vim.cmd("set completeopt+=noselect")

