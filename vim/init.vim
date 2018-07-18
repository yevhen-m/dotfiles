let s:nvim = has('nvim')
if !s:nvim
    unlet! skip_defaults_vim
    silent! source $VIMRUNTIME/defaults.vim

    set nocompatible
endif

" Autoinstall vim-plug
" ----------------------------------------------------------------------------
let s:plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
let s:plug_self_dir = s:nvim ?
            \ '~/.config/nvim/autoload/plug.vim' :
            \ '~/.vim/autoload/plug.vim'

if empty(glob(s:plug_self_dir))
    execute '!curl -fLo ' s:plug_self_dir ' --create-dirs ' s:plug_url
    echo '"vim-plug" successfuly installed!'
endif

" Plugins
" ----------------------------------------------------------------------------
let g:plug_window = 'enew'
let s:plug_plugins_dir = s:nvim ?
            \ '~/.config/nvim/plugged' :
            \ '~/.vim/plugged'
call plug#begin(s:plug_plugins_dir)

" Syntax
Plug 'Glench/Vim-Jinja2-Syntax',  {'for': 'jinja'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'chase/vim-ansible-yaml', {'for': 'ansible'}
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': 'javascript.jsx'}
Plug 'othree/javascript-libraries-syntax.vim', {'for': 'javascript'}
Plug 'moskytw/nginx-contrib-vim', {'for': 'nginx'}
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plug 'aklt/plantuml-syntax', {'for': 'plantuml'}

" Arcanist
Plug 'solarnz/arcanist.vim', {'for': 'arcanistdiff'}
Plug 'yevhen-m/arcanist-omnicomplete.vim', {'for': 'arcanistdiff'}
Plug 'yevhen-m/arc-diff-jira-issue', {'for': 'arcanistdiff'}

" Git
Plug 'airblade/vim-gitgutter'
Plug 'gilligan/textobj-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Python
" Plug 'yevhen-m/python-syntax', {'for': 'python'}
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'numirias/semshi', {'for': 'python'}

" Javascript
Plug 'prettier/vim-prettier', { 'do': 'npm install', 'for': [
            \ 'javascript',
            \ 'typescript',
            \ 'css',
            \ 'less',
            \ 'scss',
            \ 'json',
            \ 'graphql',
            \ 'markdown',
            \ ]}

" Enhance vim searching.
Plug 'thinca/vim-visualstar'

" Filesystem browsers
Plug 'scrooloose/nerdtree'

" Tags
Plug 'ludovicchabant/vim-gutentags'

" Tmux
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'tmux-plugins/vim-tmux-focus-events'

" Helpful
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'kopischke/vim-fetch'
Plug 'machakann/vim-highlightedyank'
Plug 'christoomey/vim-sort-motion'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'Julian/vim-textobj-brace'
Plug 'kana/vim-textobj-entire'
Plug 'foosoft/vim-argwrap', {'for': ['python', 'javascript']}
Plug 'michaeljsmith/vim-indent-object', {'for': [
            \ 'python',
            \ 'javascript',
            \ 'vim',
            \ ]}
Plug 'ciaranm/detectindent', {'on': 'DetectIndent'}
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-rsi'
Plug 'junegunn/vader.vim', {'on': 'Vader'}
Plug 'AndrewRadev/bufferize.vim', {'on': ['Bufferize'] }
Plug 'PeterRincker/vim-argumentative'
Plug 'Shougo/junkfile.vim', {'on': 'JunkfileOpen'}
Plug 'Valloric/MatchTagAlways', {'for': [
            \ 'xml',
            \ 'html',
            \ 'htmldjango',
            \ 'jinja',
            \ ]}
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'pbrisbin/vim-mkdir'
Plug 'szw/vim-g', {'on': ['Gf', 'G']}
Plug 'szw/vim-maximizer', {'on': 'MaximizerToggle'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-capslock'
Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', {
            \ 'dir': '~/.fzf',
            \ 'do': './install --all --no-update-rc'
            \ }
Plug 'junegunn/fzf.vim'

" Colorscheme
Plug 'joshdick/onedark.vim'

call plug#end()

function! s:SourceIfExists(path)
    let path = expand(a:path)
    if filereadable(path)
        execute 'source ' . path
    endif
endfunction

call s:SourceIfExists('~/.config/nvim/abbreviations.vim')

" Options
" ----------------------------------------------------------------------------
if s:nvim
    set inccommand=split         " Show visual indication when using substitute command
    set signcolumn=auto          " Draw signcolumn when signs are available
    set keymap=russian-jcukenwin " alternative keymap (+keymap feature for vim)
    set iminsert=0 imsearch=0    " order of this options matters!
    set clipboard^=unnamedplus   " use system clipboard
else
    filetype plugin indent on
    syntax on
    runtime macros/matchit.vim
    set laststatus=2             " Always show statusline
    set clipboard=unnamed        " OSX does not have plus clipboard
    set encoding=utf-8
    set undodir=                 " Dont' create undofiles
    set ttyfast                  " Assume fast terminal connection
    set nobackup
    set nowritebackup
endif

set autoindent
set noruler
set nosmartindent             " smartindent is not so smart
set incsearch
set hlsearch
set formatoptions=tlcqjron1
set guicursor=                " don't chnage cursor shape in different modes
set fillchars=diff:-,vert:│          " nice window separator char
set listchars=tab:\⋮\ ,extends:❯,precedes:❮,trail:·
let &showbreak = '↪ '         " mark soft linebreaks
set linebreak                 " this is soft breaking (without linebreak added)
set nobreakindent             " don't indent wrapped lines
set nocursorline              " less redrawing
set scrolloff=0               " offset of 0 lines to top-bottom borders;
                              " don't want to set this bc viewport jumps when
                              " I click with mouse at the top/bottom of the
                              " screen.

let $LANG = 'en' | set langmenu=none  " set vim language

let mapleader=","

set pastetoggle=<F10>
set pumheight=15           " Maximum height for completion window
set mousehide              " Hide mouse when typing
set more                   " Pause on long listings
set autowriteall           " Write contents of the file if it has been modified
set nolazyredraw           " don't set this cause vim disappears when new tmux pane is split
set diffopt=filler
set autowriteall           " automatically write when leaving a buffer
set winheight=15           " minimum height for active window
set winminwidth=3          " minimum number of lines for any window
set autoread               " for vim-tmux-focus-events plugin
set fileignorecase         " ignore case when autocompleting filenames in command line
set cmdwinheight=10        " height of command-line window
set backspace=2
set complete-=i            " Don't scan included files because it's too slow
set completeopt-=preview
set gdefault               " always use 'g' flag when executing substitute command
set hidden
set history=1000
set noinfercase            " don't set infercase, it's not useful
set ignorecase
set smartcase              " ovveride ignorecase when pattern contains uppercase
set isfname-==             " remove = from filename pattern
set list                   " show tab characters
set showmatch              " show matching parens (see 'matchtime' setting)
set matchtime=4            " .4 seconds to show matching paren
set mouse=a
set noacd
set nofoldenable           " open all folds
set noshowcmd
set showmode
set nostartofline
set noswapfile nobackup
set nrformats=             " treat all numbers as decimal, not octal
set number
set path+=**
set re=1
set shell=/bin/zsh
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
set updatetime=400         " used for CursorHold events (gitgutter uses it)
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
if s:nvim && filereadable(glob(s:nvim_python2))
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

    " Override the `Identifier` background color in GUI mode
    autocmd ColorScheme * call onedark#extend_highlight("StatusLine", { "bg": { "gui": "#353a41" } })
    autocmd ColorScheme * call onedark#extend_highlight("StatusLineNC", { "bg": { "gui": "#2c323c" } })
    autocmd ColorScheme * call onedark#extend_highlight("TabLineSel", { "bg": { "gui": "#353a41" } })
    autocmd ColorScheme * call onedark#extend_highlight("TabLine", { "bg": { "gui": "#2c323c" } })
    autocmd ColorScheme * call onedark#extend_highlight("CursorLine", {"bg": {"gui": "#383c44"} })

    " Green
    autocmd ColorScheme * call onedark#extend_highlight("DiffAdd", { "bg": { "gui": "#313641" }, "fg": {"gui": "#98c379"} })
    " Blue
    autocmd ColorScheme * call onedark#extend_highlight("DiffChange", { "bg": { "gui": "#313641" }, "fg": {"gui": "#61afef" }})
    " Red
    autocmd ColorScheme * call onedark#extend_highlight("DiffDelete", { "bg": { "gui": "#313641" }, "fg": {"gui": "#e06c75"} })
    " Yellow
    autocmd ColorScheme * call onedark#extend_highlight("DiffText", { "bg": { "gui": "#313641" }, "fg": {"gui": "#e5c07b"} })

    let g:onedark_color_overrides = {
                \ "white": { "gui": "#bbc1cb", "cterm": "145", "cterm16": "7" },
                \}

    " Colorscheme (should be after autocommands that redefine colors)
    set background=dark
    set termguicolors
    colorscheme onedark

     " `bg` will not be styled since there is no `bg` setting
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })

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

    autocmd! User FzfStatusLine setlocal statusline=\ >\ fzf

