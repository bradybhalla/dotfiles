return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        defaults = {
            file_ignore_patterns = { "^.git/" }
        },
        pickers = {
            live_grep = {
                additional_args = { "--hidden" }
            }
        }
    }
}
