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

            -- pass in custom options
            local function configure(changes)
                return vim.tbl_deep_extend("force", {
                    -- default options
                    capabilities = require("cmp_nvim_lsp").default_capabilities()
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

    -- debuggers
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "mfussenegger/nvim-dap-python"
        },
        config = function()
            require("dap-python").setup("python")

            require("dapui").setup()

            vim.fn.sign_define("DapBreakpoint", { texthl = "DapBreakpoint", text = "●", numhl = "" })
            vim.fn.sign_define("DapStopped", { texthl = "DapStopped", text = "→", numhl = "" })
        end
    }
}
