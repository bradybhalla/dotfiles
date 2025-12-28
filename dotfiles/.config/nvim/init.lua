vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = "yes" -- stop text from shifting

vim.opt.tabstop        = 4     -- tab size 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true -- use spaces instead of tabs

vim.opt.ignorecase     = true -- search case sensitivity
vim.opt.smartcase      = true

vim.opt.breakindent    = true -- wrapping behavior
vim.opt.linebreak      = true
vim.opt.smoothscroll   = true

vim.opt.splitright     = true -- window splitting direction
vim.opt.splitbelow     = true

vim.opt.completeopt:append("menuone") -- show completion menu for one item

vim.g.netrw_banner = 0                -- don't show netrw help
vim.g.mapleader    = " "              -- set leader key


require("./plugins") -- load and setup plugins


vim.cmd.colorscheme "catppuccin-frappe"


vim.keymap.set("v", ">", ">gv")         -- reselect after shifting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("i", "<C-l>", function() -- activate or accept omni completion
    return vim.fn.pumvisible() == 1 and "<C-y>" or "<C-x><C-o>"
end, { expr = true })
vim.keymap.set({ "n", "v" }, "<leader>c", "\"+") -- system clipboard
vim.keymap.set("n", "<leader>w", "<C-w>")        -- window commands


-- misc shortcuts
vim.keymap.set("n", "<leader>q", "<CMD>quit<CR>")
vim.keymap.set("n", "<leader>s", "<CMD>write<CR>")
vim.keymap.set("n", "<leader>o", function()
    local file_path = vim.fn.expand("%")
    if file_path ~= "" then
        _, _ = pcall(vim.system, { "open", "-R", file_path }, {})
    else
        _, _ = pcall(vim.system, { "open", vim.fn.expand("%:p:h") }, {})
    end
end)


-- toggle settings
vim.keymap.set("n", "<leader>ts", function()
    vim.opt_local.spell = not vim.opt_local.spell:get()
end)
vim.keymap.set("n", "<leader>td", function()
    vim.diagnostic.config({
        virtual_text = not vim.diagnostic.config().virtual_text
    })
end)


-- telescope
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>")
vim.keymap.set("n", "<leader>fi",
    "<CMD>Telescope find_files hidden=true no_ignore=true<CR>")
vim.keymap.set("n", "<leader>fg", "<CMD>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<CMD>Telescope help_tags<CR>")


-- language / lsp
vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    require("conform").format({ async = true, lsp_format = "fallback" })
end)
vim.keymap.set("n", "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<leader>lS", "<CMD>Telescope lsp_workspace_symbols<CR>")


-- luasnip
vim.keymap.set("i", "<S-TAB>", function()
    require("luasnip").expand()
end)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    require("luasnip").jump(1)
end)
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    require("luasnip").jump(-1)
end)
vim.keymap.set({ "i", "s" }, "<C-d>", function()
    if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
    end
end)


-- directory
