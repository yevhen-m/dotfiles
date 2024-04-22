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
map [[ :surround_wiki

exmap jumpToLink obcommand mrj-jump-to-link:activate-lightspeed-jump
nunmap s
nmap s :jumpToLink
