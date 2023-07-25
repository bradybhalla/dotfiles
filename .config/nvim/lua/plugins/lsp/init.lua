-- server-specific settings and keymaps in handlers.lua

return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    },
    build = ":MasonUpdate",
    config = function()
        vim.diagnostic.config({
            virtual_text = false,
        })

        local handlers = require("plugins.lsp.handlers")

        require("mason").setup()
        require("mason-lspconfig").setup {
            ensure_installed = { "lua_ls", "pyright", "tsserver" },
            handlers = handlers
        }
    end
}
