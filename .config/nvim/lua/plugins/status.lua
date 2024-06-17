return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
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
                lualine_x = { "location" },
                lualine_y = { "diagnostics" },
                lualine_z = { { "filetype", colored = false } }
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
}
