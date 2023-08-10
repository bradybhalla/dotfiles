-- keymaps in keymaps.lua
-- lsp settings in lsp.lua
-- null-ls settings in null-ls.lua

return {
    "williamboman/mason.nvim",
    dependencies = {
        -- lsp
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "ray-x/lsp_signature.nvim",

        -- null-ls
        "jay-babu/mason-null-ls.nvim",
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
            update_in_insert = true,
        })

        -- diagnostic icons
        local signs = {
            { name = "DiagnosticSignError", icon = "" },
            { name = "DiagnosticSignWarn", icon = "" },
            { name = "DiagnosticSignHint", icon = "" },
            { name = "DiagnosticSignInfo", icon = "" },
        }
        for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.icon, numhl = "" })
        end


        require("mason").setup()

        require("mason-lspconfig").setup {
            ensure_installed = require("plugins.mason.lsp").ensure_installed,
            handlers = require("plugins.mason.lsp").handlers
        }

        local null_ls_setup = require("plugins.mason.null-ls")
        require("mason-null-ls").setup {
            ensure_installed = null_ls_setup.ensure_installed,
        }
        require("null-ls").setup(null_ls_setup.config)

        -- signature help
        require("lsp_signature").setup {
            hint_enable = false
        }
    end
}
