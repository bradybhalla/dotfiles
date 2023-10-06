vim.g.mapleader          = " "

vim.opt.number           = true
vim.opt.relativenumber   = true

vim.opt.tabstop          = 4
vim.opt.softtabstop      = 4
vim.opt.shiftwidth       = 4
vim.opt.expandtab        = true

-- fix filetype settings
vim.g.filetype_pl        = "prolog"

-- make sure nvim can access the correct python
vim.g.python3_host_prog  = "/usr/bin/python3"

-- nvim-tree says to do this
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors    = true
----------------------------

-- custom commands
vim.api.nvim_create_user_command("Setup", function ()
    vim.cmd(":TSInstall c lua python json typescript javascript")
    vim.cmd(":MasonInstall pyright lua-language-server typescript-language-server texlab black beautysh")
end, {desc="Mason and Treesitter setup"})