endif

" Mappings
" ----------------------------------------------------------------------------
function! JumpToTag(...)
    let word = exists('a:1') ? a:1 : expand("<cword>")
    try
        execute "silent ltag " . word
    catch
        echo 'Tag not found!'
        return
    endtry
    if len(getloclist(win_getid())) > 1
        " Open loclist window at the top
        topleft lwindow 7 | keepjumps ll
    else
        lclose
    endif
    execute 'normal zz'
endfunction

command! -nargs=1 -complete=tag_listfiles JumpToTag call JumpToTag("<args>")

" Open tag in vertical split
nnoremap <C-w><C-]> :vsp<bar>call JumpToTag()<CR>zz
" Open tag in horizontal split
nnoremap <C-w><c-w><C-]> :sp<bar>call JumpToTag()<CR>zz
" Open tag in current window
nnoremap <C-]> :call JumpToTag()<CR>zz
cnoreabbrev <expr> tag
            \ getcmdtype() == ":" && getcmdline() == 'tag' ? 'JumpToTag' : 'tag'

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

" Split line (sister to [J]oin lines)
nnoremap S i<cr><esc>

" Duplicate and comment out duplicate.
nmap gcp :t.<CR>k<Plug>CommentaryLinej

" Use space to clear highlighting
nnoremap <silent> <space> :nohlsearch<cr>
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

