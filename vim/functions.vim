" Toggle deoplete
function! ToggleDeoplete() abort
    if g:deoplete_enabled
        let g:deoplete_enabled = 0
        call deoplete#disable()
        echom 'Deoplete disabled.'
    else
        let g:deoplete_enabled = 1
        call deoplete#enable()
        echom 'Deoplete enabled.'
    endif
endfunction

" Custom func to toggle iminsert option {{{
function! ToggleEscapeMapping()
    if b:escape_mapping
        let b:escape_mapping = 0
        inoremap <buffer> <silent> <esc> <esc>l
        echom 'ESC mapping preserves iminsert value.'
    else
        let b:escape_mapping = 1
        inoremap <buffer> <silent> <esc> <esc>:set iminsert=0<CR>l
        echom 'ESC mapping resets iminsert value.'
    endif
endfunction
" reset imsert by default
inoremap <silent> <esc> <esc>:set iminsert=0<CR>l
augroup toggle_escape
    autocmd!
    autocmd BufEnter * let b:escape_mapping = 1
    autocmd BufEnter * set iminsert=0
    autocmd BufEnter * nnoremap col :call ToggleEscapeMapping()<CR>
augroup END
" }}}
