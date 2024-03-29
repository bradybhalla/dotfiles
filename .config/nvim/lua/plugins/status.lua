return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require("lualine").setup {
            options = {
                theme = "catppuccin",
                disabled_filetypes = { "NvimTree", "toggleterm" }
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = { "diagnostics" },
                lualine_z = { { "filetype", colored = false } }
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
                lualine_a = { "filename" },
                lualine_b = { "location" },
                lualine_c = {},
                lualine_x = {},
                lualine_y = { "diff" },
                lualine_z = { "branch" }
            }
        }
    end
}
