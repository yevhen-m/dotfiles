" Autoinstall vim-plug
" ----------------------------------------------------------------------------
let s:plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
let s:plug_self_dir = '~/.config/nvim/autoload/plug.vim'

if empty(glob(s:plug_self_dir))
    execute '!curl -fLo ' s:plug_self_dir ' --create-dirs ' s:plug_url
    echo '"vim-plug" successfuly installed!'
endif

" Plugins
" ----------------------------------------------------------------------------
let g:plug_window = 'enew'
let s:plug_plugins_dir = '~/.config/nvim/plugged'
call plug#begin(s:plug_plugins_dir)

call plug#end()

" Colorscheme
" ----------------------------------------------------------------------------
colorscheme tokyonight-night
set termguicolors

" Options
" ----------------------------------------------------------------------------
set inccommand=split         " Show visual indication when using substitute command
set signcolumn=auto          " Draw signcolumn when signs are available
set clipboard^=unnamedplus   " use system clipboard

set autoindent
set noruler
set nosmartindent             " smartindent is not so smart
set incsearch
set hlsearch
set formatoptions=tlcqjron1
set fillchars=diff:-,vert:│          " nice window separator char
set listchars=tab:\⋮\ ,extends:❯,precedes:❮,trail:·
let &showbreak = '↪ '         " mark soft linebreaks
set linebreak                 " this is soft breaking (without linebreak added)
set nobreakindent             " don't indent wrapped lines
set cursorline
set scrolloff=10

let $LANG = 'en' | set langmenu=none  " set vim language

let mapleader=","

