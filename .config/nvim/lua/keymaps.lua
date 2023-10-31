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

-- save and exit
vim.keymap.set("n", "<leader>q", "<CMD>q<CR>", { desc = "quit" })
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { desc = "save" })

-- use system clipboard register
vim.keymap.set({ "n", "v" }, "<leader>c", "\"+", { desc = "use system clipboard" })

-- open directory in finder
vim.keymap.set("n", "<leader>O", "<CMD>silent !open \"%:h\"<CR>", { desc = "open directory" })

-- toggle spellcheck
vim.keymap.set("n", "<leader>S", function()
    vim.opt_local.spell = not vim.opt_local.spell._value
end, { desc = "toggle spellcheck" })

-- toggleterm popups
local function toggleterm_popup(cmd)
    return function()
        local dir = vim.fn.expand("%:h")
        if vim.fn.isdirectory(dir) == 0 then
            dir = "."
        end

        require("toggleterm.terminal").Terminal:new({
            cmd = cmd,
            hidden = true,
            direction = "float",
            dir = dir,
            count = 99
        }):toggle()
    end
end
vim.keymap.set("n", "<leader>G", toggleterm_popup("lazygit"), { desc = "lazygit" })

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

-- set which-key prefixes
require("which-key").register({
        l = { name = "LSP" },
        f = { name = "telescope" },
        e = { name = "filetree" }
    },
    { prefix = "<leader>" }
)
