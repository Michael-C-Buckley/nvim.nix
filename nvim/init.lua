-- If I'm running this in vscode then use this config
if vim.g.vscode then
	require("base.vscode_keymaps")
-- Everything else is the normal flow
else
	require("base")
	require("utility")
	require("languages")
	require("ui.mini")
	require("ayu").colorscheme()
end
