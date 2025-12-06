vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = "yes" -- stop text from shifting

vim.opt.tabstop        = 4     -- tab size 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true -- use spaces instead of tabs

vim.opt.ignorecase     = true -- searching case sensitivity
vim.opt.smartcase      = true

vim.opt.breakindent    = true -- wrapping behavior
vim.opt.linebreak      = true
vim.opt.smoothscroll   = true

vim.opt.splitright     = true
vim.opt.splitbelow     = true

vim.g.netrw_banner     = 0   -- don't show netrw help

vim.g.mapleader        = " " -- set leader

require("./plugins")         -- load and setup plugins

vim.cmd.colorscheme "catppuccin-frappe"
vim.cmd [[ hi TreesitterContextBottom gui=none ]] -- don't underline nvim context


require("which-key").add({
    -- editing behavior
    { ">",         ">gv",                                                              mode = "v" },
    { "<",         "<gv",                                                              mode = "v" },
    { "j",         "gj",                                                               mode = { "n", "v" } },
    { "gj",        "j",                                                                mode = { "n", "v" } },
    { "k",         "gk",                                                               mode = { "n", "v" } },
    { "gk",        "k",                                                                mode = { "n", "v" } },

    -- misc shortcuts
    { "<leader>q", "<CMD>quit<CR>",                                                    desc = "quit" },
    { "<leader>s", "<CMD>write<CR>",                                                   desc = "save" },
    { "<leader>w", "<C-w>" },
    { "<leader>c", "\"+",                                                              mode = { "n", "v" } },
    { "<leader>S", function() vim.opt_local.spell = not vim.opt_local.spell:get() end, desc = "toggle spellcheck" },
    {
        "<leader>g",
        function()
            local dir = vim.fn.expand("%:h")
            if vim.fn.isdirectory(dir) == 0 then
                dir = "."
            end
            require("toggleterm.terminal").Terminal:new({
                cmd = "lazygit",
                hidden = true,
                direction = "float",
                dir = dir,
                count = 99
            }):toggle()
        end,
        desc = "lazygit"
    },

    -- directory viewer
    { "<leader>d",  group = "directory" },
    { "<leader>df", "<CMD>vsplit %:h<CR>", desc = "current file directory" },
    { "<leader>dw", "<CMD>vsplit .<CR>",   desc = "working directory" },
    {
        "<leader>do",
        function()
            local file_path = vim.fn.expand("%")
            if file_path ~= "" then
                _, _ = pcall(vim.system, { "open", "-R", file_path }, {})
            else
                _, _ = pcall(vim.system, { "open", vim.fn.expand("%:p:h") }, {})
            end
        end,
        desc = "open in Finder"
    },

    -- telescope
    { "<leader>f",  group = "telescope" },
    { "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>",                desc = "find files" },
    { "<leader>fi", "<CMD>Telescope find_files hidden=true no_ignore=true<CR>", desc = "find files (no ignore)" },
    { "<leader>fg", "<CMD>Telescope live_grep<CR>",                             desc = "search text" },
    { "<leader>fb", "<CMD>Telescope buffers<CR>",                               desc = "find buffer" },
    { "<leader>fh", "<CMD>Telescope help_tags<CR>",                             desc = "search nvim help" },

    -- language / lsp
    { "<leader>l",  group = "language" },
    {
        "<leader>lf",
        function()
            require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "format"
    },
    { "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>",                                                         desc = "search document symbols" },
    { "<leader>lS", "<CMD>Telescope lsp_workspace_symbols<CR>",                                                        desc = "search workspace symbols" },

    -- luasnip
    { "<S-TAB>",    function() require("luasnip").expand() end,                                                        mode = "i" },
    { "<C-j>",      function() require("luasnip").jump(1) end,                                                         mode = { "i", "s" } },
    { "<C-k>",      function() require("luasnip").jump(-1) end,                                                        mode = { "i", "s" } },
    { "<C-e>",      function() if require("luasnip").choice_active() then require("luasnip").change_choice(1) end end, mode = { "i", "s" } }
})