" Operate on display lines
" Only normal and visual mode, not operator mode
noremap k gk
ounmap k
noremap j gj
ounmap j
noremap ^ g0
noremap $ g$
noremap 0 g^

" FZF settings
" ----------------------------------------------------------------------------
nnoremap <silent> <C-g><C-j> :GFiles?<CR>
nnoremap <silent> <leader>e :Commands<CR>
" Search files from vim's cwd
nnoremap <silent> <C-p> :Files<CR>
" Search files in the current file's directory
nnoremap <silent> <C-g><C-p> :execute 'FZF ' . expand('%:h').'/'<cr>
nnoremap <silent> <C-_> :BLines<CR>
nnoremap <silent> <leader>d :BTags<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <C-n> :Buffers<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap <silent> <c-g><c-l> :Commits<cr>
nnoremap <silent> <c-g><c-b> :BCommits<cr>

imap <c-x><c-l> <plug>(fzf-complete-buffer-line)
imap <c-x><c-f> <plug>(fzf-complete-path)

" Just make this mapping easier
let g:fzf_layout = s:nvim ? {'window': 'enew'} : {'down': '~40%'}
let g:fzf_history_dir = '~/.fzf-history'
let g:fzf_tags_command = 'ctags'
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
nnoremap U :UndotreeToggle<CR>

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

