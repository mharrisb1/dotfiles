local map = vim.keymap.set


-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })
map("n", "<leader>e f", ":NvimTreeFindFile<CR>", { desc = "Reveal current file" })
map("n", "<leader>e n", ":NvimTreeCreate<CR>", { desc = "Create new file in nvim-tree" })
map("n", "<leader>e d", ":NvimTreeCreateDir<CR>", { desc = "Create new directory in nvim-tree" })


-- Telescope core binds (Helix-like "picker" feel)
map("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
map("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "Grep" })
map("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "Buffers" })
map("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "Help" })


-- Space + Space opens Telescope files
map("n", "<leader><leader>", require("telescope.builtin").find_files, { desc = "Open Telescope (files)" })


-- Treesitter-style selection expansion
map({"n","v"}, "gnn", function()
  require("nvim-treesitter.incremental_selection").init_selection()
end, { desc = "TS: init selection" })
map({"n","v"}, "g.", function()
  require("nvim-treesitter.incremental_selection").node_incremental()
end, { desc = "TS: expand selection" })
map({"n","v"}, "g,", function()
  require("nvim-treesitter.incremental_selection").node_decremental()
end, { desc = "TS: shrink selection" })
map({"n","v"}, "gs", function()
  require("nvim-treesitter.incremental_selection").scope_incremental()
end, { desc = "TS: scope selection" })


-- Diagnostics navigation
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>xx", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })


-- QoL
map({"n","x"}, "*", "*N", { desc = "Search word forward" })
map({"n","x"}, "#", "#N", { desc = "Search word backward" })
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })


-- Buffer management
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close buffer (:bc)" })
map("n", "<leader>ba", ":%bd|e#|bd#<CR>", { desc = "Close all buffers (:bca)" })
