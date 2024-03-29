return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("which-key").register({
            ["<leader>f"] = {name = "telescope"}
        })

        local builtin = require("telescope.builtin")

        -- find files
        vim.keymap.set("n", "<leader>ff", function()
            builtin.find_files { hidden = true }
        end, { desc = "find file" })

        -- find files (including ignored)
        vim.keymap.set("n", "<leader>fa", function()
            builtin.find_files { hidden = true, no_ignore = true }
        end, { desc = "find file (no ignore)" })

        -- search text
        vim.keymap.set("n", "<leader>fg", function()
            builtin.live_grep { additional_args = { "--hidden" } }
        end, { desc = "search text" })

        -- search buffers
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffer" })

        -- search help menus
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "search help" })

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = { "^.git/" }
            }

        })
    end
}
