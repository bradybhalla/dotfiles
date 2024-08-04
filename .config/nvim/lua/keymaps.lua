require("which-key").add({
    {
        -- behavior
        { ">", ">gv", mode = "v" },
        { "<", "<gv", mode = "v" },
    },

    {
        -- general shortcuts
        { "<leader>q", "<CMD>q<CR>",            desc = "quit" },
        { "<leader>w", "<CMD>w<CR>",            desc = "save" },
        { "<leader>c", "\"+",                   desc = "system clipboard", mode = { "n", "v" } },
        { "<leader>O", "<CMD>OpenFinder<CR>",   desc = "open finder" },
        { "<leader>S", "<CMD>ToggleSpell<CR>",  desc = "toggle spellcheck" },
        { "<leader>G", "<CMD>Lazygit<CR>",      desc = "lazygit" },
        { "<leader>F", "<CMD>FormatBuffer<CR>", desc = "format buffer" },
    },

    {
        -- luasnip
        { "<S-TAB>", "<CMD>lua require'luasnip'.expand()<CR>",         mode = "i" },
        { "<C-n>",   "<CMD>lua require'luasnip'.jump(1)<CR>",          mode = { "i", "s" } },
        { "<C-p>",   "<CMD>lua require'luasnip'.jump(-1)<CR>",         mode = { "i", "s" } },
        { "<C-e>",   "<CMD>lua require'luasnip'.change_choice(1)<CR>", mode = { "i", "s" } },
        {
            "<C-e>",
            function()
                if require("luasnip").choice_active() then
                    require("luasnip").change_choice(1)
                end
            end,
            mode = { "i", "s" }
        },
    },

    {
        -- telescope
        { "<leader>f",  group = "telescope" },
        { "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>",                desc = "find file" },
        { "<leader>fa", "<CMD>Telescope find_files hidden=true no_ignore=true<CR>", desc = "find file (no ignore)" },
        { "<leader>fg", "<CMD>Telescope live_grep<CR>",                             desc = "find text" },
        { "<leader>fb", "<CMD>Telescope buffers<CR>",                               desc = "find buffer" },
        { "<leader>fh", "<CMD>Telescope help_tags<CR>",                             desc = "search help" },
        { "<leader>ft", "<CMD>Telescope builtin<CR>",                               desc = "telescope builtin" },
    },

    {
        -- lsp
        { "<leader>l",  group = "lsp" },
        { "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>",          desc = "lsp document symbols" },
        { "<leader>lS", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "lsp workspace symbols" },

        { "<C-]>",      "<CMD>Telescope lsp_definitions<CR>" },
        { "grr",        "<CMD>Telescope lsp_references<CR>" },
        { "<C-l>",      vim.lsp.buf.signature_help,                         mode = "i" },

        {
            -- TODO remove. these will supposedly be default keymaps later
            { "grn",   vim.lsp.buf.rename },
            { "gra",   vim.lsp.buf.code_action },
            { "<C-s>", vim.lsp.buf.signature_help, mode = "i" },
        },
    },

    {
        -- filetree
        { "<leader>e",  group = "filetree" },
        { "<leader>ef", "<CMD>NvimTreeFindFile<CR>", desc = "show file" },
        { "<leader>eo", "<CMD>NvimTreeOpen<CR>",     desc = "open" },
        { "<leader>ec", "<CMD>NvimTreeClose<CR>",    desc = "close" },
    },

    {
        -- debugger
        { "<leader>d",  group = "debugger" },

        { "<leader>dt", "<CMD>lua require'dapui'.toggle()<CR>",          desc = "toggle ui" },
        { "<leader>dx", "<CMD>lua require'dap'.disconnect()<CR>",        desc = "stop" },
        { "<leader>dr", "<CMD>lua require'dap'.restart()<CR>",           desc = "restart" },

        { "<leader>db", "<CMD>DapToggleBreakpoint<CR>",                  desc = "toggle breakpoint" },
        { "<leader>dB", "<CMD>lua require'dap'.clear_breakpoints()<CR>", desc = "clear breakpoints" },

        { "<leader>dc", "<CMD>DapContinue<CR>",                          desc = "continue" },
        { "<leader>do", "<CMD>DapStepOver<CR>",                          desc = "step over" },
        { "<leader>di", "<CMD>DapStepInto<CR>",                          desc = "step into" },
        { "<leader>dO", "<CMD>DapStepOut<CR>",                           desc = "step out" },
        { "<leader>dC", "<CMD>lua require'dap'.run_to_cursor()<CR>",     desc = "run to cursor" },
        { "<leader>ds", "<CMD>lua require'dap'.goto_()<CR>",             desc = "skip to cursor" },

        { "<leader>df", "<CMD>lua require'dap'.focus_frame()<CR>",       desc = "find current line" },
    },

})
