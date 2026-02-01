------------
-- Options -
------------

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

vim.opt.completeopt:append("menuone") -- show completion menu for one item
vim.opt.completeopt:append("noinsert")
vim.opt.completeopt:append("fuzzy")

vim.opt.spellsuggest = "9"            -- max 9 items in z=

vim.g.mapleader      = " "            -- set leader key

-----------------
-- Lazy/plugins -
-----------------

-- make sure lazy is installed
local lazypath       = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
            build = ":TSUpdate",
            config = function()
                ---@diagnostic disable-next-line: missing-fields
                require("nvim-treesitter.configs").setup {
                    ensure_installed = {
                        "json", "typescript", "javascript", "ocaml", "python",
                        "cpp", "comment"
                    },
                    highlight = { enable = true }
                }
            end
        },


        -- editing
        { "tpope/vim-surround" },
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


        -- language tools
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
            opts = {}
        },
        { "folke/lazydev.nvim",     opts = {} },
        { "mfussenegger/nvim-jdtls" },
        {
            "neovim/nvim-lspconfig",
            config = function()
                vim.diagnostic.config({
                    severity_sort = true,
                    update_in_insert = true
                })
                vim.lsp.enable({
                    "pyright", "lua_ls", "ts_ls", "ocamllsp", "clangd",
                    "rust_analyzer"
                })

                -- better completion for supporting LSP servers
                vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup("custom.lsp", {}),
                    callback = function(args)
                        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
                        if client:supports_method("textDocument/completion") then
                            vim.lsp.completion.enable(true, client.id, args.buf, {})
                        end
                    end,
                })
            end
        },
        {
            "stevearc/conform.nvim",
            opts = {
                formatters_by_ft = { ocaml = { "ocamlformat" } } }
        },


        -- misc
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

vim.keymap.set("n", "n", "nzz") -- center after jumping
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", ">", ">gv")         -- reselect after shifting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("i", "<C-l>", function() -- activate or accept omni completion
    return vim.fn.pumvisible() == 1 and "<C-y>" or "<C-x><C-o>"
end, { expr = true })
vim.keymap.set({ "n", "v" }, "<leader>c", "\"+") -- system clipboard
vim.keymap.set("n", "<leader>w", "<C-w>")        -- window commands


-- misc shortcuts
vim.keymap.set("n", "<leader>q", "<CMD>quit<CR>")
vim.keymap.set("n", "<leader>s", "<CMD>write<CR>")
vim.keymap.set("n", "<leader>o", function()
    local file_path = vim.fn.expand("%")
    if file_path ~= "" then
        _, _ = pcall(vim.system, { "open", "-R", file_path }, {})
    else
        _, _ = pcall(vim.system, { "open", vim.fn.expand("%:p:h") }, {})
    end
end)


-- toggle settings
vim.keymap.set("n", "<leader>ts", function()
    vim.opt_local.spell = not vim.opt_local.spell:get()
end)
vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.config({
        virtual_text = not vim.diagnostic.config().virtual_text
    })
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


-- snippets (luasnip has priority over vim.snippet)
vim.keymap.set("i", "<S-TAB>", function()
    require("luasnip").expand()
end)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if require("luasnip").jumpable(1) then
        require("luasnip").jump(1)
    elseif vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
    end
end)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
    elseif vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
    end
end)
vim.keymap.set({ "i", "s" }, "<C-d>", function()
    if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
    end
end)


--------------------------------------
-- Filetype specific options/keymaps -
--------------------------------------

-- text-editing specific settings
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.text-editing", {}),
    pattern = { "tex", "markdown", "org", "typst" },
    callback = function()
        -- move within a line
        vim.keymap.set({ "n", "v" }, "j", "gj", { buffer = true })
        vim.keymap.set({ "n", "v" }, "k", "gk", { buffer = true })
        vim.keymap.set({ "n", "v" }, "gj", "j", { buffer = true })
        vim.keymap.set({ "n", "v" }, "gk", "k", { buffer = true })

        -- fix spelling errors
        vim.keymap.set("i", "<C-f>", "<C-x>s", { buffer = true })
    end
})

-- LaTeX specific settings
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


-- Java custom lsp settings using jdtls plugin
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.java", {}),
    pattern = "java",
    callback = function()
        require("jdtls").start_or_attach({
            cmd = { "jdtls" }
        })
    end
})
