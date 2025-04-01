return {
    -- installer
    { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },

    -- language servers
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
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

            -- pass in custom options
            local function configure(changes)
                return vim.tbl_deep_extend("force", {
                    -- default options
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                }, changes)
            end

            local lspconfig = require("lspconfig")

            lspconfig.pyright.setup(configure {})
            lspconfig.lua_ls.setup(configure {})
            lspconfig.ts_ls.setup(configure {
                settings = {
                    typescript = { format = { semicolons = "insert" } },
                    javascript = { format = { semicolons = "insert" } }
                }
            })
            lspconfig.ocamllsp.setup(configure {})
            lspconfig.clangd.setup(configure {})
            lspconfig.hls.setup(configure {})
            lspconfig.rust_analyzer.setup(configure {})
            lspconfig.coq_lsp.setup(configure {})
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
