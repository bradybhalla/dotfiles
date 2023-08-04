-- special completions
require("cmp").setup.buffer {
    formatting = {
        format = function(entry, vim_item)
            if entry.source.name == "omni" then
                -- only display citation name
                for _ in (vim_item.menu):gmatch("%[a%] ?(.*)") do
                    vim_item.kind = "Citation"
                    vim_item.menu = ""
                end

                -- display math symbol and source
                for menu, kind in (vim_item.menu):gmatch("%[cmd: (.+)%] ?(.*)") do
                    vim_item.kind = kind
                    vim_item.menu = menu
                end
            end
            return vim_item
        end,
    },
    sources = {
        { name = "omni" },
        { name = "ultisnips" },
        { name = "buffer" },
    },
}


-- autopair rules
local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")

npairs.add_rule(Rule("$", "$", { "tex" }))


-- conceal math
vim.cmd([[
set conceallevel=2
let g:vimtex_syntax_conceal["math_bounds"]=0

highlight Conceal guifg=#f4b8e4 guibg=NONE
]])
