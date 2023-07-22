local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

------------
-- General -
------------

-- jk in insert mode for escape
keymap("i", "jk", "<ESC>", default_opts)

-- quickly save and exit
keymap("n", "<leader>q", ":q<CR>", default_opts)
keymap("n", "<leader>Q", ":qall<CR>", default_opts)
keymap("n", "<leader>w", ":w<CR>", default_opts)

-- unhighlight search and clear command bar
keymap("n", "<ESC>", ":nohlsearch<CR>:echo<CR>", default_opts)

-- j/k move within a wrapped line
keymap("n", "j", "gj", default_opts)
keymap("n", "k", "gk", default_opts)
keymap("n", "gj", "j", default_opts)
keymap("n", "gk", "k", default_opts)


--------
-- LSP -
--------  defined in plugin file



--------------
-- telescope -
--------------  defined in plugin file



--------------
-- nvim-tree -
--------------  defined in plugin file



