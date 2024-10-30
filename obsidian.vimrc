" let mapleader=,
" Can't set leaders in Obsidian vim, so the key just has to be used consistently.
" However, it needs to be unmapped, to not trigger default behavior:
" https://github.com/esm7/obsidian-vimrc-support#some-help-with-binding-space-chords-doom-and-spacemacs-fans
unmap ,

" Yank to system clipboard
set clipboard=unnamed

" Keep pasting the same thing
vnoremap gp "_dP

" Y consistent with D and C to the end of line
nnoremap Y y$

" Navigate visual lines rather than logical ones
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" Go to last change (HACK, only works to jump to the last location)
nnoremap g; u<C-r>

" Undo/redo consistently on one key
nnoremap U <C-r>

inoremap <C-d> <Delete>

" Add empty lines
nnoremap [<Space> O<Esc>j
nnoremap ]<Space> o<Esc>k

exmap 0 goLineLeftSmart
exmap $ goLineRight

" Surround
exmap surround_wiki surround [[ ]]
map [[ :surround_wiki<CR>

" Leap to anywhere
exmap jumpToLink obcommand mrj-jump-to-link:activate-lightspeed-jump
nunmap s
nmap s :jumpToLink<CR>
nmap S :jumpToLink<CR>

" Open in the file explorer
exmap reveal obcommand file-explorer:reveal-active-file
nmap - :reveal<CR>

" Saving, renaming, moving, deleting files
exmap save obcommand editor:save-file
nmap ,, :save<CR>

exmap rename_file obcommand workspace:edit-file-title
nmap ,rn :rename_file<CR>

exmap delete_file obcommand app:delete-file
nmap ,dl :delete_file<CR>

exmap move_file obcommand file-explorer:move-file
nmap ,mv :move_file<CR>

" Splitting, moving and closing windows
exmap split_horizontal obcommand workspace:split-horizontal
nmap <C-w>- :split_horizontal<CR>
nmap <C-w>_ :split_horizontal<CR>
nmap <C-w>' :split_horizontal<CR>

exmap split_vertical obcommand workspace:split-vertical
nmap <C-w>\ :split_vertical<CR>
nmap <C-w>| :split_vertical<CR>
nmap <C-w>" :split_vertical<CR>

exmap top obcommand editor:focus-top
nmap <C-k> :top<CR>
exmap bottom obcommand editor:focus-bottom
nmap <C-j> :bottom<CR>
exmap left obcommand editor:focus-left
nmap <C-h> :left<CR>
exmap right obcommand editor:focus-right
nmap <C-l> :right<CR>

exmap close_others obcommand workspace:close-others
nmap <C-w>o :close_others<CR>
nmap <C-w><C-o> :close_others<CR>

" Go back and forward with Ctrl+O and Ctrl+I
" (make sure to remove default Obsidian shortcuts for these to work)
exmap back obcommand app:go-back
nmap <C-o> :back<CR>
exmap forward obcommand app:go-forward
nmap <C-i> :forward<CR>

" Open link under cursor
exmap followLink :obcommand editor:follow-link
nmap <CR> :followLink<CR>

nnoremap <Space> :nohl<CR>
inoremap <Esc> <Esc>l
