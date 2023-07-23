return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local api = require "nvim-tree.api"

        -- custom mappings

        vim.keymap.set("n", "<leader>ef", function ()
            api.tree.open{find_file=true}
        end)

        vim.keymap.set("n", "<leader>eo", function ()
            api.tree.open()
        end)


        vim.keymap.set("n", "<leader>ec", function ()
            api.tree.close()
        end)


        -- options
        
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
