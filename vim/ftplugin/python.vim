setlocal expandtab
setlocal textwidth&         " Don't set textwidth, linebreaks are inserted
                            " automatically and break everything.
setlocal shiftwidth=4
setlocal tabstop=4
setlocal colorcolumn=80     " Set colocolumn manullay cause textwidth is unset
setlocal comments=:#

nnoremap <buffer> <leader>ee :call Flake8()<CR>
iabbrev <buffer> pice from icecream import ic; ic(
