local augroup = require("utility.augroup").augroup

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
