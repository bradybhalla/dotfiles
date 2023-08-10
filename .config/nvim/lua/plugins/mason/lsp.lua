local lsp_setup = {}

lsp_setup.ensure_installed = {
    "lua_ls", "pyright", "tsserver", "texlab"
}

local default_config = {
    on_attach = function(client, bufnr)
        require("plugins.mason.keymaps").general(client, bufnr)
        require("plugins.mason.keymaps").lsp()
    end,
    capabilities = require("cmp_nvim_lsp").default_capabilities()
}

-- pass in custom options
local function configure(changes)
    return vim.tbl_deep_extend("force", default_config, changes)
end

lsp_setup.handlers = {
    -- default handler
    function(server_name)
        require("lspconfig")[server_name].setup(configure({}))
    end,

    -- specific handlers
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup(configure({
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


return lsp_setup
