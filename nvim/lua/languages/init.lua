vim.cmd("packadd nvim-lspconfig")
require("languages.lsp")

-- Load language configs only when that filetype is opened
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	once = true,
	callback = function()
		require("languages.lua")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "nix",
	once = true,
	callback = function()
		require("languages.nix")
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	once = true,
	callback = function()
		require("languages.python")
	end,
})
