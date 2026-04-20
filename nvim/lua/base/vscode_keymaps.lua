-- Inspiration from Nick Maslov
-- https://medium.com/@nikmas_dev/vscode-neovim-setup-keyboard-centric-powerful-reliable-clean-and-aesthetic-development-582d34297985

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local nv = { "n", "v" }

local vsc_action = function(action)
	return "<cmd>lua require('vscode').action('" .. action .. "')<CR>"
end

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- yank to system clipboard
keymap(nv, "<leader>y", '"+y', opts)

-- paste from system clipboard
keymap(nv, "<leader>p", '"+p', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- call vscode commands from neovim

-- general keymaps
keymap(nv, "<leader>t", vsc_action("workbench.action.terminal.toggleTerminal"))
keymap(nv, "<leader>b", vsc_action("editor.debug.action.toggleBreakpoint"))
keymap(nv, "<leader>d", vsc_action("editor.action.showHover"))
keymap(nv, "<leader>a", vsc_action("editor.action.quickFix"))
keymap(nv, "<leader>sp", vsc_action("workbench.actions.view.problems"))
keymap(nv, "<leader>cn", vsc_action("notifications.clearAll"))
keymap(nv, "<leader>cp", vsc_action("workbench.action.showCommands"))
keymap(nv, "<leader>pr", vsc_action("code-runner.run"))
keymap(nv, "<leader>fd", vsc_action("editor.action.formatDocument"))
keymap(nv, "<leader>ff", vsc_action("workbench.action.quickOpen"))

-- harpoon keymaps
keymap(nv, "<leader>ha", vsc_action("vscode-harpoon.addEditor"))
keymap(nv, "<leader>ho", vsc_action("vscode-harpoon.editorQuickPick"))
keymap(nv, "<leader>he", vsc_action("vscode-harpoon.editEditors"))
keymap(nv, "<leader>h1", vsc_action("vscode-harpoon.gotoEditor1"))
keymap(nv, "<leader>h2", vsc_action("vscode-harpoon.gotoEditor2"))
keymap(nv, "<leader>h3", vsc_action("vscode-harpoon.gotoEditor3"))
keymap(nv, "<leader>h4", vsc_action("vscode-harpoon.gotoEditor4"))
keymap(nv, "<leader>h5", vsc_action("vscode-harpoon.gotoEditor5"))
keymap(nv, "<leader>h6", vsc_action("vscode-harpoon.gotoEditor6"))
keymap(nv, "<leader>h7", vsc_action("vscode-harpoon.gotoEditor7"))
keymap(nv, "<leader>h8", vsc_action("vscode-harpoon.gotoEditor8"))
keymap(nv, "<leader>h9", vsc_action("vscode-harpoon.gotoEditor9"))

-- project manager keymaps
keymap(nv, "<leader>pa", vsc_action("projectManager.saveProject"))
keymap(nv, "<leader>po", vsc_action("projectManager.listProjectsNewWindow"))
keymap(nv, "<leader>pe", vsc_action("projectManager.editProjects"))
