require("catppuccin").setup({
    integrations = { mason = true },
    custom_highlights = function(colors)
        return {
            SpellBad = { fg = colors.red },
            SpellCap = { fg = colors.red },
            Conceal = { fg = colors.pink },
        }
    end
})
vim.cmd.colorscheme "catppuccin-frappe"

require("telescope").setup({
    defaults = { file_ignore_patterns = { "^.git/" } },
    pickers = { live_grep = { additional_args = { "--hidden" } } }
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
require("nvim-treesitter").install(
    "json", "typescript", "javascript", "ocaml", "python",
    "cpp", "nix", "comment", "typst", "haskell"
)

require("gitsigns").setup()

require("mini.icons").setup()

require("oil").setup({ view_options = { show_hidden = true } })