" Fugitive settings
" ----------------------------------------------------------------------------
nnoremap <leader>gd :Gvdiff<cr>gg]c
nnoremap <leader>gc :Gwrite<bar>Gcommit -v<CR>
nnoremap <leader>gb :Gblame<cr>
nmap <leader>gs :Gstatus<cr>gg<C-N>

" Gutentags settings
" ----------------------------------------------------------------------------
let g:gutentags_enabled = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_new = 0
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_empty_buffer = 0
let g:gutentags_project_root = ['.git']
let g:gutentags_add_default_project_roots = 0

" Vim-g settings
" ----------------------------------------------------------------------------
let g:vim_g_command = "G"
let g:vim_g_f_command = "Gf"

" Nerdtree settings
nnoremap <silent> - :NERDTreeFind<cr>zz
nnoremap <silent> _ :NERDTreeClose<cr>
let NERDTreeIgnore = ['^\.git$', '^\.DS_Store$', '^__pycache__$', '\.pyc$']
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden = 1
let NERDTreeCreatePrefix = 'silent keepalt keepjumps'

" Vim-easy-align settings
" ----------------------------------------------------------------------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Python highlighting
let python_self_cls_highlight = 1

" Obsession settings
nnoremap coo :Obsession<CR>

" RSI settings
let g:rsi_no_meta = 1

" ArgWrap settings
nnoremap gw :ArgWrap<CR>
let g:argwrap_tail_comma = 1

" Add one more tags file from virtualenv
if !empty($VIRTUAL_ENV)
    set tags=tags,$VIRTUAL_ENV/tags
endif

" Vim-jsx settings
let g:jsx_ext_required = 0

" Detectindent settings
let g:detectindent_preferred_indent = 4

" Vim-highlightedyank settings
hi link HighlightedyankRegion Visual
let g:highlightedyank_highlight_duration = 500
if !s:nvim
    map y <Plug>(highlightedyank)
endif

" Prettier settings
let g:prettier#autoformat = 0

" Statusline
" ----------------------------------------------------------------------------
function! GitBranchSection()
    let branch = fugitive#head(5)
    return empty(branch) ? '---' : branch
endfunction

function! s:create_statusline(mode)
    " Relative path to file
    " Filename
    " Where to truncate
    " Modified, readonly
    " Switch to right-hand side
    " Filetype
    " Current line in file
    " Total lines count
    let common = [
                \ '\ ',
                \ "%{expand('%:h')}/",
                \ '%t',
                \ ]
    let rest = [
                \ '\ %<',
                \ '\ %m%r',
                \ '%=',
                \ '%{ObsessionStatus()}',
                \ '\ %y\ ◌',
                \ '\ %{GitBranchSection()}\ ◌',
                \ '\ %p%%\ ◌\ %L',
                \ '\ ',
                \ ]
    let parts = a:mode ==# 'A' ? common + rest : common
    execute 'setlocal statusline=' . join(parts, '')
endfunction

augroup MyStatusline
    autocmd!
    autocmd WinEnter,BufWinEnter * call s:create_statusline('A')
    autocmd WinLeave * call s:create_statusline('I')
augroup END

" Flake8 settings
" ----------------------------------------------------------------------------
let g:flake8_show_in_gutter = 0
let g:flake8_show_quickfix=0

" Indentline settings
" ----------------------------------------------------------------------------
let g:indentLine_fileType = ['python', 'vim']

" Custom func to toggle iminsert option
" ----------------------------------------------------------------------------
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

" Highlighting
" ----------------------------------------------------------------------------
highlight! link VertSplit Comment
highlight Search cterm=bold
highlight WildMenu cterm=bold ctermfg=0
highlight Pmenu ctermfg=20

nnoremap cob :%bd!<CR>

" Semshi
" ----------------------------------------------------------------------------
let g:semshi#error_sign = v:false

" Unimpaired
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
