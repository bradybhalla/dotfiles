return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local api = require("nvim-tree.api")

        require("which-key").register({
            ["<leader>e"] = { name = "tree" }
        })

        vim.keymap.set("n", "<leader>ef", function()
            api.tree.open { find_file = true }
        end, { desc = "jump to file in tree" })

        vim.keymap.set("n", "<leader>eo", api.tree.open, { desc = "open tree" })

        vim.keymap.set("n", "<leader>ec", api.tree.close, { desc = "close tree" })

        require("nvim-tree").setup {
            tab = {
                sync = {
                    open = true,
                    close = true
                },
            },
            filters = {
                git_ignored = false,
            },
            sync_root_with_cwd = true
        }
    end
}
