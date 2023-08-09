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
        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            update_in_insert = true,
        })

        require("mason").setup()

        local lsp_setup = require("plugins.mason.lsp")
        require("mason-lspconfig").setup {
            ensure_installed = lsp_setup.ensure_installed,
            handlers = lsp_setup.handlers
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
