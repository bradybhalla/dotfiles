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

                " since <C-l> doesn't clear highlights
                nmap <buffer> <Esc> <CMD>noh\|echo<CR>

                imap <buffer> <C-j> <Plug>CoqNext
                imap <buffer> <C-l> <Plug>CoqToLine
                imap <buffer> <C-k> <Plug>CoqUndo
            endfunction
            ]]
        end
    }
}
