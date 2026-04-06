require("toggleterm").setup()

vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_syntax_conceal = { math_bounds = 0 }

require("which-key").setup({
    delay = function(ctx)
        -- delay for everything except spelling
        if ctx.plugin and ctx.plugin == "spelling" then
            return 0
        else
            return 400
        end
    end
})
