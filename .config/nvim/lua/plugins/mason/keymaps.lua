local maps = {}

maps.general = function(client, bufnr)
    local telescope_builtin = require("telescope.builtin")

    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<leader>lF", vim.lsp.buf.format, { desc = "format file", buffer = bufnr })
    end

    if client.server_capabilities.definitionProvider then
        vim.keymap.set("n", "<leader>ld", telescope_builtin.lsp_definitions,
            { desc = "go to definition", buffer = bufnr })
    end

    if client.server_capabilities.referencesProvider then
        vim.keymap.set("n", "<leader>lr", telescope_builtin.lsp_references, { desc = "find references", buffer = bufnr })
    end

    if client.server_capabilities.documentSymbolProvider then
        vim.keymap.set("n", "<leader>ls", telescope_builtin.lsp_document_symbols,
            { desc = "search document symbols", buffer = bufnr })
    end

    if client.server_capabilities.workspaceSymbolProvider then
        vim.keymap.set("n", "<leader>lS", telescope_builtin.lsp_dynamic_workspace_symbols,
            { desc = "search workspace symbols", buffer = bufnr })
    end

    if client.server_capabilities.hoverProvider then
        vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "hover", buffer = bufnr })
    end

    if client.server_capabilities.renameProvider then
        vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "rename", buffer = bufnr })
    end

    -- help with function args
    if client.server_capabilities.signatureHelpProvider then
        vim.keymap.set("n", "<leader>lk", vim.lsp.buf.signature_help, { desc = "signature help", buffer = bufnr })
    end
end

maps.lsp = function(client, bufnr)
    -- show diagnostics
    vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "show diagnostic", buffer = bufnr })

    vim.keymap.set("n", "<leader>l,", vim.diagnostic.goto_prev, { desc = "go to previous diagnostic", buffer = bufnr })
    vim.keymap.set("n", "<leader>l;", vim.diagnostic.goto_next, { desc = "go to next diagnostic", buffer = bufnr })
end

maps.null_ls = function(client, bufnr) end

return maps
