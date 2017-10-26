setlocal expandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal colorcolumn=+1
setlocal keywordprg=:help

function! s:separator_line()
    let result = '" ' . repeat('-', 76)
    return result
endfunction

let b:sep_line = s:separator_line()
iabbrev <buffer> #l <C-R>=b:sep_line<CR>
