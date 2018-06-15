setlocal expandtab
setlocal textwidth&         " Don't set textwidth, linebreaks are inserted
                            " automatically and break everything.
setlocal shiftwidth=4
setlocal tabstop=4
setlocal colorcolumn=80     " Set colocolumn manullay cause textwidth is unset
setlocal comments=:#

setlocal equalprg=black\ --quiet\ --line-length\ 79\ --skip-string-normalization\ -

nnoremap <buffer> <leader>ee :call Flake8()<CR>
iabbrev <buffer> pice from icecream import ic; ic(

function! s:Black(line1, line2)
    execute a:line1 . "," . a:line2 . "!" . &l:equalprg
endfunction

command! -range=% Black call s:Black(<line1>, <line2>)

function! s:Python()
    " SOURCE [reusable window]:
    " https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    silent execute "update"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    echom 'Python: executing current buffer...'
    " add the console output using vim's filter functionality
    silent execute ".!python " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length Note: This is annoying because if you
    " print a lot of lines then your code buffer is forced to a height of one
    " line every time you run this function. However without this line the
    " buffer starts off as a default size and if you resize the buffer then it
    " keeps that custom size after repeated runs of this function. But if you
    " close the output buffer then it returns to using the default size when
    " its recreated
    execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
    redraw
    echom 'Python: done.'
endfunction

command! -nargs=0 Python call s:Python()
