return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },
            { "nvim-lua/plenary.nvim" },
        },
        cmd = "LoadCopilot", -- need to run command to open connection
        build = "make tiktoken",
        config = function()
            vim.g.copilot_no_tab_map = true

            require("CopilotChat").setup {}

            vim.api.nvim_create_user_command("LoadCopilot", function() end, {})
        end
    }
}
