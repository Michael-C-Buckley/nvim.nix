local augroup = require("utility.augroup").augroup
local lsp = require("languages.lsp")

-- Nix files: 2 space indent
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("nix_indent"),
    pattern = "nix",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
    end,
})

-- Nil ---------------------------

vim.lsp.config("nil_ls", {
    capabilities = lsp.capabilities,
    settings = {
        ["nil"] = {
            formatting = { command = { "alejandra" } },
            nix = { flake = { autoArchive = true } },
        },
    },
})

vim.lsp.enable("nil_ls")

-- Nixd ---------------------------

vim.lsp.config("nixd", {
    cmd = { "nixd" },
    root_dir = vim.fn.getcwd(),
    settings = {
        nixd = {
            enableFormatting = false,
            diagnostics = true,
        },
    },
})

vim.lsp.enable("nixd")
