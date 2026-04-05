------------
-- Editing -
------------

-- TODO: blink.cmp doesn't have install instructions for vim.pack but this seems to work okay for now
local hooks = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "blink.cmp" and (kind == "install" or kind == "update") then
        vim.system({ "cargo build --release" }, { cwd = ev.data.path })
    end
end
vim.api.nvim_create_autocmd("PackChanged", { callback = hooks })
vim.pack.add({
    "https://github.com/tpope/vim-surround",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/L3MON4D3/LuaSnip",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.0"), },
})

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
