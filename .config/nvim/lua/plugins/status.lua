local M = {
    "nvim-lualine/lualine.nvim"
}

function M.config()
    require("lualine").setup {
        options = {
            theme = "catppuccin",
            disabled_filetypes={"NvimTree"}
        }
    }
end

return M
