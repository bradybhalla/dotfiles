return {
    { "akinsho/toggleterm.nvim", opts = {} },
    { "lewis6991/gitsigns.nvim", opts = {} },
    {
        "lervag/vimtex",
        init = function()
            -- global settings
            vim.g.vimtex_quickfix_open_on_warning = 0
            vim.g.vimtex_syntax_conceal = { math_bounds = 0 }

            -- more configuration in after/ftplugin/tex.lua
        end
    },
    {
        "whonore/Coqtail",
        init = function()
            -- don't use default insert mode mappings
            vim.g.coqtail_noimap = 1

            -- easier keymaps for basic functions
            vim.cmd [[
            function CoqtailHookDefineMappings()
                nmap <buffer> <C-j> <Plug>CoqNext
                nmap <buffer> <C-l> <Plug>CoqToLine
                nmap <buffer> <C-k> <Plug>CoqUndo

                imap <buffer> <M-j> <Plug>CoqNext
                imap <buffer> <M-l> <Plug>CoqToLine
                imap <buffer> <M-k> <Plug>CoqUndo
            endfunction
            ]]
        end
    }
}
