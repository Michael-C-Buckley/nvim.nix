local lsp = require("languages.lsp")
local dap = require("dap")
local dapui = require("dapui")
local dap_python = require("dap-python")

-- ── LSP ──────────────────────────────────────────────────────────────────────

vim.lsp.config("basedpyright", {
	capabilities = lsp.capabilities,
	settings = {
		basedpyright = {
			typeCheckingMode = "standard",
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
})

vim.lsp.config("ruff", {
	capabilities = lsp.capabilities,
	on_attach = function(client)
		-- Disable hover so basedpyright handles it instead
		client.server_capabilities.hoverProvider = false
	end,
})

vim.lsp.enable("basedpyright")
vim.lsp.enable("ruff")

-- ── DAP adapter (via nvim-dap-python) ────────────────────────────────────────
-- Handles adapter registration AND virtualenv-aware pythonPath automatically
dap_python.setup(vim.g.python3_host_prog)
dap_python.test_runner = "pytest"

-- ── Additional launch configurations ─────────────────────────────────────────
-- nvim-dap-python already registers a "Launch file" and test configs;
-- we append extra useful ones.

table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "Launch file with arguments",
	program = "${file}",
	args = function()
		local input = vim.fn.input("Arguments: ")
		return vim.split(input, " ", { trimempty = true })
	end,
})

table.insert(dap.configurations.python, {
	type = "python",
	request = "launch",
	name = "Launch module (-m)",
	module = function()
		return vim.fn.input("Module name: ")
	end,
})

table.insert(dap.configurations.python, {
	type = "python",
	request = "attach",
	name = "Attach to running process",
	connect = {
		host = "127.0.0.1",
		port = function()
			return tonumber(vim.fn.input("Port [5678]: ")) or 5678
		end,
	},
})

-- ── DAP-UI setup + auto open/close ──────────────────────────────────────────

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.4 },
				{ id = "breakpoints", size = 0.15 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.2 },
			},
			size = 50,
			position = "left",
		},
		{
			elements = {
				{ id = "repl", size = 0.5 },
				{ id = "console", size = 0.5 },
			},
			size = 12,
			position = "bottom",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
-- On session end, close only the sidebar (layout 1) but keep the bottom
-- console/repl panel (layout 2) open so print() output persists.
-- Use <leader>du to dismiss it when you're done.
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- ── Breakpoint signs ─────────────────────────────────────────────────────────

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "◆", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
)
vim.fn.sign_define("DapLogPoint", { text = "◉", texthl = "DapLogPoint", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

-- Highlight groups (subtle defaults; your colorscheme may override these)
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" })
vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e5c07b" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#5c6370" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e3b28" })

-- ── Keymaps ──────────────────────────────────────────────────────────────────

local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = "DAP: " .. desc })
end

-- Session control
map("n", "<F5>", dap.continue, "Continue / Start")
map("n", "<S-F5>", dap.terminate, "Terminate")
map("n", "<F9>", dap.restart, "Restart")
map("n", "<F10>", dap.step_over, "Step Over")
map("n", "<F11>", dap.step_into, "Step Into")
map("n", "<F12>", dap.step_out, "Step Out")

-- Breakpoints
map("n", "<leader>b", dap.toggle_breakpoint, "Toggle Breakpoint")
map("n", "<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Conditional Breakpoint")
map("n", "<leader>lp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, "Log Point")
map("n", "<leader>bc", dap.clear_breakpoints, "Clear All Breakpoints")

-- Navigation
map("n", "<leader>rc", dap.run_to_cursor, "Run to Cursor")

-- Inspection
map("n", "<leader>dh", dapui.eval, "Hover / Evaluate")
map("v", "<leader>dh", dapui.eval, "Evaluate Selection")
map("n", "<leader>dp", function()
	dapui.eval(vim.fn.input("Expression: "))
end, "Evaluate Expression")

-- UI & REPL
map("n", "<leader>du", dapui.toggle, "Toggle DAP UI")
map("n", "<leader>dr", dap.repl.toggle, "Toggle REPL")

-- nvim-dap-python extras (test runners)
map("n", "<leader>dm", dap_python.test_method, "Debug Test Method")
map("n", "<leader>dc", dap_python.test_class, "Debug Test Class")
map("v", "<leader>ds", dap_python.debug_selection, "Debug Selection")
