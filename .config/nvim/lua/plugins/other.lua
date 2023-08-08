return {
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    { "tpope/vim-commentary" },
    { "tpope/vim-surround" },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {}
    },
    {"akinsho/toggleterm.nvim", config = true}
}
