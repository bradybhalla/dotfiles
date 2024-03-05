-------------
-- Behavior -
-------------

-- reselect after indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- j/k move within a wrapped line
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set({ "n", "v" }, "gj", "j")
vim.keymap.set({ "n", "v" }, "gk", "k")

-- unhighlight search and clear command bar
vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR><CMD>echo<CR>")


--------------
-- Shortcuts -
--------------

-- save and quit
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>", { desc = "quit" })
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "save" })

-- use system clipboard register
vim.keymap.set({ "n", "v" }, "<leader>c", "\"+", { desc = "use system clipboard" })

-- custom command shortcuts
vim.keymap.set("n", "<leader>O", "<CMD>OpenFinder<CR>", { desc = "reveal in Finder" })
vim.keymap.set("n", "<leader>S", "<CMD>ToggleSpell<CR>", { desc = "toggle spellcheck" })
vim.keymap.set("n", "<leader>G", "<CMD>Lazygit<CR>", { desc = "open lazygit" })

----------------
-- LSP/linting -
----------------  defined in plugins/mason/keymaps.lua

--------
-- cmp -
--------  defined in plugins/completion.lua

--------------
-- telescope -
--------------  defined in plugins/telescope.lua

--------------
-- nvim-tree -
--------------  defined in plugins/filetree.lua

-- more from treesitter (incremental selection), vim surround, latex, etc.
