return {
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
                highlight = {
                    enable = true,
                    disable = { "latex" } -- vimtex has better highlighting
                },
                incremental_selection = {
                    enable = true,
                    disable = { "vim" }, -- causes error in q: window
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        scope_incremental = false,
                        node_decremental = "<BS>"
                    }
                }
            }
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup {
                options = {
                    disabled_filetypes = { "NvimTree", "toggleterm" },
                    ignore_focus = {
                        "dapui_scopes", "dapui_watches", "dap-repl",
                        "dapui_console", "dapui_breakpoints", "dapui_stacks"
                    }
                },
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
        end
    },

    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            tab = { sync = { open = true, close = true } },
            filters = { git_ignored = false },
            sync_root_with_cwd = true
        }
    },

    {
        "folke/which-key.nvim",
        opts = {
            delay = function(ctx)
                -- show up instantly on spelling, otherwise delay
                return ctx.plugin == "spelling" and 0 or 200
            end,
        }
    },

    { "tpope/vim-surround" },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()

            local Rule = require("nvim-autopairs.rule")
            local autopairs = require("nvim-autopairs")
            autopairs.add_rule(Rule("$", "$", "tex"))
            autopairs.get_rules("`")[1].not_filetypes = { "ocaml" }
            autopairs.get_rules("'")[1].not_filetypes = { "ocaml" }
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup {}

            vim.cmd [[ hi TreesitterContextBottom gui=none ]]
        end
    }

}
