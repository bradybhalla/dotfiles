local autopairs = require("nvim-autopairs")
autopairs.setup {}
local Rule = require("nvim-autopairs.rule")
autopairs.add_rule(Rule("$", "$", { "tex", "typst" }))
autopairs.get_rule("'")[1].not_filetypes = { "ocaml" }

-- snippets
require("luasnip").config.setup({
    enable_autosnippets = true,
    update_events = "TextChanged,TextChangedI"
})
require("luasnip.loaders.from_lua").lazy_load()
vim.keymap.set("i", "<S-TAB>", function()
    require("luasnip").expand()
end)
vim.keymap.set({ "i", "s" }, "<C-d>", function()
    if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
    end
end)

-- autocompletion
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

-- editing behavior
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set({ "n", "v" }, "j", "gj")
vim.keymap.set({ "n", "v" }, "k", "gk")
vim.keymap.set({ "n", "v" }, "gj", "j")
vim.keymap.set({ "n", "v" }, "gk", "k")

