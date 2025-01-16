return {
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
}
