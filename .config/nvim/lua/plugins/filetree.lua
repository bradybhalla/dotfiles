local M = {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    }
}

function M.config()
    local api = require "nvim-tree.api"

    local function on_attach(bufnr)
        local function opts()
            return {noremap = true, silent = true, nowait = true }
        end

        api.config.mappings.default_on_attach(bufnr)

        -- custom mappings for inside the tree buffer
        vim.keymap.set("n", "?", api.tree.toggle_help)
    end

    -- general custom mappings

    vim.keymap.set("n", "<leader>ef", function ()
        api.tree.open{find_file=true}
    end)

    vim.keymap.set("n", "<leader>eo", function ()
        api.tree.open()
    end)


    vim.keymap.set("n", "<leader>ec", function ()
        api.tree.close()
    end)

    require("nvim-tree").setup {
        on_attach = on_attach,
        tab = {
            sync = {
              open = true,
              close = true
            },
        },
        filters = {
            git_ignored = false,
        },
    }
end

return M
