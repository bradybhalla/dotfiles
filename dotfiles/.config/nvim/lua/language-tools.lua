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

