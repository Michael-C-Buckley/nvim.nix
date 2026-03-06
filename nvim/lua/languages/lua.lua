local lsp = require("languages.lsp")

-- Lua LSP — for editing this config
vim.lsp.config("lua_ls", {
	cmd = { "lua-lsp" },
	capabilities = lsp.capabilities,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})

vim.lsp.enable("lua_ls")
