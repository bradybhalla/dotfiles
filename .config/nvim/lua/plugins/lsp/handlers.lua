local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
    -- custom mappings

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>l", "<leader>l", { desc = "LSP prefix", buffer = true })

    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<leader>lF", vim.lsp.buf.format, { desc = "format file", buffer = true })
    end

    if client.server_capabilities.definitionProvider then
        vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "go to definition", buffer = true })
    end

    if client.server_capabilities.referencesProvider then
        vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "find references", buffer = true })
    end

    if client.server_capabilities.workspaceSymbolProvider then
        vim.keymap.set("n", "<leader>lS", builtin.lsp_dynamic_workspace_symbols,
            { desc = "search symbols", buffer = true })
    end

    if client.server_capabilities.hoverProvider then
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "hover", buffer = true })
    end

    if client.server_capabilities.renameProvider then
        vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "rename", buffer = true })
    end

    -- help with function args
    if client.server_capabilities.signatureHelpProvider then
        vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help, { desc = "signature help", buffer = true })
    end

    -- open float with diagnostics
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "show diagnostic", buffer = true })

    vim.keymap.set("n", "<leader>l,", vim.diagnostic.goto_prev, { desc = "go to previous diagnostic", buffer = true })
    vim.keymap.set("n", "<leader>l;", vim.diagnostic.goto_next, { desc = "go to next diagnostic", buffer = true })


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
