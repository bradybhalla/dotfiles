-- set leader key
vim.g.mapleader          = " "

-- line numbers
vim.opt.number           = true
vim.opt.relativenumber   = true
vim.opt.signcolumn       = "yes"

-- tabs
vim.opt.tabstop          = 4
vim.opt.softtabstop      = 4
vim.opt.shiftwidth       = 4
vim.opt.expandtab        = true

-- wrapping
vim.opt.breakindent      = true
vim.opt.linebreak        = true

-- split pane location
vim.opt.splitright       = true
vim.opt.splitbelow       = true

-- fix filetype settings
vim.g.filetype_pl        = "prolog"

-- make sure nvim can access the correct python
vim.g.python3_host_prog  = "/usr/bin/python3"

-- nvim-tree says to do this
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors    = true
----------------------------
