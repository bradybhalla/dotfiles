local autopairs = require("nvim-autopairs")
autopairs.setup {}
local Rule = require("nvim-autopairs.rule")
autopairs.add_rule(Rule("$", "$", { "tex", "typst" }))
autopairs.get_rule("'")[1].not_filetypes = { "ocaml" }

require("luasnip").config.setup({
    enable_autosnippets = true,
    update_events = "TextChanged,TextChangedI"
})
require("luasnip.loaders.from_lua").lazy_load()

require("blink.cmp").setup({
    snippets = { preset = "luasnip" },
    keymap = {
        preset = "none",
        ["<C-l>"] = { "select_and_accept", "show" },
        ["<C-p>"] = { "select_prev" },
        ["<C-n>"] = { "select_next" },
        ["<C-e>"] = { "hide" },
        ["<C-j>"] = { "snippet_forward" },
        ["<C-k>"] = { "snippet_backward" },
        ["<C-u>"] = { "show_documentation", "hide_documentation" },
        ["<C-b>"] = { "scroll_documentation_up" },
        ["<C-f>"] = { "scroll_documentation_down" }
    }
})
