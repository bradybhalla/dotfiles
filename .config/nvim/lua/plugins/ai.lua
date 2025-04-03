return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            {
                "github/copilot.vim",
                init = function ()
                    vim.g.copilot_no_maps = true
                end
            },
            { "nvim-lua/plenary.nvim" },
        },
        cmd = "Copilot", -- don't do anything until command is run
        build = "make tiktoken",
        config = function()
            require("CopilotChat").setup {}
        end
    }
}
