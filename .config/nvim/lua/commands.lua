----------
-- Setup -
----------

vim.api.nvim_create_user_command("SetupTreesitter", function()
    vim.cmd(":TSInstall c lua python json typescript javascript latex")
end, { desc = "Treesitter setup" })

vim.api.nvim_create_user_command("SetupMason", function()
    vim.cmd(":MasonInstall pyright lua-language-server typescript-language-server clangd texlab black beautysh prettier")
end, { desc = "Mason setup" })

vim.api.nvim_create_user_command("Setup", function()
    vim.cmd(":SetupTreesitter")
    vim.cmd(":SetupMason")
end, { desc = "setup" })


-------------------
-- Keymap helpers -
-------------------

vim.api.nvim_create_user_command("OpenFinder", function()
    local file_path = vim.fn.expand("%")
    if file_path ~= "" then
        os.execute("open -R \"" .. file_path .. "\"")
    else
        os.execute("open \"" .. vim.fn.expand("%:p:h") .. "\"")
    end
end, { desc = "reveal in Finder" })

vim.api.nvim_create_user_command("ToggleSpell", function()
    vim.opt_local.spell = not vim.opt_local.spell._value
end, { desc = "toggle spellcheck" })

vim.api.nvim_create_user_command("Lazygit", function()
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
end, { desc = "open lazygit" })
