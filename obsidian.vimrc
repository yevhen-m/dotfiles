" let mapleader=,
" can't set leaders in Obsidian vim, so the key just has to be used consistently.
" However, it needs to be unmapped, to not trigger default behavior: https://github.com/esm7/obsidian-vimrc-support#some-help-with-binding-space-chords-doom-and-spacemacs-fans
unmap ,

" Yank to system clipboard
set clipboard=unnamed

" Y consistent with D and C to the end of line
nnoremap Y y$

" Navigate visual lines rather than logical ones
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

" HJKL behaves like hjkl, but bigger distance
noremap H g0
noremap L g$
nnoremap J 6gj
nnoremap K 6gk
vnoremap J 6j
vnoremap K 6k

" dj = delete 2 lines, dJ = delete 3 lines
onoremap J 2j

" Go to last change (HACK, only works to jump to the last location)
nnoremap gc u<C-r>

" Undo/redo consistently on one key
nnoremap U <C-r>

inoremap <C-d> <Delete>

" Open link under cursor
exmap followLink :obcommand editor:follow-link
nmap <CR> :followLink

exmap 0 goLineLeftSmart
exmap $ goLineRight

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_backticks surround ` `
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }

map [[ :surround_wiki
nunmap s
vunmap s
map s" :surround_double_quotes
map s' :surround_single_quotes
map s` :surround_backticks
map sb :surround_brackets
map s( :surround_brackets
map s) :surround_brackets
map s[ :surround_square_brackets
map s[ :surround_square_brackets
map s{ :surround_curly_brackets
map s} :surround_curly_brackets

exmap jumpToLink obcommand mrj-jump-to-link:activate-lightspeed-jump
nmap gs :jumpToLink
