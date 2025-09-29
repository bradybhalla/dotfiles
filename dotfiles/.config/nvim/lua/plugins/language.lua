return {
    -- installer
    { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },

    -- language servers
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "folke/lazydev.nvim", opts = {} }, -- configure lua_ls for nvim
        },
        config = function()
            -- diagnostic settings
            vim.diagnostic.config({
                severity_sort = true,
                update_in_insert = true,
                virtual_text = true,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.INFO] = "",
                        [vim.diagnostic.severity.HINT] = ""
                    }
                }
            })

            local lspconfig = require("lspconfig")

            lspconfig.pyright.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.ts_ls.setup({
                settings = {
                    typescript = { format = { semicolons = "insert" } },
                    javascript = { format = { semicolons = "insert" } }
                }
            })
            lspconfig.ocamllsp.setup({})
            lspconfig.clangd.setup({})
            lspconfig.hls.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.coq_lsp.setup({})
            lspconfig.svelte.setup({})
        end
    },

    -- formatters
    {
        "stevearc/conform.nvim",
        config = function()
            local formatters = {
                { ft = { "python" },            fmt = { "black" } },
                { ft = { "html", "css" },       fmt = { "prettier" } },
                { ft = { "bash", "zsh", "sh" }, fmt = { "beautysh" } },
                { ft = { "ocaml" },             fmt = { "ocamlformat" } },
            }

            local formatters_expanded = {}
            for i = 1, #formatters do
                for _, ft in ipairs(formatters[i].ft) do
                    formatters_expanded[ft] = formatters[i].fmt
                end
            end

            require("conform").setup({
                formatters_by_ft = formatters_expanded,
            })
        end
    },
}
