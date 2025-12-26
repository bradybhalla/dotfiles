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
        { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },
        { "folke/lazydev.nvim",      opts = {} },
        {
            "neovim/nvim-lspconfig",
            config = function()
                vim.diagnostic.config({
                    severity_sort = true,
                    update_in_insert = true,
                    virtual_text = true
                })
                vim.lsp.enable({
                    "pyright", "lua_ls", "ts_ls", "ocamllsp", "clangd",
                    "rust_analyzer"
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
