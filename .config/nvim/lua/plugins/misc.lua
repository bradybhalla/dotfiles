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
        ft = "coq",
        init = function()
            -- don't use default insert mode mappings
            vim.g.coqtail_noimap = 1

            -- easier keymaps for basic functions
            vim.cmd [[
            function CoqtailHookDefineMappings()
                imap <buffer> <S-Down> <Plug>CoqNext
                imap <buffer> <S-Left> <Plug>CoqToLine
                imap <buffer> <S-Up> <Plug>CoqUndo
                nmap <buffer> <S-Down> <Plug>CoqNext
                nmap <buffer> <S-Left> <Plug>CoqToLine
                nmap <buffer> <S-Up> <Plug>CoqUndo
            endfunction
            ]]
        end
    },
}
