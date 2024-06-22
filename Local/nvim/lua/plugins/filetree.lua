return {
    "nvim-tree/nvim-tree.lua",
    cmd = {
        "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeClose"
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
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
}
