return {
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
            vim.o.timeoutlen = 300
        end
    },
    { "akinsho/toggleterm.nvim", opts = {} },
    { "lewis6991/gitsigns.nvim", opts = {} }
}
