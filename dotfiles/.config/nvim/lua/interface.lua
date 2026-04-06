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

require("gitsigns").setup()

require("mini.icons").setup()
require("oil").setup({ view_options = { show_hidden = true } })
