local default_on_attach = function(client, bufnr)
    -- custom mappings

    -- format
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

    -- go to definition
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition)

    -- hover
    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover)


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
