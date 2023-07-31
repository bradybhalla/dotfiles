return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("lualine").setup {
            options = {
                theme = "catppuccin",
                disabled_filetypes = { "NvimTree" }
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = {"location"},
                lualine_y = { "filetype" },
                lualine_z = {}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}

            },
            tabline = {
                lualine_a = { {
                    "tabs",
                    mode = 1
                } },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = { "branch" },
                lualine_z = {}

            }
        }
    end

}
