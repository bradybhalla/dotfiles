-- build and show current document
vim.keymap.set("n", "<leader>b", "<CMD>w<CR><CMD>VimtexCompileSS -pdf -pv<CR>", { buffer = true })

-- toggle conceal
vim.keymap.set("n", "<leader>tc", function()
    vim.opt.conceallevel = 2 - vim.opt.conceallevel:get()
end, { buffer = true })

-- move within a line
vim.keymap.set({"n", "v"}, "j", "gj", {buffer = true})
vim.keymap.set({"n", "v"}, "k", "gk", {buffer = true})
vim.keymap.set({"n", "v"}, "gj", "j", {buffer = true})
vim.keymap.set({"n", "v"}, "gk", "k", {buffer = true})
