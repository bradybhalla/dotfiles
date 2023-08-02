-- server-specific settings and keymaps in handlers.lua

return {
    "williamboman/mason.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        {
            -- function signatures
            "ray-x/lsp_signature.nvim",
            config = function()
                require("lsp_signature").setup {
                    hint_enable = false
                }
            end
        },
        {
            -- linting
            "jose-elias-alvarez/null-ls.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function()
                local null_ls = require("null-ls")

                null_ls.setup({
                    sources = {
                        -- add sources here after you install them
                        null_ls.builtins.formatting.black
                    },
                })
            end
        }
    },
    build = ":MasonUpdate",
    config = function()
        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            update_in_insert = true,
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
