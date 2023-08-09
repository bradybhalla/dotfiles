local lspconfig = require("lspconfig")
local setup_keymaps = require("plugins.lsp.setup_keymaps")

local on_attach = function(client, bufnr)

    setup_keymaps(client, bufnr)

    -- open float with diagnostics
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "show diagnostic", buffer = true })

    vim.keymap.set("n", "<leader>l,", vim.diagnostic.goto_prev, { desc = "go to previous diagnostic", buffer = true })
    vim.keymap.set("n", "<leader>l;", vim.diagnostic.goto_next, { desc = "go to next diagnostic", buffer = true })


    -- disable highlighting from lsp (copied from Eric)
    client.server_capabilities.semanticTokensProvider = nil
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function config(changes)
    return vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities
    }, changes)
end


local handlers = {}

handlers.lsp = {
    -- default handler
    function(server_name)
        lspconfig[server_name].setup(config({}))
    end,

    -- specific handlers
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup(config({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace"
                    }
                }
            }
        }))
    end,

}


handlers.null_ls = {
    -- default handler
    function(server_name)
        lspconfig[server_name].setup(config({}))
    end,

    -- specific handlers
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup(config({
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace"
                    }
                }
            }
        }))
    end,

}

return handlers
