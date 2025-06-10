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

    { "akinsho/toggleterm.nvim", opts = {} },

    { "lewis6991/gitsigns.nvim", opts = {} },

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
}
