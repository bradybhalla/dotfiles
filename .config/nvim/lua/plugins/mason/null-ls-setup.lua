return function()
    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.black,
            null_ls.builtins.formatting.beautysh
        },
        on_attach = function(client, bufnr)
            -- null-ls always says it can do everything (lies)
            client.server_capabilities.hoverProvider = false

            require("plugins.mason.keymaps").general(client, bufnr)
            require("plugins.mason.keymaps").null_ls(client, bufnr)
        end
    })
end
