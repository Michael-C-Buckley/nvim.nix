local map = vim.keymap.set

-- Files
map("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Smart find files" })
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find files" })
map("n", "<leader>fr", function() Snacks.picker.recent() end, { desc = "Recent files" })

-- Search
map("n", "<leader>/", function() Snacks.picker.grep() end, { desc = "Grep" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers" })

-- LSP (replaces telescope for these)
map("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "LSP References" })
map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "LSP Definitions" })
