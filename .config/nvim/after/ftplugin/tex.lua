-- completions with math symbols
require("cmp").setup.buffer {
    formatting = {
        format = function(entry, vim_item)
            -- extract symbol and source from vimtex completions
            if entry.source.name == "omni" then
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
