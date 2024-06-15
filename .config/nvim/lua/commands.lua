----------
-- Setup -
----------
local ts_parsers = {
    "json", "typescript", "javascript", "latex", "ocaml", "haskell"
}
local mason_install = {
    "pyright", "lua-language-server", "typescript-language-server", "clangd", "ocaml-lsp",
    "haskell-language-server", "ocamlformat", "black", "beautysh", "prettier"
}

vim.api.nvim_create_user_command("SetupTreesitter", function()
    for _, parser in ipairs(ts_parsers) do
        require("nvim-treesitter.install").ensure_installed(parser)
    end
end, { desc = "Treesitter setup" })

vim.api.nvim_create_user_command("SetupMason", function()
    require("mason.api.command").MasonInstall(mason_install, {})
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
    local success
    if file_path ~= "" then
        success, _ = pcall(vim.system, {"open", "-R", file_path}, {})
    else
        success, _ = pcall(vim.system, {"open", vim.fn.expand("%:p:h")}, {})
    end
    if not success then
        vim.print("`open` failed to execute")
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
