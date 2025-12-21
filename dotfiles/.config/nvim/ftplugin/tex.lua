-- keymaps
require("which-key").add({
    buffer = 0,

    { "<leader>b", "<CMD>w<CR><CMD>VimtexCompileSS -pdf -pv<CR>", desc = "quick build" },

    {
        "<leader>C",
        function() vim.opt.conceallevel = 2 - vim.opt.conceallevel:get() end,
        desc = "toggle VimTex conceal"
    }
})
