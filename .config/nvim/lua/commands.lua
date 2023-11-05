vim.api.nvim_create_user_command("SetupTreesitter", function()
    vim.cmd(":TSInstall c lua python json typescript javascript latex")
end, { desc = "Treesitter setup" })

vim.api.nvim_create_user_command("SetupMason", function()
    vim.cmd(":MasonInstall pyright lua-language-server typescript-language-server clangd texlab black beautysh prettier")
end, { desc = "Mason setup" })

vim.api.nvim_create_user_command("Setup", function()
    vim.cmd(":SetupTreesitter")
    vim.cmd(":SetupMason")
end, { desc = "Setup" })
