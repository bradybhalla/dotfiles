local M = {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
}


function M.config()
    local builtin = require('telescope.builtin')

    -- find files 
    vim.keymap.set('n', '<leader>ff', function ()
        builtin.find_files{hidden=true}
    end)

    -- find files (including ignored) 
    vim.keymap.set('n', '<leader>fa', function ()
        builtin.find_files{hidden=true, no_ignore=true}
    end)

    -- search text
    vim.keymap.set('n', '<leader>fg', function ()
        builtin.live_grep{hidden=true}
    end)

    -- search buffers
    vim.keymap.set('n', '<leader>fb', builtin.buffers)

    -- search help menus
    vim.keymap.set('n', '<leader>fh', builtin.help_tags)
end


return M
