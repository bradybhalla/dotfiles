local default_on_attach = function(client, bufnr)
    -- custom mappings

    vim.keymap.set("n", "<leader>lF", vim.lsp.buf.format)

    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition)

    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover)

    -- open float with diagnostics
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float)

    vim.keymap.set("n", "<leader>l,", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "<leader>l;", vim.diagnostic.goto_next)

    -- disable highlighting from lsp (copied from Eric)
    client.server_capabilities.semanticTokensProvider = nil
end


return {
    -- default handler
    function(server_name)
        require("lspconfig")[server_name].setup {
            on_attach = default_on_attach
        }
    end,

    -- specific handlers
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    }
                }
            },
            on_attach = default_on_attach
        }
    end,

}
