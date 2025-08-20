return {
  -- LSP base
  { "neovim/nvim-lspconfig" },
  -- Installer
  { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        -- your installed set
        "lua_ls", "pyright", "ruff", "rust_analyzer", "gopls", "bashls", "jsonls", "html", "cssls", "yamlls",
        "clangd", "cmake", "marksman", "sqls", "tailwindcss"
      },
      automatic_installation = true,
    },
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "path" }, { name = "buffer" }, { name = "luasnip" } }),
      })
    end,
  },
  -- LSP servers setup
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lsp = require("lspconfig")

      local function on_attach(_, bufnr)
        local function bmap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        bmap("n", "gd", vim.lsp.buf.definition, "Goto definition")
        bmap("n", "gr", vim.lsp.buf.references, "References")
        bmap("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
        bmap("n", "K", vim.lsp.buf.hover, "Hover")
        bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        bmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
        bmap("n", "<leader>fd", function() vim.lsp.buf.format({ async = false }) end, "Format file")

        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
          callback = function() vim.diagnostic.open_float(nil, { focusable = false }) end,
        })
        -- Per-buffer format-on-save is kept, but we also have a global one in set.lua
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function() vim.lsp.buf.format({ async = false }) end,
        })
      end

      -- lua
      lsp.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false }, telemetry = { enable = false } } },
      })

      -- servers installed on your machine
      for _, name in ipairs({
        "pyright", "rust_analyzer", "gopls", "bashls", "jsonls", "html", "cssls", "yamlls",
        "clangd", "cmake", "marksman", "sqls", "tailwindcss"
      }) do
        lsp[name].setup({ capabilities = capabilities, on_attach = on_attach })
      end

      -- ruff (code actions / lint fixes)
      if lsp.ruff then
        lsp.ruff.setup({ capabilities = capabilities, on_attach = on_attach })
      end
    end,
  },
}
