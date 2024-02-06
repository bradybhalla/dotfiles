return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            highlight = {
                enable = true,
                disable = { "latex" }
            },
            incremental_selection = {
                enable = true,
                disable = {"vim"},
                keymaps = {
                    init_selection = "<CR>",
                    node_incremental = "<CR>",
                    scope_incremental = false,
                    node_decremental = "<BS>"
                }
            }
        }
    end
}
