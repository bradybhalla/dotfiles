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


--------------
-- telescope -
--------------  defined in plugin file



--------------
-- nvim-tree -
--------------  defined in plugin file




----------
-- Other -
----------

-- disable arrows :(
vim.cmd([[

nnoremap <Left> :echo "No left for you!"<CR>
vnoremap <Left> :<C-u>echo "No left for you!"<CR>
inoremap <Left> <C-o>:echo "No left for you!"<CR>


nnoremap <Right> :echo "No right for you!"<CR>
vnoremap <Right> :<C-u>echo "No right for you!"<CR>
inoremap <Right> <C-o>:echo "No right for you!"<CR>


nnoremap <Up> :echo "No up for you!"<CR>
vnoremap <Up> :<C-u>echo "No up for you!"<CR>
inoremap <Up> <C-o>:echo "No up for you!"<CR>


nnoremap <Down> :echo "No down for you!"<CR>
vnoremap <Down> :<C-u>echo "No down for you!"<CR>
inoremap <Down> <C-o>:echo "No down for you!"<CR>

]])

