vim.keymap.set("n", "-", function()
	vim.cmd("packadd oil.nvim")
	local oil = require("oil")
	oil.setup({ view_options = { show_hidden = true } })
	-- Replace stub with direct call so subsequent uses skip setup
	vim.keymap.set("n", "-", oil.open, { desc = "Open parent directory" })
	oil.open()
end, { desc = "Open parent directory" })
