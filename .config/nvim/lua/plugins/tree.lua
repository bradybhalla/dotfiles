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
    vim.keymap.set("n", "<leader>e", function ()
        api.tree.toggle{find_file = true, focus = true}
    end)

    require("nvim-tree").setup {
        on_attach = on_attach,
    }
end


return M