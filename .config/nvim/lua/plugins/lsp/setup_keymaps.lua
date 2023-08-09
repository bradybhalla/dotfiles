return function(client, bufnr)
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
end
