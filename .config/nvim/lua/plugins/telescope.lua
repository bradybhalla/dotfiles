return {
    "nvim-telescope/telescope.nvim",
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
