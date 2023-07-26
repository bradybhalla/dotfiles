local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

------------
-- General -
------------

-- jk in insert mode for escape
vim.keymap.set("i", "jk", "<ESC>")

-- quickly save and exit
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>")
vim.keymap.set("n", "<leader>Q", "<CMD>qall<CR>")
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>")

-- unhighlight search and clear command bar
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>:echo<CR>")

-- j/k move within a wrapped line
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")

-- jump to previous cursor position (tab to jump to next)
vim.keymap.set("n", "<leader>-", "<C-o>")

-- system clipboard
vim.keymap.set("n", "<leader>c", "\"*")
vim.keymap.set("v", "<leader>c", "\"*")

-- I accidentally type "q:" instead of ":q"
vim.keymap.set("n", "q:", ":q")
vim.keymap.set("n", "q<leader>", "<CMD>q<CR>")

-- natural text editing in insert mode
-- with "Natural Text Editing" presets in iTerm2
-- (disabled)
--
-- vim.keymap.set("i", "<C-a>", "<C-o>^")       -- command-arrow
-- vim.keymap.set("i", "<C-e>", "<C-o>$")
-- vim.keymap.set("i", "<ESC>b", "<C-o>B")      -- option-arrow
-- vim.keymap.set("i", "<ESC>f", "<C-o>E<C-o>l")




--------
-- LSP -
--------  defined in plugin file

--------
-- cmp -
--------  defined in plugin file

--------------
-- telescope -
--------------  defined in plugin file

--------------
-- nvim-tree -
--------------  defined in plugin file



