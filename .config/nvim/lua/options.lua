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

-- case sensitivity
vim.opt.ignorecase       = true
vim.opt.smartcase        = true

-- wrapping
vim.opt.breakindent      = true
vim.opt.linebreak        = true

-- split pane location
vim.opt.splitright       = true
vim.opt.splitbelow       = true

-- don't show insert in command line
vim.opt.showmode         = false

-- fix filetype settings
vim.g.filetype_pl        = "prolog"

-- nvim-tree says to do this
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors    = true
----------------------------
