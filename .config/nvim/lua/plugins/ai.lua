return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },
        cmd = "Copilot", -- don't do anything until command is run
        build = "make tiktoken",
        config = function()
            vim.g.copilot_no_tab_map = true

            require("CopilotChat").setup {}
        end
    }
}
