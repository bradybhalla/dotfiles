local null_ls_setup = {}

null_ls_setup.ensure_installed = {
    "black"
}

null_ls_setup.config = {
    sources = {
        require("null-ls").builtins.formatting.black
    },
    on_attach = function(client, bufnr)
        -- null-ls always says it can do everything (lies)
        client.server_capabilities.hoverProvider = false

        require("plugins.mason.keymaps").general(client, bufnr)
        require("plugins.mason.keymaps").null_ls(client, bufnr)
    end
}


return null_ls_setup
