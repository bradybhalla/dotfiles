--------------------
-- General options -
--------------------

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = "yes" -- stop text from shifting

vim.opt.tabstop        = 4     -- tab size 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true -- use spaces instead of tabs

vim.opt.ignorecase     = true -- search case sensitivity
vim.opt.smartcase      = true

vim.opt.breakindent    = true -- wrapping behavior
vim.opt.linebreak      = true
vim.opt.smoothscroll   = true

vim.opt.splitright     = true -- window splitting direction
vim.opt.splitbelow     = true

vim.opt.spellsuggest   = "9" -- max 9 items in z=

vim.g.mapleader        = " " -- set leader key


-----------------
-- Lazy/plugins -
-----------------

-- make sure lazy is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- install and setup plugins
require("lazy").setup({
    spec = {
        -- editor interface / navigation
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            opts = {
                integrations = { mason = true },
                custom_highlights = function(colors)
                    return {
                        SpellBad = { fg = colors.red }, -- spelling errors
                        SpellCap = { fg = colors.red }, -- capitalization errors
                        Conceal = { fg = colors.pink }, -- VimTeX conceal
                    }
                end
            },
        },
        {
            "nvim-telescope/telescope.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {
                defaults = { file_ignore_patterns = { "^.git/" } },
                pickers = { live_grep = { additional_args = { "--hidden" } } }
            }
        },
        {
            "nvim-treesitter/nvim-treesitter",
            branch = "master", -- default is now on main but it is annoying
            build = ":TSUpdate",
            config = function()
                ---@diagnostic disable-next-line: missing-fields
                require("nvim-treesitter.configs").setup {
                    ensure_installed = {
                        "json", "typescript", "javascript", "ocaml", "python",
                        "cpp", "nix", "comment", "typst"
                    },
                    highlight = { enable = true } }
            end
        },
        { "lewis6991/gitsigns.nvim" },
        {
            "stevearc/oil.nvim",
            dependencies = { { "nvim-mini/mini.icons", opts = {} } },
            opts = { view_options = { show_hidden = true } }
        },


        -- editing
        { "tpope/vim-surround" },
        {
            "windwp/nvim-autopairs",
            config = function()
                local autopairs = require("nvim-autopairs")
                autopairs.setup {}

                local Rule = require("nvim-autopairs.rule")
                autopairs.add_rule(Rule("$", "$", { "tex", "typst" }))

                autopairs.get_rule("'")[1].not_filetypes = { "ocaml" }
            end
        },
        {
            "L3MON4D3/LuaSnip",
            config = function()
                require("luasnip").config.setup({
                    enable_autosnippets = true,
                    update_events = "TextChanged,TextChangedI"
                })
                require("luasnip.loaders.from_lua").lazy_load() -- from luasnippets/
            end
        },
        {
            "saghen/blink.cmp",
            version = "1.*",
            opts = {
                snippets = { preset = "luasnip" },
                keymap = {
                    preset = "none",
                    ["<C-l>"] = { "select_and_accept", "show" },
                    ["<C-p>"] = { "select_prev" },
                    ["<C-n>"] = { "select_next" },
                    ["<C-e>"] = { "hide" },

                    ["<C-j>"] = { "snippet_forward" },
                    ["<C-k>"] = { "snippet_backward" },

                    ["<C-u>"] = { "show_documentation", "hide_documentation" },
                    ["<C-b>"] = { "scroll_documentation_up" },
                    ["<C-f>"] = { "scroll_documentation_down" }
                }
            }
        },


        -- language tools
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
            opts = {}
        },
        { "folke/lazydev.nvim",     opts = {} },
        { "mfussenegger/nvim-jdtls" },
        { "neovim/nvim-lspconfig" },
        {
            "stevearc/conform.nvim",
            opts = {
                formatters_by_ft = {
                    ocaml = { "ocamlformat" },
                    python = { "black" },
                    nix = { "nixfmt" }
                }
            }
        },


        -- misc
        { "akinsho/toggleterm.nvim", opts = {} },
        {
            "lervag/vimtex",
            init = function()
                vim.g.vimtex_quickfix_open_on_warning = 0
                vim.g.vimtex_syntax_conceal = { math_bounds = 0 }
            end
        }


    },
    install = { colorscheme = { "catppuccin" } }
})


vim.cmd.colorscheme "catppuccin-frappe"


------------
-- Keymaps -
------------

-- editing behavior
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set({ "n", "v" }, "gj", "j")
vim.keymap.set({ "n", "v" }, "gk", "k")


-- misc shortcuts
vim.keymap.set("n", "<leader>q", "<CMD>quit<CR>")
vim.keymap.set("n", "<leader>s", "<CMD>write<CR>")
vim.keymap.set({ "n", "v" }, "<leader>c", "\"+")
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>")
vim.keymap.set("n", "<leader>O", function()
    local file_path = vim.fn.expand("%")
    if file_path ~= "" then
        _, _ = pcall(vim.system, { "open", "-R", file_path }, {})
    else
        _, _ = pcall(vim.system, { "open", vim.fn.expand("%:p:h") }, {})
    end
end)
vim.keymap.set("n", "<leader>G", function()
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
end)


-- toggle settings
vim.keymap.set("n", "<leader>ts", function()
    vim.opt_local.spell = not vim.opt_local.spell:get()
    vim.notify("spellcheck: " .. (vim.opt_local.spell:get() and "on" or "off"))
end)


-- telescope
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>")
vim.keymap.set("n", "<leader>fi",
    "<CMD>Telescope find_files hidden=true no_ignore=true<CR>")
vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<CMD>Telescope help_tags<CR>")


-- language / lsp
vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end)
vim.keymap.set("n", "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<leader>lS", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>")


-- snippets (others defined in blink.cmp setup)
vim.keymap.set("i", "<S-TAB>", function()
    require("luasnip").expand()
end)
vim.keymap.set({ "i", "s" }, "<C-d>", function()
    if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
    end
end)


-----------------
-- LSP settings -
-----------------

vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = true
})

vim.lsp.config("tinymist", {
    settings = {
        exportPdf = "onSave"
    }
})

vim.lsp.enable({
    "pyright", "lua_ls", "ts_ls", "ocamllsp", "clangd",
    "rust_analyzer", "tinymist"
})


-------------------------------
-- Filetype specific settings -
-------------------------------

-- LaTeX specific keymaps
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.latex", {}),
    pattern = "tex",
    callback = function()
        -- build and show current document
        vim.keymap.set("n", "<leader>b", "<CMD>w<CR><CMD>VimtexCompileSS -pdf -pv<CR>", { buffer = true })

        -- toggle conceal
        vim.keymap.set("n", "<leader>tc", function()
            vim.opt.conceallevel = 2 - vim.opt.conceallevel:get()
        end, { buffer = true })
    end
})


-- Typst specific keymaps
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.typst", {}),
    pattern = "typst",
    callback = function()
        vim.keymap.set("n", "<leader>b", "<CMD>silent !open -a Skim %:r.pdf<CR>", { buffer = true })
    end
})


-- Java custom lsp setup through nvim-jdtls
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.java", {}),
    pattern = "java",
    callback = function()
        require("jdtls").start_or_attach({
            cmd = { "jdtls" }
        })
    end
})
