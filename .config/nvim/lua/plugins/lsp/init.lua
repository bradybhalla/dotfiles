-- server-specific settings and keymaps in handlers.lua
-- linting settings in linting.lua
local linting_plugin = require("plugins.lsp.linting")

return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        {
            "ray-x/lsp_signature.nvim",
            config = function()
                require("lsp_signature").setup {
                    hint_enable = false
                }
            end
        },
        linting_plugin
    },
    build = ":MasonUpdate",
    config = function()
        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true
        })

        local handlers = require("plugins.lsp.handlers")

        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = {
                "lua_ls", "pyright", "tsserver",
            },
            handlers = handlers
        }
    end
}
