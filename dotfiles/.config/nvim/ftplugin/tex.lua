vim.keymap.set("n", "<leader>b", "<CMD>w<CR><CMD>VimtexCompileSS -pdf -pv<CR>", { buffer = true })
vim.keymap.set("n", "<leader>C", function()
    vim.opt.conceallevel = 2 - vim.opt.conceallevel:get()
end, { buffer = true })
