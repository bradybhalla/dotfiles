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

                -- default settings:
                --      cmp
                --      gitsigns
                --      nvimtree
                --      indent_blankline
                --      telescope
                --      treesitter
                --      lspconfig

                -- add all valid integration plugins here
            },
            custom_highlights = function(colors)
                return {
                    SpellBad = { fg = colors.red }, -- spelling errors
                    SpellCap = { fg = colors.red }, -- capitalization errors
                    Conceal = { fg = colors.pink }  -- VimTeX conceal
                }
            end

        })
        vim.cmd.colorscheme "catppuccin-frappe"
    end
}
