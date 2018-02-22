setlocal expandtab
setlocal textwidth&         " Don't set textwidth, linebreaks are inserted
                            " automatically and break everything.
setlocal shiftwidth=4
setlocal tabstop=4
setlocal colorcolumn=80     " Set colocolumn manullay cause textwidth is unset
setlocal comments=:#

nnoremap <buffer> gd :let varname = '\<<C-R><C-W>\>'<CR>?\<def\><CR>/<C-R>=varname<CR><CR>
