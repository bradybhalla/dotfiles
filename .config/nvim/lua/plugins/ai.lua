return {
    {
        "github/copilot.vim",
        cmd = "Copilot", -- lazy load on command since I don't trust it
        config = function()
            vim.g.copilot_no_tab_map = true
        end
    }
}
