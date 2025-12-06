local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority=1000,
        opts = {}
    },

    { "nvim-lua/plenary.nvim", lazy=true },
    { "nvim-telescope/telescope.nvim", opts = {
            defaults = { file_ignore_patterns = { "^.git/" } },
            pickers = { live_grep = { additional_args = { "--hidden" } } }
        } },


    { "tpope/vim-surround" },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup {
                ensure_installed = {
                    "json", "typescript", "javascript", "latex", "ocaml", "haskell", "python", "cpp",
                    "comment"
                },
                highlight = {
                    enable = true,
                    disable = { "latex" } -- vimtex has better highlighting
                },
                incremental_selection = {
                    enable = true,
                    disable = { "vim" }, -- causes error in q: window
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        scope_incremental = false,
                        node_decremental = "<BS>"
                    }
                }
            }
        end
    },


    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup {}

            vim.cmd [[ hi TreesitterContextBottom gui=none ]]
        end
    },

    { "lewis6991/gitsigns.nvim", opts = {} },

},
    install = { colorscheme = { "catppuccin" } }
})
