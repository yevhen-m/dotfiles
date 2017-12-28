" Vim {{{
cnoreabbrev <expr> ln getcmdtype() == ":" && getcmdline() == 'ln' ? 'lne' : 'ln'
cnoreabbrev <expr> cl getcmdtype() == ":" && getcmdline() == 'cl' ? 'close' : 'cl'
iabbrev adn and
iabbrev waht what
iabbrev tehn then
iabbrev treu true
" }}}

" Python {{{
iabbr improt import
iabbr immport import
iabbr ipmort import
iabbr ipdb import ipdb; ipdb.set_trace(context=10)
iabbr pdb import pdb; pdb.set_trace()
" }}}
