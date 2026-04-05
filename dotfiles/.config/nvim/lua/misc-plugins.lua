--------------------------
-- Miscellaneous plugins -
--------------------------

vim.pack.add({
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/lervag/vimtex",
})


require("toggleterm").setup()

vim.g.vimtex_quickfix_open_on_warning = 0
vim.g.vimtex_syntax_conceal = { math_bounds = 0 }
