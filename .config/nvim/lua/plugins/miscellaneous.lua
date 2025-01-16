return {
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()

            local Rule = require("nvim-autopairs.rule")
            local autopairs = require("nvim-autopairs")
            autopairs.add_rule(Rule("$", "$", { "tex" }))
        end
    },
    { "tpope/vim-surround" },
    {
        "folke/which-key.nvim",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
    { "akinsho/toggleterm.nvim", opts = {} },
    { "lewis6991/gitsigns.nvim", opts = {} },
    {
        "lervag/vimtex",
        init = function()
            -- global settings
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_syntax_conceal = {math_bounds = 0}

            -- more configuration in after/ftplugin/tex.lua
        end
    }
}
