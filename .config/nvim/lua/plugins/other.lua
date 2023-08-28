return {
    { "lukas-reineke/indent-blankline.nvim" },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter"
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
    { "akinsho/toggleterm.nvim" },
    { "lewis6991/gitsigns.nvim" }
}
