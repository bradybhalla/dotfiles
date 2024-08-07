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
    { "lervag/vimtex" } -- more settings in after/ftplugin/tex.lua
}
