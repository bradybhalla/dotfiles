--------------------
-- Install plugins -
--------------------

-- TODO: blink.cmp doesn't have install instructions for vim.pack but this seems to work okay for now
vim.api.nvim_create_autocmd("PackChanged", {
    callback =
        function(ev)
            local name, kind = ev.data.spec.name, ev.data.kind
            if name == "blink.cmp" and (kind == "install" or kind == "update") then
                vim.system({ "cargo build --release" }, { cwd = ev.data.path })
            end
        end
})

vim.pack.add({
    -- interface
    "https://github.com/catppuccin/nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim", -- dependency for telescope
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/nvim-mini/mini.icons", -- dependency for oil

    -- editing
    "https://github.com/tpope/vim-surround",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/L3MON4D3/LuaSnip",
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.0"), },

    -- language tools
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/mfussenegger/nvim-jdtls",
    "https://github.com/tarides/ocaml.nvim",

    -- misc
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/lervag/vimtex",
})

---------------------------
-- General configuration -
---------------------------

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = "yes" -- stop text from shifting

vim.opt.tabstop        = 4     -- tab size 4
vim.opt.shiftwidth     = 0     -- use tabstop
vim.opt.expandtab      = true  -- use spaces instead of tabs

vim.opt.ignorecase     = true  -- search case sensitivity
vim.opt.smartcase      = true

vim.opt.breakindent    = true -- wrapping behavior
vim.opt.linebreak      = true
vim.opt.smoothscroll   = true

vim.opt.splitright     = true -- window splitting direction
vim.opt.splitbelow     = true

vim.opt.spellsuggest   = "9" -- max 9 items in z=

vim.g.mapleader        = " " -- set leader key


require("./interface")      -- colorscheme, navigation, ...
require("./editing")        -- autocompletion, snippets, ...
require("./language-tools") -- lsp, formatters, ...
require("./misc-plugins")


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


vim.keymap.set("n", "<leader>qq", "<CMD>qall<CR>")
vim.keymap.set("n", "<leader>qs", "<CMD>wqall<CR>")

vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files hidden=true<CR>")
vim.keymap.set("n", "<leader>fh",
    "<CMD>Telescope find_files hidden=true no_ignore=true<CR>")
vim.keymap.set("n", "<leader>fs", "<CMD>write<CR>")
vim.keymap.set("n", "<leader>fo", function()
    local file_path = vim.fn.expand("%")
    if file_path ~= "" then
        _, _ = pcall(vim.system, { "open", "-R", file_path }, {})
    else
        _, _ = pcall(vim.system, { "open", vim.fn.expand("%:p:h") }, {})
    end
end)

vim.keymap.set("n", "<leader>bb", "<CMD>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>bd", "<CMD>bdelete<CR>")

vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<leader>wd", "<CMD>close<CR>")

vim.keymap.set("n", "<leader>gg", "<CMD>Telescope live_grep<CR>")

vim.keymap.set("n", "<leader>h", "<CMD>Telescope help_tags<CR>")

vim.keymap.set({ "n", "v" }, "<leader>c", "\"+")
vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>")
vim.keymap.set("n", "<leader>G", function()
    local dir = vim.fn.expand("%:h")
    if vim.fn.isdirectory(dir) == 0 then
        dir = "."
    end
    require("toggleterm.terminal").Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        dir = dir,
        count = 99
    }):toggle()
end)


-- toggles
vim.keymap.set("n", "<leader>ts", function()
    vim.opt_local.spell = not vim.opt_local.spell:get()
    vim.notify("spellcheck: " .. (vim.opt_local.spell:get() and "on" or "off"))
end)
vim.keymap.set("n", "<leader>td", function()
    local val = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = val})
    vim.notify("diagnostic virtual text: " .. (val and "on" or "off"))
end)


-- language / lsp
vim.keymap.set({ "n", "v" }, "<leader>lf", function()
    require("conform").format()
end)
vim.keymap.set("n", "<leader>ls", "<CMD>Telescope lsp_document_symbols<CR>")
vim.keymap.set("n", "<leader>lS", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>")


-- snippets (others defined in blink.cmp setup)
vim.keymap.set("i", "<S-TAB>", function()
    require("luasnip").expand()
end)
vim.keymap.set({ "i", "s" }, "<C-d>", function()
    if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
    end
end)


------------------------------------
-- Filetype-specific configuration -
------------------------------------

-- LaTeX
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.latex", {}),
    pattern = "tex",
    callback = function(args)
        -- build and show current document
        vim.keymap.set("n", "<leader>b", "<CMD>w<CR><CMD>VimtexCompileSS -pdf -pv<CR>", { buffer = args.buf })

        -- toggle conceal
        vim.keymap.set("n", "<leader>tc", function()
            vim.opt.conceallevel = 2 - vim.opt.conceallevel:get()
        end, { buffer = true })
    end
})


-- Typst
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.typst", {}),
    pattern = "typst",
    callback = function(args)
        vim.keymap.set("n", "<leader>b", "<CMD>silent !open -a Skim %:r.pdf<CR>", { buffer = args.buf })
    end
})


-- Java
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.java", {}),
    pattern = "java",
    callback = function()
        require("jdtls").start_or_attach({ cmd = { "jdtls" } })
    end
})


-- OCaml
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("custom.ocaml", {}),
    pattern = { "ocaml", "dune" },
    callback = function(args)
        vim.opt_local.tabstop = 2
        vim.keymap.set("n", "<C-c><C-a>", "<CMD>OCamlSwitchIntfImpl<CR>", { buffer = args.buf })
        vim.keymap.set("n", "<leader>li", "<CMD>OCamlSwitchIntfImpl<CR>", { buffer = args.buf })
        vim.keymap.set("n", "<leader>lI", "<CMD>OCamlInferIntf<CR>", { buffer = args.buf })
    end
})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("custom.ocaml", { clear = false }),
    pattern = { "*.ml", "*.mli", "dune", "dune-project" },
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end
})
