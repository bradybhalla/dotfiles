return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require("nvim-treesitter.configs").setup {
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

    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()

            local Rule = require("nvim-autopairs.rule")
            local autopairs = require("nvim-autopairs")
            autopairs.add_rule(Rule("$", "$", "tex"))
            autopairs.get_rules("`")[1].not_filetypes = { "ocaml" }
            autopairs.get_rules("'")[1].not_filetypes = { "ocaml" }
        end
    },

    { "tpope/vim-surround" },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_mappings()
        end
    },
}
