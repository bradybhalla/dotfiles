return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        local api = require("nvim-tree.api")

        -- custom mappings

        vim.keymap.set("n", "<leader>ef", function()
            api.tree.open { find_file = true }
        end, { desc = "jump to file in tree" })

        vim.keymap.set("n", "<leader>eo", api.tree.open, { desc = "open tree" })

        vim.keymap.set("n", "<leader>ec", api.tree.close, { desc = "close tree" })


        -- custom mappings in the tree

        local function on_attach(bufnr)
            local function opts(desc)
                return {
                    desc = "nvim-tree: " .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true
                }
            end

            api.config.mappings.default_on_attach(bufnr)

            vim.keymap.set("n", "bo", function()
                for _, mark in ipairs(api.marks.list()) do
                    vim.cmd("tabnew " .. mark.absolute_path)
                end
                api.marks.clear()
            end, opts("Open Bookmarked"))
        end


        -- options

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
            sync_root_with_cwd = true
        }
    end
}
