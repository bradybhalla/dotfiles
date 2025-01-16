return {
    -- navigation
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            defaults = { file_ignore_patterns = { "^.git/" } },
            pickers = { live_grep = { additional_args = { "--hidden" } } }
        }
    },

    -- better highlighting and parsing
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup {
                highlight = {
                    enable = true,
                    disable = { "latex" }
                },
                incremental_selection = {
                    enable = true,
                    disable = { "vim" },
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

    -- statusline
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

    -- filetree
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            tab = { sync = { open = true, close = true } },
            filters = { git_ignored = false },
            sync_root_with_cwd = true
        }
    },

    -- keymap management and popup
    {
        "folke/which-key.nvim",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },

    { "tpope/vim-surround" },

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()

            local Rule = require("nvim-autopairs.rule")
            local autopairs = require("nvim-autopairs")
            autopairs.add_rule(Rule("$", "$", { "tex" }))
        end
    }

}
