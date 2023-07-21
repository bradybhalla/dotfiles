local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
}

function treesitter.config()
    require("nvim-treesitter.configs").setup({
        highlight = {
            enable = true
        },
        -- TODO, incremental selection
    })
end


local treesitter_context = {
    "nvim-treesitter/nvim-treesitter-context"
}

return {
    treesitter,
    treesitter_context
}
