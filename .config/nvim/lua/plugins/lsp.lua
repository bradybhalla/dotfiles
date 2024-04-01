return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {}
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "LspInfo", "LspStart", "LspRestart" },
        dependencies = {
            -- lsp
            "hrsh7th/cmp-nvim-lsp",             -- also dependency for cmp
            { "folke/neodev.nvim", opts = {} }, -- configure lua_ls for nvim

            -- null-ls
            {
                "jose-elias-alvarez/null-ls.nvim",
                dependencies = { "nvim-lua/plenary.nvim" }
            },

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


            -------------
            -- Keymaps --
            -------------
            local telescope_builtin = require("telescope.builtin")

            -- keymaps are in the format { key, description, function, capability }
            -- they will only be defined if the client has the given capability or if capability is set to true
            local general_keymaps = {
                { "F", "format file",              vim.lsp.buf.format,                              "documentFormattingProvider" },
                { "d", "go to definition",         telescope_builtin.lsp_definitions,               "definitionProvider" },
                { "r", "find references",          telescope_builtin.lsp_references,                "referencesProvider" },
                { "s", "search document symbols",  telescope_builtin.lsp_document_symbols,          "documentSymbolProvider" },
                { "S", "search workspace symbols", telescope_builtin.lsp_dynamic_workspace_symbols, "workspaceSymbolProvider" },
                { "h", "hover",                    vim.lsp.buf.hover,                               "hoverProvider" },
                { "n", "rename",                   vim.lsp.buf.rename,                              "renameProvider" },
            }

            local lsp_specific_keymaps = {
                { "e", "show diagnostic",     vim.diagnostic.open_float, true },
                { ",", "previous diagnostic", vim.diagnostic.goto_prev,  true },
                { ";", "next diagnostic",     vim.diagnostic.goto_next,  true },
                unpack(general_keymaps)
            }

            local function define_lsp_keymaps(maps, client, bufnr)
                require("which-key").register({
                    ["<leader>l"] = { name = "lsp" }
                }, { buffer = bufnr })

                for _, v in pairs(maps) do
                    if client.server_capabilities[v[4]] or v[4] == true then
                        vim.keymap.set("n", "<leader>l" .. v[1], v[3], { desc = v[2], buffer = bufnr })
                    end
                end
            end


            ---------------
            -- LSP Setup --
            ---------------

            local default_config = {
                on_attach = function(client, bufnr)
                    define_lsp_keymaps(lsp_specific_keymaps, client, bufnr)
                end,
                capabilities = require("cmp_nvim_lsp").default_capabilities()
            }

            -- pass in custom options
            local function configure(changes)
                return vim.tbl_deep_extend("force", default_config, changes)
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

            -------------------
            -- null-ls Setup --
            -------------------

            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.black,
                    null_ls.builtins.formatting.beautysh,
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "css", "html", "json", "markdown" }
                    }),
                    null_ls.builtins.formatting.ocamlformat
                },
                on_attach = function(client, bufnr)
                    -- null-ls always says it can do everything (lies)
                    client.server_capabilities.hoverProvider = false

                    define_lsp_keymaps(general_keymaps, client, bufnr)
                end
            })
        end
    } }
