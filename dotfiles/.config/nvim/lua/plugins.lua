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
        { "nvim-lua/plenary.nvim",                   lazy = true },
        {
            "nvim-telescope/telescope.nvim",
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
                        "json", "typescript", "javascript", "latex", "ocaml", "haskell", "python", "cpp",
                        "comment"
                    },
                    highlight = {
                        enable = true,
                        disable = { "latex" } -- vimtex has better highlighting
                    }
                }
            end
        },
        { "nvim-treesitter/nvim-treesitter-context", opts = {} },
        { "lewis6991/gitsigns.nvim",                 opts = {} },
        { "akinsho/toggleterm.nvim",                 opts = {} },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            opts =
            {
                options = { disabled_filetypes = { "NvimTree", "toggleterm" } },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = { "diagnostics" },
                    lualine_z = { "location" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {
                    lualine_a = { {
                        "tabs",
                        mode = 1,
                        use_mode_colors = true
                    } },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = { "diff" },
                    lualine_z = { "branch" }
                }
            }
        },
        {
            "folke/which-key.nvim",
            opts = {
                delay = function(ctx)
                    -- show up instantly on spelling, otherwise delay
                    return ctx.plugin == "spelling" and 0 or 400
                end,
            }
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
        {
            "hrsh7th/nvim-cmp",
            dependencies = {
                "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline", "hrsh7th/cmp-omni", "saadparwaiz1/cmp_luasnip",
            },
            config = function()
                local cmp = require("cmp")
                cmp.setup {
                    snippet = {
                        expand = function(args)
                            require("luasnip").lsp_expand(args.body)
                        end
                    },
                    mapping = {
                        ["<TAB>"] = cmp.mapping.confirm({ select = true }),
                        ["<C-l>"] = cmp.mapping.confirm({ select = true }),
                        ["<C-n>"] = cmp.mapping.select_next_item(),
                        ["<C-p>"] = cmp.mapping.select_prev_item(),
                    },
                    sources = cmp.config.sources({
                        { name = "nvim_lsp" },
                        { name = "luasnip" }
                    }, {
                        { name = "buffer" },
                    })
                }
                cmp.setup.cmdline({ "/", "?" }, {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = {
                        { name = "buffer" }
                    }
                })
                cmp.setup.cmdline(":", {
                    mapping = cmp.mapping.preset.cmdline(),
                    sources = cmp.config.sources({
                        { name = "path" }
                    }, {
                        { name = "cmdline" }
                    }),
                    matching = { disallow_symbol_nonprefix_matching = false }
                })
            end
        },
        {
            "windwp/nvim-autopairs",
            opts = {},
            config = function()
                require("nvim-autopairs").setup()
                local Rule = require("nvim-autopairs.rule")
                local autopairs = require("nvim-autopairs")
                autopairs.add_rule(Rule("$", "$", "tex"))
                autopairs.get_rules("`")[1].not_filetypes = { "ocaml" }
                autopairs.get_rules("'")[1].not_filetypes = { "ocaml" }
            end
        },


        -- language tools
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
            opts = {}
        },
        { "folke/lazydev.nvim", opts = {} },
        {
            "neovim/nvim-lspconfig",
            config = function()
                vim.diagnostic.config({
                    severity_sort = true,
                    update_in_insert = true,
                    virtual_text = true,
                })

                vim.lsp.config("ts_ls", {
                    settings = {
                        typescript = { format = { semicolons = "insert" } },
                        javascript = { format = { semicolons = "insert" } }
                    }
                })
                vim.lsp.enable({ "pyright", "lua_ls", "ts_ls", "ocamllsp", "clangd", "rust_analyzer" })
            end
        },
        {
            "stevearc/conform.nvim",
            opts = { formatters_by_ft = { ocaml = { "ocamlformat" } } }
        },


        -- misc
        {
            "lervag/vimtex",
            init = function()
                -- global settings
                vim.g.vimtex_quickfix_open_on_warning = 0
                vim.g.vimtex_syntax_conceal = { math_bounds = 0 }
                -- more configuration in after/ftplugin/tex.lua
            end
        }


    },
    install = { colorscheme = { "catppuccin" } }
})
