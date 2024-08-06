-- VimTeX settings
vim.cmd([[
let g:vimtex_syntax_conceal["math_bounds"]=0
let g:vimtex_quickfix_open_on_warning=0
]])

-- keymaps
require("which-key").add({
    -- only for current buffer
    buffer = 0,

    -- up/down inside a line
    {
        { "j",  "gj" },
        { "k",  "gk" },
        { "gj", "j" },
        { "gk", "k" },
    },

    { "<leader>b", "<CMD>w<CR><CMD>VimtexCompileSS -pdf -pv<CR>", desc = "quick build" },

    {
        "<leader>C",
        function() vim.opt.conceallevel = 2 - vim.opt.conceallevel:get() end,
        desc = "toggle VimTex conceal"
    }
})


-- VimTeX completions (uses omni instead of lsp)
local cmp = require("cmp")
cmp.setup.buffer {
    sources = cmp.config.sources({
        { name = "omni" },
        { name = "luasnip" }
    }, {
        { name = "buffer" },
    })
}

-- run treesitter parser (it doesn't run by default with highlight off)
local ts_parser = require("nvim-treesitter.parsers")
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    buffer = 0,
    callback = function()
        local parser = ts_parser.get_parser()
        if parser then
            parser:parse()
        end
    end
})
