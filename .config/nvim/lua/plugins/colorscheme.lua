return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            integrations = { mason = true },
            custom_highlights = function(colors)
                return {
                    SpellBad = { fg = colors.red }, -- spelling errors
                    SpellCap = { fg = colors.red }, -- capitalization errors
                    Conceal = { fg = colors.pink }, -- VimTeX conceal

                    -- debugger symbols
                    DapBreakpoint = { fg = colors.blue },
                    DapStopped = { fg = colors.blue },

                    -- nicer coq highlighting
                    coqProofDelim = { fg = colors.blue, bold = true },
                    coqVernacCmd = { fg = colors.pink, bold = true },
                    coqError = { fg = colors.red, bold = true },
                }
            end

        })
        vim.cmd.colorscheme "catppuccin-frappe"
    end
}
