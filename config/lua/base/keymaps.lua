vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = true
    vim.keymap.set(mode, lhs, rhs, opts)
end

local allModes = { "n", "i", "v", "c", "t", "o", "x", "s" }

-- Basics
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
map("n", "<leader>qq", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>")
map(allModes, "<F1>", "<Nop>") -- Disable F1

-- Buffer navigation
map(allModes, "<M-,>", ":bprevious<CR>")
map(allModes, "<M-.>", ":bnext<CR>")
map(allModes, "<M-w>", ":bdelete<CR>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move lines
map("v", "J", ":m '>+1<cr>gv=gv")
map("v", "K", ":m '<-2<cr>gv=gv")
