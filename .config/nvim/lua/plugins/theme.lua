return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = false,
            integrations = {
                -- cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                -- notify = false,
                -- mini = false,
                treesitter_context = true,
                mason = true
            }
        })
        vim.cmd.colorscheme "catppuccin-frappe"
    end
}
