return function()
    local default_config = {
        on_attach = function(client, bufnr)
            require("plugins.lsp.keymaps").general(client, bufnr)
            require("plugins.lsp.keymaps").lsp(client, bufnr)
        end,
        capabilities = require("cmp_nvim_lsp").default_capabilities()
    }

    -- pass in custom options
    local function configure(changes)
        return vim.tbl_deep_extend("force", default_config, changes)
    end


    local lspconfig = require("lspconfig")

    lspconfig.pyright.setup(configure({}))

    require("neodev").setup()
    lspconfig.lua_ls.setup(configure({}))

    lspconfig.tsserver.setup(configure({
        settings = {
            typescript = { format = { semicolons = "insert" } },
            javascript = { format = { semicolons = "insert" } }
        }
    }))

    lspconfig.ocamllsp.setup(configure({}))

    lspconfig.clangd.setup(configure({}))

    lspconfig.hls.setup(configure({}))
end
