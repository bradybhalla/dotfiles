require("which-key").add({
    {
        -- behavior
        { ">", ">gv", mode = "v" },
        { "<", "<gv", mode = "v" },
    },

    {
        -- moving between items
        { "]q", "<CMD>cnext<CR>", desc = "next quickfix" },
        { "[q", "<CMD>cprev<CR>", desc = "previous quickfix" },
        { "]b", "<CMD>bnext<CR>", desc = "next buffer" },
        { "[b", "<CMD>bprev<CR>", desc = "previous buffer" },
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
        { "<S-TAB>", function() require("luasnip").expand() end, mode = "i" },
        { "<C-n>",   function() require("luasnip").jump(1) end,  mode = { "i", "s" } },
        { "<C-p>",   function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
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
        { "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>",          desc = "document symbols" },
        { "<leader>lS", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "workspace symbols" },

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

        { "<leader>dt", function() require("dapui").toggle() end,          desc = "toggle ui" },
        { "<leader>dx", function() require("dap").disconnect() end,        desc = "stop" },
        { "<leader>dr", function() require("dap").restart() end,           desc = "restart" },

        { "<leader>db", "<CMD>DapToggleBreakpoint<CR>",                    desc = "toggle breakpoint" },
        { "<leader>dB", function() require("dap").clear_breakpoints() end, desc = "clear breakpoints" },

        { "<leader>dc", "<CMD>DapContinue<CR>",                            desc = "continue" },
        { "<leader>do", "<CMD>DapStepOver<CR>",                            desc = "step over" },
        { "<leader>di", "<CMD>DapStepInto<CR>",                            desc = "step into" },
        { "<leader>dO", "<CMD>DapStepOut<CR>",                             desc = "step out" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,     desc = "run to cursor" },
        { "<leader>ds", function() require("dap").goto_() end,             desc = "skip to cursor" },

        { "<leader>df", function() require("dap").focus_frame() end,       desc = "find current line" },
    },

})
