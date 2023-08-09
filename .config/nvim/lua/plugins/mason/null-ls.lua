local setup_keymaps = require("plugins.mason.keymaps")
local null_ls = require("null-ls")

local null_ls_setup = {}

null_ls_setup.ensure_installed = {
    "black"
}

null_ls_setup.config = {
    sources = {
        null_ls.builtins.formatting.black
    },
    on_attach = function(client, bufnr)
        -- null-ls always says it can do everything (lies)
        client.server_capabilities.hoverProvider = false

        setup_keymaps.general(client, bufnr)
        setup_keymaps.null_ls()
    end
}


return null_ls_setup
