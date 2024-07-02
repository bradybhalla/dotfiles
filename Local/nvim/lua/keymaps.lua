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

-------------
-- Snippets -
-------------

vim.keymap.set({ "i" }, "<S-TAB>", "<CMD>lua require'luasnip'.expand()<CR>")
vim.keymap.set({ "i", "s" }, "<C-j>", "<CMD>lua require'luasnip'.jump(1)<CR>")
vim.keymap.set({ "i", "s" }, "<C-k>", "<CMD>lua require'luasnip'.jump(-1)<CR>")
vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
    end
end)

--------------
-- Shortcuts -
--------------

require("which-key").register({
    ["<leader>"] = {
        q = { "<CMD>q<CR>", "quit" },
        w = { "<CMD>w<CR>", "save" },
        c = { "\"+", "system clipboard", mode = { "n", "v" } },
        O = { "<CMD>OpenFinder<CR>", "open finder" },
        S = { "<CMD>ToggleSpell<CR>", "toggle spellcheck" },
        G = { "<CMD>Lazygit<CR>", "lazygit" },
        F = { "<CMD>FormatBuffer<CR>", "format buffer" }
    },

    ["<leader>f"] = {
        name = "telescope",

        f = { "<CMD>Telescope find_files hidden=true<CR>", "find file" },
        a = { "<CMD>Telescope find_files hidden=true no_ignore=true<CR>", "find file (no ignore)" },
        g = { "<CMD>Telescope live_grep<CR>", "find text" },
        b = { "<CMD>Telescope buffers<CR>", "find buffer" },
        h = { "<CMD>Telescope help_tags<CR>", "search help" },

        d = { "<CMD>Telescope lsp_definitions<CR>", "lsp definitions" },
        r = { "<CMD>Telescope lsp_references<CR>", "lsp references" },
        s = { "<CMD>Telescope lsp_document_symbols<CR>", "lsp document symbols" },
        S = { "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", "lsp workspace symbols" },

        t = { "<CMD>Telescope builtin<CR>", "telescope builtin" }
    },

    ["<leader>e"] = {
        name = "filetree",

        f = { "<CMD>NvimTreeFindFile<CR>", "show file" },
        o = { "<CMD>NvimTreeOpen<CR>", "open" },
        c = { "<CMD>NvimTreeClose<CR>", "close" }
    },

    ["<leader>d"] = {
        name = "debugger",

        t = { "<CMD>lua require'dapui'.toggle()<CR>", "toggle ui" },
        x = { "<CMD>lua require'dap'.disconnect()<CR>", "stop" },
        r = { "<CMD>lua require'dap'.restart()<CR>", "restart" },

        b = { "<CMD>DapToggleBreakpoint<CR>", "toggle breakpoint" },
        B = { "<CMD>lua require'dap'.clear_breakpoints()<CR>", "clear breakpoints" },

        c = { "<CMD>DapContinue<CR>", "continue" },
        o = { "<CMD>DapStepOver<CR>", "step over" },
        i = { "<CMD>DapStepInto<CR>", "step into" },
        O = { "<CMD>DapStepOut<CR>", "step out" },
        C = { "<CMD>lua require'dap'.run_to_cursor()<CR>", "run to cursor" },
        s = { "<CMD>lua require'dap'.goto_()<CR>", "skip to cursor" },

        f = { "<CMD>lua require'dap'.focus_frame()<CR>", "find current line" }
    }

})

-- TODO these will supposedly be default keymaps later
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
