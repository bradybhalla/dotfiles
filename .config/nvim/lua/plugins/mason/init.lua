-- keymaps in keymaps.lua
-- lsp settings in lsp.lua
-- null-ls settings in null-ls.lua

return {
    "williamboman/mason.nvim",
    dependencies = {
        -- lsp
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp", -- also dependency for cmp

        -- null-ls
        {
            "jose-elias-alvarez/null-ls.nvim",
            dependencies = { "nvim-lua/plenary.nvim" }
        },

    },
    build = ":MasonUpdate",
    config = function()
        -- diagnostic settings
        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            update_in_insert = true
        })

        -- diagnostic icons
        local signs = {
            { name = "DiagnosticSignError", icon = "" },
            { name = "DiagnosticSignWarn", icon = "" },
            { name = "DiagnosticSignInfo", icon = "" },
            { name = "DiagnosticSignHint", icon = "" },
        }
        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.icon, numhl = "" })
        end


        require("mason").setup()

        require("plugins.mason.lsp-setup")()
        require("plugins.mason.null-ls-setup")()
    end
}
