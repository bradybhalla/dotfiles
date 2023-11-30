-- Latex config file

-- special completions
require("cmp").setup.buffer {
    formatting = {
        format = function(entry, vim_item)
            if entry.source.name == "omni" then
                local cmp_info, cmp_symbol = (vim_item.menu):match("%[(.+)%] ?(.*)")

                if cmp_info == nil then
                    -- other
                    vim_item.kind = "latex"
                elseif #cmp_info == 1 then
                    -- citation
                    vim_item.kind = "citation"
                    vim_item.menu = cmp_info
                else
                    local cmp_type, cmp_source = cmp_info:match("(.+): (.+)")

                    if cmp_type == nil then
                        -- other without source
                        vim_item.kind = cmp_info
                        vim_item.menu = ""
                    elseif cmp_type == "cmd" then
                        -- math symbols / commands
                        vim_item.kind = cmp_symbol == "" and "cmd" or cmp_symbol
                        vim_item.menu = cmp_source
                    else
                        -- other with source
                        vim_item.kind = cmp_type
                        vim_item.menu = cmp_source
                    end
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
local autopairs = require("nvim-autopairs")
autopairs.add_rule(Rule("$", "$", { "tex" }))

-- run treesitter parser on InsertLeave
local ts_parser = require("nvim-treesitter.parsers")
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    buffer = 0,
    callback = function()
        local parser = ts_parser.get_parser()
        if parser then
            parser:parse()
        end
    end
})

-- settings
vim.cmd([[
let g:vimtex_syntax_conceal["math_bounds"]=0
]])

-- quickly build
vim.keymap.set(
    "n", "<leader>b",
    "<CMD>w<CR><CMD>!cd \"%:h\" && latexmk -pdf \"%:t:r\" && open \"%:t:r.pdf\"<CR>",
    {
        desc = "quick build latex",
        buffer = true
    }
)

-- VimTeX conceal
vim.keymap.set("n", "<leader>C", function()
    -- toggle between 0 and 2
    vim.o.conceallevel = 2 - vim.o.conceallevel
end, { desc = "toggle VimTeX conceal", buffer = true })
