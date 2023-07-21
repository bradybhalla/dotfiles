local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
}

function M.config()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true
        },
        -- TODO, incremental selection
    })
end

return M