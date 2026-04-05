-------------------
-- Language tools -
-------------------

vim.pack.add({
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/mfussenegger/nvim-jdtls",
    "https://github.com/tarides/ocaml.nvim",
})

require("mason").setup()

require("conform").setup({
    formatters_by_ft = {
        ocaml = { "ocamlformat" },
        python = { "black" },
        nix = { "nixfmt" }
    },
    default_format_opts = { lsp_format = "fallback" }
})

require("lazydev").setup()

require("ocaml").setup({
    params = {
        client = "ocamllsp",
    },
    keymaps = {}
})

-----------------
-- LSP settings -
-----------------

vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = true
})

vim.lsp.config("tinymist", {
    settings = {
        exportPdf = "onSave"
    }
})

vim.lsp.enable({
    "pyright", "lua_ls", "ts_ls", "ocamllsp", "clangd",
    "rust_analyzer", "tinymist", "hls"
})