set mousehide              " Hide mouse when typing
set more                   " Pause on long listings
set autowriteall           " Write contents of the file if it has been modified
set nolazyredraw           " don't set this cause vim disappears when new tmux pane is split
set diffopt=filler
set autowriteall           " automatically write when leaving a buffer
set fileignorecase         " ignore case when autocompleting filenames in command line
set cmdwinheight=10        " height of command-line window
set backspace=2
set completeopt-=preview
set gdefault               " always use 'g' flag when executing substitute command
set hidden
set history=1000
set noinfercase            " don't set infercase, it's not useful
set ignorecase
set smartcase              " ovveride ignorecase when pattern contains uppercase
set isfname-==             " remove = from filename pattern
set list                   " show tab characters
set nofoldenable           " open all folds
set noshowcmd
set noshowmode
set noswapfile nobackup
set nrformats=             " treat all numbers as decimal, not octal
set number
set path+=**
set re=1
set shiftwidth=4           " number of spaces per <<
set shortmess+=cI          " silence vim messages
set splitbelow splitright
set synmaxcol=500
set tabstop=4              " number of visual spaces per TAB
set softtabstop=4          " number of spaces in TAB when editing
set expandtab              " insert spaces when hitting TAB
set timeout                " for mappings
set timeoutlen=1000        " default value
set ttimeout               " for key codes
set ttimeoutlen=10         " unnoticeable small value
set undofile               " keep undo history for all file changes
set updatetime=4000         " used for CursorHold events (gitgutter uses it)
set wildignore+=*.pyc,*/__pycache__/*,*/venv/*,*/env/*
set wildmenu               " visual autocomplete for command menu
set wrap
set wrapscan               " wrap around during search
set nospell                " don't check spelling
set nojoinspaces           " don't insert addtional space after joining lines
set foldcolumn=1
set foldclose&             " don't close a fold when the cursor leaves it
set grepprg=ag\ --hidden\ --vimgrep\ --column\ --smart-case\ $*
set grepformat=%f:%l:%c:%m
set shellpipe=>            " fix for ack.vim plugin
set exrc secure            " enable sourcing of project's .nvimrc

" Python interfaces
" ----------------------------------------------------------------------------
let s:nvim_python2 = '~/.virtualenvs/neovim2/bin/python'
let s:nvim_python3 = '~/.virtualenvs/neovim3/bin/python'
if filereadable(glob(s:nvim_python2))
    let g:python_host_prog = glob(s:nvim_python2)
endif
" I suppose vim-hug-neovim-rpc plugin needs this var `pytho3_host_prog`
" So I should define is both for neovim and vim8
if filereadable(glob(s:nvim_python3))
    let g:python3_host_prog = glob(s:nvim_python3)
endif

" Autocommands
" ----------------------------------------------------------------------------
if !exists("autocommands_loaded")
    let autocommands_loaded = 1

    highlight! link QuickFixLine CursorLine

    " Hack to get colorcolumn always shown in python buffers
    autocmd BufEnter *.py setlocal colorcolumn=80

    " Open file on the last exit place
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \ exe "normal! g`\"" |
                \ endif

    function! TrimWhitespace()
        " Trim trailing whitespace on save
        let l:save_cursor = getpos('.')
        %s/\s\+$//e
        call setpos('.', l:save_cursor)
    endfun

    function! TrimEndLines()
        " Trim empty trailing lines on save
        let save_cursor = getpos(".")
        :silent! %s#\($\n\s*\)\+\%$##
        call setpos('.', save_cursor)
    endfunction

    autocmd BufWritePre * :call TrimWhitespace()|call TrimEndLines()

    " Turn off my 'center' mapping in cmdline window and quickfix/location list
    " windows
    autocmd CmdwinEnter * map <buffer> <cr> <cr>
    autocmd Filetype qf nnoremap <buffer> <2-LeftMouse> <cr>
    autocmd FileType qf nnoremap <buffer> <cr> <cr>
    autocmd FileType qf setlocal nocursorline

    " Set commentstring for jinja
    autocmd FileType jinja setlocal commentstring=<!--\ %s-->
    autocmd FileType cfg setlocal commentstring=#\ %s

    " Vim filetype
    autocmd FileType vim nnoremap <buffer> <leader>ss :source %<CR>
endif

" Search using ag and load results into quickfix list window
function! Grep(...)
    if exists('a:1')
        let query = a:1
        let args = a:000[1:]
    else
        let query = escape(expand("<cword>"), '\')
        " Word search by default when searching current word
        let args = ['-w']
        let @/ = expand("<cword>")
        set hlsearch
    endif
    " If -t was provided, skip searching tests modules
    if (index(args, '-t') >= 0)
        let args = filter(args, 'v:val !=# "-t"')
        call add(args, '--ignore "*test*"')
    endif

    execute 'silent grep "' . query . '" ' . join(args, ' ')
    redraw!
    if len(getqflist()) == 0
        echo 'No results!'
    else
        keepjumps cc
    endif
endfunction

command! -nargs=* -complete=file Grep call Grep(<f-args>)
" Search word under the cursor
nnoremap <leader>j :Grep<space>
" Start Grep command
nnoremap <silent> <leader>J :call Grep()<CR>

" Quickfix list
nnoremap ( :cprev<CR>
nnoremap ) :cnext<CR>
nnoremap } :lnext<CR>
nnoremap { :lprev<CR>
nnoremap <silent> ,l :copen<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Duplicate and comment out duplicate.
nmap gcp :t.<CR>k<Plug>CommentaryLinej

" Use space to clear highlighting
nnoremap <silent> <space> :nohlsearch<cr>
" Don't move cursor when exiting the insert mode
inoremap <Esc> <Esc>l
nnoremap <silent> <2-LeftMouse>
            \ :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hlsearch<cr>

" Center easily
nnoremap <cr> zz

" Copy current file's path to clipboard (shift for absolute path)
function! PathToClipboard(absolute)
    let l:pattern = a:absolute ? "%:p" : "%"
    let @+=expand(l:pattern)
    echo 'Copied to clipboard.'
endfunction
nnoremap <leader>y :call PathToClipboard(0)<cr>
nnoremap <leader>Y :call PathToClipboard(1)<cr>

" Paste current word in command mode
cnoremap <c-k> <C-R><C-W>

" Close quickfix and location lists
nnoremap <silent> <leader>c :cclose<bar>lclose<cr>

" Close windows with q
nnoremap <silent> q :lclose<bar>close<CR>

" ,qq to record, Q to replay
nnoremap <leader>q q
nnoremap Q @q

" Print the current filname, etc.
" C-g is shadowed by some fzf mappings
nnoremap <C-g><C-g> <c-g>

" Yanking mappings
" Copy from the cursor to the end of the line
nnoremap Y y$
" Copy in visual mode and move cursor to the end of selection
vnoremap gy y`>

" Refine these so they take into account typed text
cnoremap <C-P> <up>
cnoremap <C-N> <down>

" Use backslash to jump to previous char match
nnoremap \ ,

" Use leader key to save current buffer
nnoremap <silent> <leader><leader> :update<CR>

" Paste and keep pasting same thing
" (delete selected text to the black hole register)
vnoremap <Leader>p "_dP

noremap ,m :

" Mapping to move between tabs
nnoremap <silent> tn :tabnew<CR>
nnoremap <silent> tc :tabclose<CR>
nnoremap <silent> to :tabonly<CR>
nnoremap <silent> H :tabprev<CR>
nnoremap <silent> L :tabnext<CR>

" %% for current file dir path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Moving across windows
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <C-w>h
nnoremap <c-l> <C-w>l
nnoremap <C-w># :topleft vsp #<CR>

" Visual mode -- moving lines
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv

" Remove to the end of line from insert mode
imap <c-k> <c-o>D

" FZF settings
" ----------------------------------------------------------------------------
nnoremap <silent> <C-g><C-j> :GFiles?<CR>
" Search files from vim's cwd
nnoremap <silent> <C-p> :Files<CR>
" Search files in the current file's directory
nnoremap <silent> <C-g><C-p> :execute 'FZF ' . expand('%:h').'/'<cr>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap <silent> <c-g><c-l> :Commits<cr>
nnoremap <silent> <c-g><c-b> :BCommits<cr>

imap <c-x><c-f> <plug>(fzf-complete-path)

" Define fzf colors for light and dark colorschemes
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Just make this mapping easier
let g:fzf_layout = {'window': 'enew'}
let g:fzf_history_dir = '~/.fzf-history'
let g:fzf_commands_expect = 'ctrl-x'
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview('up:50%'), 1)
" Match only the first field (much faster)

" Undotree settings
" ----------------------------------------------------------------------------
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2
nnoremap gu :UndotreeToggle<CR>
nnoremap U <C-r>

" Maximizer plugin settings
" ----------------------------------------------------------------------------
let g:maximizer_set_default_mapping = 0
let g:maximizer_restore_on_winleave = 1
noremap gm :MaximizerToggle<CR>

" Gitgutter settings
" ----------------------------------------------------------------------------
" Nice uniform gitgutter signs
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▎'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▎'
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" RSI settings
let g:rsi_no_meta = 1

" Detectindent settings
let g:detectindent_preferred_indent = 4

" Vim-highlightedyank settings
hi link HighlightedyankRegion Visual
let g:highlightedyank_highlight_duration = 500

" NERDTree
nnoremap <silent> - :NERDTreeFind<CR>

" Highlighting
" ----------------------------------------------------------------------------
highlight! link VertSplit Comment
highlight Search cterm=bold
highlight Pmenu ctermfg=20
highlight illuminatedWord cterm=underline gui=underline

" Unimpaired -- move lines, add blank lines above/below
" ----------------------------------------------------------------------------
function! s:BlankUp(count) abort
  put!=repeat(nr2char(10), a:count)
  ']+1
  silent! call repeat#set("\<Plug>unimpairedBlankUp", a:count)
endfunction

function! s:BlankDown(count) abort
  put =repeat(nr2char(10), a:count)
  '[-1
  silent! call repeat#set("\<Plug>unimpairedBlankDown", a:count)
endfunction

nnoremap <silent> <Plug>unimpairedBlankUp   :<C-U>call <SID>BlankUp(v:count1)<CR>
nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>call <SID>BlankDown(v:count1)<CR>

nmap [<Space> <Plug>unimpairedBlankUp
nmap ]<Space> <Plug>unimpairedBlankDown

function! s:ExecMove(cmd) abort
  let old_fdm = &foldmethod
  if old_fdm !=# 'manual'
    let &foldmethod = 'manual'
  endif
  normal! m`
  silent! exe a:cmd
  norm! ``
  if old_fdm !=# 'manual'
    let &foldmethod = old_fdm
  endif
endfunction

function! s:Move(cmd, count, map) abort
  call s:ExecMove('move'.a:cmd.a:count)
  silent! call repeat#set("\<Plug>unimpairedMove".a:map, a:count)
endfunction

function! s:MoveSelectionUp(count) abort
  call s:ExecMove("'<,'>move'<--".a:count)
  silent! call repeat#set("\<Plug>unimpairedMoveSelectionUp", a:count)
endfunction

function! s:MoveSelectionDown(count) abort
  call s:ExecMove("'<,'>move'>+".a:count)
  silent! call repeat#set("\<Plug>unimpairedMoveSelectionDown", a:count)
endfunction

nnoremap <silent> <Plug>unimpairedMoveUp            :<C-U>call <SID>Move('--',v:count1,'Up')<CR>
nnoremap <silent> <Plug>unimpairedMoveDown          :<C-U>call <SID>Move('+',v:count1,'Down')<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionUp   :<C-U>call <SID>MoveSelectionUp(v:count1)<CR>
noremap  <silent> <Plug>unimpairedMoveSelectionDown :<C-U>call <SID>MoveSelectionDown(v:count1)<CR>

nmap [e <Plug>unimpairedMoveUp
nmap ]e <Plug>unimpairedMoveDown
xmap [e <Plug>unimpairedMoveSelectionUp
xmap ]e <Plug>unimpairedMoveSelectionDown

lua << END
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
END

lua require('leap').create_default_mappings()
