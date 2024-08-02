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

require("which-key").add({
    { "<leader>q",  "<CMD>q<CR>",                                               desc = "quit" },
    { "<leader>w",  "<CMD>w<CR>",                                               desc = "save" },
    { "<leader>c",  "\"+",                                                      desc = "system clipboard",     mode = { "n", "v" } },
    { "<leader>O",  "<CMD>OpenFinder<CR>",                                      desc = "open finder" },
    { "<leader>S",  "<CMD>ToggleSpell<CR>",                                     desc = "toggle spellcheck" },
    { "<leader>G",  "<CMD>Lazygit<CR>",                                         desc = "lazygit" },
    { "<leader>F",  "<CMD>FormatBuffer<CR>",                                    desc = "format buffer" },

    ----------------------------------------

    { "<leader>f",  group = "telescope" },

    { "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>",                desc = "find file" },
    { "<leader>fa", "<CMD>Telescope find_files hidden=true no_ignore=true<CR>", desc = "find file (no ignore)" },
    { "<leader>fg", "<CMD>Telescope live_grep<CR>",                             desc = "find text" },
    { "<leader>fb", "<CMD>Telescope buffers<CR>",                               desc = "find buffer" },
    { "<leader>fh", "<CMD>Telescope help_tags<CR>",                             desc = "search help" },

    { "<leader>fd", "<CMD>Telescope lsp_definitions<CR>",                       desc = "lsp definitions" },
    { "<leader>fr", "<CMD>Telescope lsp_references<CR>",                        desc = "lsp references" },
    { "<leader>fs", "<CMD>Telescope lsp_document_symbols<CR>",                  desc = "lsp document symbols" },
    { "<leader>fS", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",         desc = "lsp workspace symbols" },

    { "<leader>ft", "<CMD>Telescope builtin<CR>",                               desc = "telescope builtin" },

    ----------------------------------------

    { "<leader>e",  group = "filetree" },

    { "<leader>ef", "<CMD>NvimTreeFindFile<CR>",                                desc = "show file" },
    { "<leader>eo", "<CMD>NvimTreeOpen<CR>",                                    desc = "open" },
    { "<leader>ec", "<CMD>NvimTreeClose<CR>",                                   desc = "close" },

    ----------------------------------------

    { "<leader>d",  group = "debugger" },

    { "<leader>dt", "<CMD>lua require'dapui'.toggle()<CR>",                     desc = "toggle ui" },
    { "<leader>dx", "<CMD>lua require'dap'.disconnect()<CR>",                   desc = "stop" },
    { "<leader>dr", "<CMD>lua require'dap'.restart()<CR>",                      desc = "restart" },

    { "<leader>db", "<CMD>DapToggleBreakpoint<CR>",                             desc = "toggle breakpoint" },
    { "<leader>dB", "<CMD>lua require'dap'.clear_breakpoints()<CR>",            desc = "clear breakpoints" },

    { "<leader>dc", "<CMD>DapContinue<CR>",                                     desc = "continue" },
    { "<leader>do", "<CMD>DapStepOver<CR>",                                     desc = "step over" },
    { "<leader>di", "<CMD>DapStepInto<CR>",                                     desc = "step into" },
    { "<leader>dO", "<CMD>DapStepOut<CR>",                                      desc = "step out" },
    { "<leader>dC", "<CMD>lua require'dap'.run_to_cursor()<CR>",                desc = "run to cursor" },
    { "<leader>ds", "<CMD>lua require'dap'.goto_()<CR>",                        desc = "skip to cursor" },

    { "<leader>df", "<CMD>lua require'dap'.focus_frame()<CR>",                  desc = "find current line" },

})

-- TODO these will supposedly be default keymaps later
vim.keymap.set("n", "grn", vim.lsp.buf.rename)
vim.keymap.set("n", "gra", vim.lsp.buf.code_action)
vim.keymap.set("n", "grr", vim.lsp.buf.references)
vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help)
