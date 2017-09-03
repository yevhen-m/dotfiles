" Vim {{{
" TODO refine ln abbr
cabbrev ln lne
iabbrev adn and
iabbrev waht what
iabbrev tehn then
iabbrev treu true
" }}}

" Python {{{
iabbr improt import
iabbr ipmort import
iabbr ipdb import ipdb; ipdb.set_trace()
iabbr pdb import pdb; pdb.set_trace()
" }}}

" Fugitive {{{
cnoreabbrev gvdiff Gvdiff
cnoreabbrev gdiff Gdiff
cnoreabbrev gedit Gedit
cnoreabbrev gstatus Gstatus
cnoreabbrev gwrite Gwrite
cnoreabbrev gcommit Gcommit
cnoreabbrev gread Gread
" }}}

" Ack.vim {{{
" Don't jump to the first match
cnoreabbrev Ack Ack!
cnoreabbrev LAck LAck!
" }}}

" GV plugin {{{
cnoreabbrev gv GV
cnoreabbrev Gv GV
" }}}