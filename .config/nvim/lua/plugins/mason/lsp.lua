local lspconfig = require("lspconfig")
local setup_keymaps = require("plugins.mason.keymaps")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_setup = {}


lsp_setup.ensure_installed = {
    "lua_ls", "pyright", "tsserver", "texlab"
}

local default_config = {
    on_attach = function(client, bufnr)
        setup_keymaps.general(client, bufnr)
        setup_keymaps.lsp()
    end,
    capabilities = capabilities
}

-- pass in custom options
local function configure(changes)
    return vim.tbl_deep_extend("force", default_config, changes)
end

lsp_setup.handlers = {
    -- default handler
    function(server_name)
        lspconfig[server_name].setup(configure({}))
    end,

    -- specific handlers
    ["lua_ls"] = function()
        lspconfig.lua_ls.setup(configure({
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

    ["pyright"] = function () end
}


return lsp_setup
