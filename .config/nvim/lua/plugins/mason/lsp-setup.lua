return function()
    local default_config = {
        on_attach = function(client, bufnr)
            require("plugins.mason.keymaps").general(client, bufnr)
            require("plugins.mason.keymaps").lsp(client, bufnr)
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities()
    }

    -- pass in custom options
    local function configure(changes)
        return vim.tbl_deep_extend("force", default_config, changes)
    end


    local lspconfig = require("lspconfig")

    lspconfig.pyright.setup(configure({}))

    lspconfig.tsserver.setup(configure({}))

    lspconfig.lua_ls.setup(configure({
        settings = {
            Lua = {
                runtime = {
                    version = "LuaJIT",
                },
                diagnostics = {
                    globals = { "vim" },
                },
                workspace = {
                    checkThirdParty = false,
                    library = vim.api.nvim_get_runtime_file("", true)
                }
            }
        }
    }))

    lspconfig.texlab.setup(configure({
        settings = {
            texlab = {
                build = {
                    onSave = true
                }
            }
        }
    }))
end