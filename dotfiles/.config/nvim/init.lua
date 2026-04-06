--------------------
-- Install plugins -
--------------------

-- to delete manually, remove from ~/.local/share/nvim/site/pack/core/opt
vim.pack.add({
    -- interface
    "https://github.com/catppuccin/nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim", -- dependency for telescope
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-mini/mini.icons", -- dependency for oil

    -- editing
    "https://github.com/tpope/vim-surround",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/L3MON4D3/LuaSnip",
    { src = "https://github.com/saghen/blink.cmp", version = "v1.5.0" }, -- new versions don't install binary correctly

    -- language tools
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/mfussenegger/nvim-jdtls",
    "https://github.com/tarides/ocaml.nvim",

    -- misc
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/lervag/vimtex",
    "https://github.com/folke/which-key.nvim",
})

---------------------------
-- General configuration -
---------------------------

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = "yes" -- stop text from shifting

vim.opt.tabstop        = 4     -- tab size 4
vim.opt.shiftwidth     = 0     -- use tabstop
vim.opt.expandtab      = true  -- use spaces instead of tabs

vim.opt.ignorecase     = true  -- search case sensitivity
vim.opt.smartcase      = true

vim.opt.breakindent    = true -- wrapping behavior
vim.opt.linebreak      = true
vim.opt.smoothscroll   = true

vim.opt.splitright     = true -- window splitting direction
vim.opt.splitbelow     = true

vim.opt.spellsuggest   = "9" -- max 9 items in z= (which-key overrides it)

vim.g.mapleader        = " " -- set leader key

require("./interface")       -- colorscheme, navigation, ...
require("./editing")         -- completion, keymap modifications, ...
require("./language-tools")  -- lsp, treesitter, formatters, ...
require("./misc-plugins")

local utils = require("./utils")
require("which-key").add({
    { "<leader>o",  "<CMD>Oil<CR>",                                             desc = "Oil" },
    { "<leader>G",  utils.lazygit,                                              desc = "Lazygit" },
    { "<leader>c",  "\"+",                                                      mode = { "n", "v" } },

    { "<leader>q",  group = "quit" },
    { "<leader>qq", "<CMD>qall<CR>",                                            desc = "quit" },
    { "<leader>qs", "<CMD>wqall<CR>",                                           desc = "save and quit" },

    { "<leader>f",  group = "file" },
    { "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>",                desc = "find file" },
    { "<leader>fh", "<CMD>Telescope find_files hidden=true no_ignore=true<CR>", desc = "find hidden file" },
    { "<leader>fs", "<CMD>write<CR>",                                           desc = "save file" },
    { "<leader>fo", utils.open_file_in_finder,                                  desc = "open file in Finder" },

    { "<leader>b",  group = "buffer" },
    { "<leader>bb", "<CMD>Telescope buffers<CR>",                               desc = "find buffer" },
    { "<leader>bd", "<CMD>bdelete<CR>",                                         desc = "delete buffer" },

    { "<leader>w",  "<C-w>",                                                    desc = "window" },
    { "<leader>wd", "<CMD>close<CR>",                                           desc = "close window" },

    { "<leader>g",  group = "grep" },
    { "<leader>gg", "<CMD>Telescope live_grep<CR>",                             desc = "search text" },

    { "<leader>l",  group = "language" },
    { "<leader>lf", function() require("conform").format() end,                 desc = "format buffer" },
    { "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>",                  desc = "search document symbols" },
    { "<leader>lS", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>",         desc = "search workspace symbols" },

    { "<leader>h",  group = "help" },
    { "<leader>hh", "<CMD>Telescope help_tags<CR>",                             desc = "search help" },

    { "<leader>t",  group = "toggle" },
    { "<leader>ts", utils.toggle_spellcheck,                                    desc = "toggle spellcheck" },
    { "<leader>td", utils.toggle_diagnostic_virtual_text,                       desc = "toggle diagnostic virtual text" },
})


------------------------------------
-- Filetype-specific configuration -
------------------------------------

-- LaTeX
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.latex", {}),
    pattern = "tex",
    callback = function(args)
        -- build and show current document
        vim.keymap.set("n", "<leader>b", "<CMD>w<CR><CMD>VimtexCompileSS -pdf -pv<CR>", { buffer = args.buf })

        -- toggle conceal
        vim.keymap.set("n", "<leader>tc", function()
            vim.opt.conceallevel = 2 - vim.opt.conceallevel:get()
        end, { buffer = true })
    end
})


-- Typst
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.typst", {}),
    pattern = "typst",
    callback = function(args)
        vim.keymap.set("n", "<leader>b", "<CMD>silent !open -a Skim %:r.pdf<CR>", { buffer = args.buf })
    end
})


-- Java
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.java", {}),
    pattern = "java",
    callback = function()
        require("jdtls").start_or_attach({ cmd = { "jdtls" } })
    end
})


-- OCaml
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.ocaml", {}),
    pattern = { "ocaml", "dune" },
    callback = function(args)
        vim.opt_local.tabstop = 2
        require("which-key").add({
            { "<C-c><C-a>", "<CMD>OCamlSwitchIntfImpl<CR>" },
            { "<leader>li", "<CMD>OCamlSwitchIntfImpl<CR>", desc = "OCaml switch .ml/.mli" },
            { "<leader>lI", "<CMD>OCamlInferIntf<CR>",      desc = "OCaml infer .mli from .ml" },
            buffer = args.buf
        })
    end
})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("custom.ocaml", { clear = false }),
    pattern = { "*.ml", "*.mli", "dune", "dune-project" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end
})
