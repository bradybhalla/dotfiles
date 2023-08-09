-- server-specific settings and keymaps in handlers.lua, setup_keymaps.lua

return {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "ray-x/lsp_signature.nvim",
        {
            "jose-elias-alvarez/null-ls.nvim",
            dependencies = { "nvim-lua/plenary.nvim" }
        },
        {
            "jay-babu/mason-null-ls.nvim",
            config = function()
                require("your.null-ls.config") -- require your null-ls config here (example below)
            end,
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

        -- linting
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- add sources here after you install them
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.markdownlint
            },
            on_attach = require("plugins.lsp.setup_keymaps")
        })

        require("mason-null-ls").setup({
            ensure_installed = { "stylua", "jq" },
            handlers = {
                function() end, -- disables automatic setup of all null-ls sources
                stylua = function(source_name, methods)
                    null_ls.register(null_ls.builtins.formatting.stylua)
                end,
                shfmt = function(source_name, methods)
                    -- custom logic
                    require("mason-null-ls").default_setup(source_name, methods) -- to maintain default behavior
                end,
            },
        })

        -- signature help
        require("lsp_signature").setup {
            hint_enable = false
        }
    end
}
