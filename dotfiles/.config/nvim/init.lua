-- line numbers
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = "yes"

-- tabs
vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true

-- searching case sensitivity
vim.opt.ignorecase     = true
vim.opt.smartcase      = true

-- wrapping behavior
vim.opt.breakindent    = true
vim.opt.linebreak      = true
vim.opt.smoothscroll   = true

-- split pane location
vim.opt.splitright     = true
vim.opt.splitbelow     = true

-- netrw
vim.g.netrw_banner = 0

-- leader key
vim.g.mapleader        = " "

require("./plugins")

vim.cmd.colorscheme "catppuccin-frappe"

vim.keymap.set("n", "<leader>q", "<CMD>quit<CR>")

vim.keymap.set({"n", "v"}, "<leader>c", "\"+") -- system clipboard

-- terminal
-- TODO: maybe use ToggleTerm instead
vim.keymap.set("n", "<leader>t", "<CMD>tabnew | terminal<CR>i")
vim.keymap.set("n", "<leader>st", "<CMD>vsplit | terminal<CR>i")
vim.keymap.set("n", "<leader>g", "<CMD>tabnew | terminal lazygit<CR>i")
vim.keymap.set("n", "<leader>sg", "<CMD>vsplit | terminal lazygit<CR>i")

-- directory viewer
-- TODO: maybe use nvim-tree
vim.keymap.set("n", "<leader>df", "<CMD>vsplit %:h<CR>")
vim.keymap.set("n", "<leader>dd", "<CMD>vsplit .<CR>")

-- telescope
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>")
vim.keymap.set("n", "<leader>fi", "<CMD>Telescope find_files hidden=true no_ignore=true<CR>")
vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")

