return {
    { "williamboman/mason.nvim", build = ":MasonUpdate", opts = {} },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",              -- also dependency for cmp
            { "folke/lazydev.nvim", opts = {} }, -- configure lua_ls for nvim
        },
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


            -- pass in custom options
            local function configure(changes)
                return vim.tbl_deep_extend("force", {
                    -- default options
                    capabilities = require("cmp_nvim_lsp").default_capabilities()
                }, changes)
            end


            local lspconfig = require("lspconfig")

            lspconfig.pyright.setup(configure({}))

            lspconfig.lua_ls.setup(configure({}))

            lspconfig.tsserver.setup(configure({
                settings = {
                    typescript = { format = { semicolons = "insert" } },
                    javascript = { format = { semicolons = "insert" } }
                }
            }))

            lspconfig.ocamllsp.setup(configure({}))

            lspconfig.clangd.setup(configure({}))

            lspconfig.hls.setup(configure({}))
        end
    } }
