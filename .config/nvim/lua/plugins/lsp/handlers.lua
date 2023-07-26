local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
    -- custom mappings

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>lF", vim.lsp.buf.format)

    vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions)
    vim.keymap.set("n", "<leader>lr", builtin.lsp_references)

    vim.keymap.set("n", "<leader>lR", function()
        -- some LSPs need inital query
        vim.ui.input({ prompt = "Initial query: " }, function(query)
            builtin.lsp_workspace_symbols({ query = query })
        end)
    end)

    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover)
    vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help)

    -- open float with diagnostics
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float)

    vim.keymap.set("n", "<leader>l,", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "<leader>l;", vim.diagnostic.goto_next)

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

return {
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
