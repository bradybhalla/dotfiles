return function()
    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.beautysh,
            null_ls.builtins.formatting.prettier.with({
                filetypes = { "css", "html" }
            }),
            null_ls.builtins.formatting.ocamlformat
        },
        on_attach = function(client, bufnr)
            -- null-ls always says it can do everything (lies)
            client.server_capabilities.hoverProvider = false

            require("plugins.lsp.keymaps").general(client, bufnr)
            require("plugins.lsp.keymaps").null_ls(client, bufnr)
        end
    })
end
