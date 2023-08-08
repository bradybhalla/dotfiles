-------------
-- Behavior -
-------------

-- reselect after indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- j/k move within a wrapped line
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "gk", "k")

-- unhighlight search and clear command bar
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR><CMD>echo<CR>")


--------------
-- Shortcuts -
--------------

-- save and exit
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>", { desc = "quit" })
vim.keymap.set("n", "<leader>Q", "<CMD>qall<CR>", { desc = "quit all" })
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "save" })

-- use system clipboard register
vim.keymap.set({ "n", "v" }, "<leader>c", "\"+", { desc = "use system clipboard" })

-- change instances of the same text (n. to repeat)
vim.keymap.set("n", "<leader>d", "\"dyiw/\\<<C-r>d\\><CR>Nzzgnc", { desc = "change word" })
vim.keymap.set("v", "<leader>d", "\"dy/<C-r>d<CR>Nzzgnc", { desc = "change selection" })

-- open directory in finder
vim.keymap.set("n", "<leader>O", "<CMD>silent !open $(dirname %)<CR>", { desc = "open directory" })

-- spellcheck
vim.keymap.set("n", "<leader>S", function()
    vim.opt_local.spell = not vim.opt_local.spell._value
end, { desc = "toggle spellcheck" })

-- lazygit popup
local Terminal = require("toggleterm.terminal").Terminal
local lazygit  = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

vim.keymap.set("n", "<leader>G", function()
    lazygit:toggle()
end, { desc = "lazygit" })

--------
-- LSP -
--------  defined in lsp/init.lua, lsp/handlers.lua

--------
-- cmp -
--------  defined in completion.lua

--------------
-- telescope -
--------------  defined in telescope.lua

--------------
-- nvim-tree -
--------------  defined in filetree.lua

-- text objects from treesitter (incremental selection), vim surround, etc.

-- latex configuration has additional keymaps
