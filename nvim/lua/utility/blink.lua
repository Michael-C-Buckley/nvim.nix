vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.cmd("packadd blink.cmp")
		vim.cmd("packadd LuaSnip")
		vim.cmd("packadd friendly-snippets")
		require("blink.cmp").setup({ snippets = { preset = "luasnip" } })
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
})
