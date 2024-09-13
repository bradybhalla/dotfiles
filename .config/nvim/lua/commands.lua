local commands = {

    SetupTreesitter = function()
        -- install commonly used parsers that are not included by default
        local ts_parsers = {
            "json", "typescript", "javascript", "latex", "ocaml", "haskell", "python", "cpp"
        }
        for _, parser in ipairs(ts_parsers) do
            require("nvim-treesitter.install").ensure_installed(parser)
        end
    end,


    FormatBuffer = function()
        require("conform").format({ async = true, lsp_format = "fallback" })
    end,


    OpenFinder = function()
        local file_path = vim.fn.expand("%")
        local success
        if file_path ~= "" then
            success, _ = pcall(vim.system, { "open", "-R", file_path }, {})
        else
            success, _ = pcall(vim.system, { "open", vim.fn.expand("%:p:h") }, {})
        end
        if not success then
            vim.print("`open` failed to execute")
        end
    end,


    ToggleSpell = function()
        vim.opt_local.spell = not vim.opt_local.spell:get()
    end,


    Lazygit = function()
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
    end

}


for name, cmd in pairs(commands) do
    vim.api.nvim_create_user_command(name, cmd, {})
end
