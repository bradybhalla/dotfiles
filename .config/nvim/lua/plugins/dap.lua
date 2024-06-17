return {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap-python" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("dap-python").setup("python")

        require("dapui").setup()

        vim.fn.sign_define("DapBreakpoint", { texthl = "DapBreakpoint", text = "●", numhl = "" })
        vim.fn.sign_define("DapStopped", { texthl = "DapStopped", text = "→", numhl = "" })
    end
}
