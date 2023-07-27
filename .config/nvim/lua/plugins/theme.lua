return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            transparent_background = false,
            integrations = {
                treesitter_context = true,
                mason = true,
                -- lualine integration in status.lua

                -- set to default:
                --      cmp
                --      gitsigns
                --      nvimtree
                --      indent_blankline
                --      telescope
                --      treesitter
                --      lspconfig

                -- add all valid integration plugins here
            }
        })
        vim.cmd.colorscheme "catppuccin-frappe"
    end
}
