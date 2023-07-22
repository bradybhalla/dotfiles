local M = { 
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
}

function M.config()
    require("catppuccin").setup({
        transparent_background=true,
        integrations = {
            -- cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            -- notify = false,
            -- mini = false,
            treesitter_context = true,
            mason = true
       }
    })
    vim.cmd.colorscheme "catppuccin-frappe"
end

return M
