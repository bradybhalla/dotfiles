return {
    {
        "lervag/vimtex",
        init = function()
            -- global settings
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_syntax_conceal = { math_bounds = 0 }

            -- more configuration in after/ftplugin/tex.lua
        end
   }
}
