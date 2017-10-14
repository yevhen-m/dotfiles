" Autoinstall vim-plug
" ----------------------------------------------------------------------------
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins
" ----------------------------------------------------------------------------
call plug#begin('~/.config/nvim/plugged')

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

" Arcanist
Plug 'yevhen-m/arcanist-omnicomplete.vim', {'for': 'arcanistdiff'}
Plug 'solarnz/arcanist.vim', {'for': 'arcanistdiff'}

" Autocomplete
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', {'do': function('DoRemote')}
Plug 'Shougo/neco-syntax'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim', {'on': 'GV'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Python
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
Plug 'yevhen-m/python-syntax', {'for': 'python'}

" Javascript
Plug 'carlitux/deoplete-ternjs', {
            \ 'for': 'javascript',
            \ 'do': 'npm install -g tern'
            \ }
Plug 'ternjs/tern_for_vim', {
            \ 'for': 'javascript',
            \ 'do': 'npm install'
            \ }

" HTML
Plug 'mattn/emmet-vim', {'for': ['html', 'xml']}

" Enhance vim searching. This plugin does not work with other plugins that
" tamper with search mappings.
Plug 'thinca/vim-visualstar'

" Filesystem browsers
Plug 'scrooloose/nerdtree'

" Quickfix list enhancement
Plug 'romainl/vim-qf'
Plug 'blueyed/vim-qf_resize'

" Linting
Plug 'w0rp/ale'

" Formatting
Plug 'Chiel92/vim-autoformat', {'on': ['CurrentFormatter', 'Autoformat']}

" Tags
Plug 'ludovicchabant/vim-gutentags'

" Tmux
Plug 'tmux-plugins/vim-tmux', {'for': 'tmux'}
Plug 'tmux-plugins/vim-tmux-focus-events'

" Helpful
Plug 'christoomey/vim-sort-motion'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'foosoft/vim-argwrap', {'for': ['python', 'javascript']}
Plug 'michaeljsmith/vim-indent-object', {'for': ['python', 'javascript']}
Plug 'ciaranm/detectindent', {'on': 'DetectIndent'}
Plug 'tommcdo/vim-exchange'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-unimpaired'
Plug 'itchyny/vim-cursorword'
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
Plug 'yevhen-m/base16-vim'

call plug#end()

function! s:SourceIfExists(path)
    let path = expand(a:path)
    if filereadable(path)
        execute 'source ' . path
    endif
endfunction

call s:SourceIfExists('~/.config/nvim/abbreviations.vim')
call s:SourceIfExists('~/.config/nvim/functions.vim')

" Main settings
" ----------------------------------------------------------------------------
set guicursor=                " don't chnage cursor shape in different modes
set fillchars=diff:-,vert:│          " nice window separator char
set listchars=tab:\⋮\ ,extends:⟫,precedes:⟪,trail:·
let &showbreak = '↪ '         " mark soft linebreaks
set linebreak                 " this is soft breaking (without linebreak added)
set nobreakindent             " don't indent wrapped lines
set nocursorline
set scrolloff=8               " offset of 8 lines to top-bottom borders
set signcolumn=yes            " always show sign column

let $LANG = 'en' | set langmenu=none  " set vim language

" Colorscheme
set background=dark
let base16colorspace = 256    " base16-shell script should be sourced
colorscheme base16-eighties

let mapleader=","

" Statusline
set statusline=
set statusline=%<       " where to truncate
set statusline+=\ %{expand('%:h')}/
set statusline+=%t " filename
set statusline+=\ %m%r  " modified, readonly, filetype
set statusline+=%=      " switch to right-hand side
set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=%{ObsessionStatus()}
set statusline+=%y\ |   " filetype

set nolazyredraw           " don't set this cause vim disappears when new tmux pane is split
set diffopt=filler
set autowriteall           " automatically write when leaving a buffer
set winheight=15           " minimum height for active window
set winminwidth=3          " minimum number of lines for any window
set autoread               " for vim-tmux-focus-events plugin
set fileignorecase         " ignore case when autocompleting filenames in command line
set cmdwinheight=10        " height of command-line window
set backspace=2
set clipboard^=unnamedplus " use system clipboard
set completeopt-=preview
set gdefault               " always use 'g' flag when executing substitute command
set hidden
set history=1000
set noinfercase            " don't set infercase, it's not useful
set ignorecase
set smartcase              " ovveride ignorecase when pattern contains uppercase
set inccommand=split       " Show visual indication when using substitute command
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
set updatetime=2000        " used for CursorHold events (gitgutter uses it)
set wildignore+=*.pyc,*/__pycache__/*,*/venv/*,*/env/*
set wildmenu               " visual autocomplete for command menu
set wrap
set wrapscan               " wrap around during search
set nospell                " don't check spelling
set nojoinspaces           " don't insert addtional space after joining lines
set foldcolumn&            " don't show a column to indicate folds
set foldclose&             " don't close a fold when the cursor leaves it

set keymap=russian-jcukenwin  " alternative keymap:
set iminsert=0 imsearch=0     " order of this options matters!
set grepprg=ag\ --vimgrep\ \--column\ --smart-case\ $*
set grepformat=%f:%l:%c:%m
set shellpipe=>            " fix for ack.vim plugin
set exrc secure            " enable sourcing of project's .nvimrc

" Vim-plug settings
" ----------------------------------------------------------------------------
let g:plug_window = 'enew'

" Python interfaces
" ----------------------------------------------------------------------------
if filereadable(glob('~/.virtualenvs/neovim2/bin/python'))
    let g:python_host_prog = glob('~/.virtualenvs/neovim2/bin/python')
endif
if filereadable(glob('~/.virtualenvs/neovim3/bin/python'))
    let g:python3_host_prog = glob('~/.virtualenvs/neovim3/bin/python')
endif

let g:python_host_skip_check = 1
let g:python3_host_skip_check = 1

" Autocommands
" ----------------------------------------------------------------------------
if !exists("autocommands_loaded")
    let autocommands_loaded = 1

    " Go to the last line in logs
    autocmd BufReadPost *.log normal G

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
    autocmd FileType qf map <buffer> <cr> <cr>
    autocmd FileType qf setlocal nocursorline

    " Set commentstring for jinja
    autocmd FileType jinja setlocal commentstring=<!--\ %s-->
    autocmd FileType cfg setlocal commentstring=#\ %s

endif

" Mappings
" ----------------------------------------------------------------------------
function! JumpToTag(...)
    let word = exists('a:1') ? a:1 : expand("<cword>")
    execute "ltag " . word
    if len(getloclist(win_getid())) > 1
        lwindow | keepjumps ll
    else
        lclose
    endif
endfunction

command! -nargs=1 -complete=tag_listfiles JumpToTag call JumpToTag("<args>")

nnoremap <C-]> :call JumpToTag()<CR>
cnoreabbrev <expr> tag
            \ getcmdtype() == ":" && getcmdline() == 'tag' ? 'JumpToTag' : 'tag'

" Source current file
nnoremap <leader>ss :source %<CR>

" Search
nnoremap <C-s> :grep ""<left>

" Quickfix list
nnoremap <Up> :cprev<CR>
nnoremap ( :cprev<CR>
nnoremap <Down> :cnext<CR>
nnoremap ) :cnext<CR>

" Retain cursor position when visually yanking.
vnoremap <expr> y 'my"'.v:register.'y`y'
vnoremap <expr> Y 'my"'.v:register.'Y`y'

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines)
nnoremap S mwi<cr><esc>`w

" Duplicate and comment out duplicate.
nmap gcp :t.<CR>k<Plug>CommentaryLinej

" Scrolling
noremap <C-u> 8<C-u>
noremap <C-d> 8<C-d>
noremap <silent> <C-f> 16<C-d>
noremap <silent> <C-b> 16<C-u>
noremap <ScrollWheelUp> <C-Y>
noremap <ScrollWheelDown> <C-E>

" Use space to clear highlighting
nnoremap <silent> <space> :nohlsearch<cr>

" Switch to alternate buffer in current window
nnoremap <leader>j <c-^>
" Open split and edit alternate buffer there
nnoremap <C-w>j <C-w>^

" Center easily
nnoremap <cr> zz

" Insert mode mapping
" Movements
inoremap <C-h> <left>
inoremap <C-l> <right>
inoremap <c-k> <up>
inoremap <c-j> <down>

" Edit init.vim and abbreviations.vim files
nnoremap <leader>ev :edit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

let abbr_file = fnamemodify($MYVIMRC, ':p:h')."/abbreviations.vim"
nnoremap <leader>ea :execute("edit ".abbr_file)<cr>
nnoremap <leader>sa :execute("source ".abbr_file)<cr>

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

" Save and exit
nnoremap <silent> <C-q> :q!<cr>

" ,qq to record, Q to replay
nnoremap <leader>q q
nnoremap Q @q

" Quit with one keystroke
nnoremap <silent> q :q<cr>

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
nnoremap <silent> <leader><leader> :update<CR>:nohlsearch<cr>

" Paste and keep pasting same thing
" (delete selected text to the black hole register)
vnoremap <Leader>p "_dP

nnoremap <silent> tk :tabnext<CR>
nnoremap <silent> tj :tabprev<CR>
nnoremap <silent> th :tabfirst<CR>
nnoremap <silent> tl :tablast<CR>
nnoremap <silent> to :tabonly<cr>

" %% for current file dir path
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Moving across windows
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <C-w>h
nnoremap <c-l> <C-w>l

" Visual mode -- moving lines
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv

" Operate on display lines
" Only normal and visual mode, not operator mode
nnoremap k gk
nnoremap j gj
nnoremap ^ g^
nnoremap $ g$
nnoremap 0 g0

xnoremap k gk
xnoremap j gj
xnoremap ^ g^
xnoremap $ g$
xnoremap 0 g0

" Move to start/end of current line
nnoremap gh g^
xnoremap gl g$h
nnoremap gl g$
xnoremap gh g^

" FZF settings
" ----------------------------------------------------------------------------
nnoremap <silent> <C-g><C-j> :GFiles?<CR>
nnoremap <silent> <C-g><C-p> :GFiles<cr>
nnoremap <silent> <C-_> :BLines<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>hh :History<CR>
nnoremap <silent> <c-g><c-l> :Commits<cr>
nnoremap <silent> <c-g><c-b> :BCommits<cr>

imap <c-x><c-l> <plug>(fzf-complete-buffer-line)
imap <c-x><c-f> <plug>(fzf-complete-path)

" Just make this mapping easier
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_history_dir = '~/.fzf-history'
let g:fzf_tags_command = 'ctags'
let g:fzf_commands_expect = 'ctrl-x'
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-s': 'split',
            \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview('up:50%'), 1)

function! s:fzf_statusline()
  setlocal statusline=\ >\ fzf
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Undotree settings
" ----------------------------------------------------------------------------
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>

" Deoplete settings
" ----------------------------------------------------------------------------
nnoremap cod :call ToggleDeoplete()<cr>
let g:deoplete_enabled = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 300
let g:deoplete#auto_refresh_delay = 500
let g:deoplete#enable_ignore_case = 1
let g:deoplete#disable_auto_complete = 0

" Close popup, delete char and the open popup again
imap <silent> <expr> <BS> deoplete#smart_close_popup()."\<BS>"
imap <silent> <expr> <CR> deoplete#close_popup()."\<CR>"

" Experiment with ignoring tagfiles
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['tag']

" Autoformat settings
" ----------------------------------------------------------------------------
noremap <leader>ff :Autoformat<CR>

let g:formatters_html = ['htmlbeautify']
" Configure this for your python project
" Examples:
" let g:formatdef_yapf = "'yapf --lines ' . a:firstline . '-' . a:lastline"
" let g:formatters_python = ['yapf']

" Maximizer plugin settings
" ----------------------------------------------------------------------------
let g:maximizer_set_default_mapping = 0
let g:maximizer_restore_on_winleave = 1
noremap <leader>m :MaximizerToggle<CR>

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
nnoremap <silent> cog :GitGutterLineHighlightsToggle<cr>

" Vim-qf settings
" ----------------------------------------------------------------------------
let g:qf_mapping_ack_style = 0
let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1
" Open loclist the same way qflist is opened
let g:qf_loclist_window_bottom = 1
" Resizing is handled by vim-qf_resize plugin
let g:qf_auto_resize = 0
" Show current entry in statusline
let g:qf_statusline = {}
let g:qf_statusline.before = '%f%<\ '
let g:qf_statusline.after = '\ %=%l\/%-6L\ \ \ \ \ '

" Vim-qf_resize settings
let g:qf_resize_min_height = 5
let g:qf_resize_max_height = 5

" Fugitive settings
" ----------------------------------------------------------------------------
nnoremap <leader>gd :Gvdiff<cr>gg]c
nnoremap <leader>gc :Gcommit -v -q<cr>
nnoremap <leader>gv :GV<cr>
nmap <leader>gs :Gstatus<cr>gg<C-N>

" Gutentags settings
" ----------------------------------------------------------------------------
let g:gutentags_enabled = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_empty_buffer = 1

" Vim-g settings
" ----------------------------------------------------------------------------
let g:vim_g_command = "G"
let g:vim_g_f_command = "Gf"

" Nerdtree settings
nnoremap <silent> - :NERDTreeFind<cr>
nnoremap <silent> _ :NERDTreeClose<cr>
let NERDTreeIgnore = ['^\.git$', '^\.DS_Store$', '^__pycache__$', '\.pyc$']
let NERDTreeMinimalUI = 1
let NERDTreeAutoDeleteBuffer = 1

" Vim-easy-align settings
" ----------------------------------------------------------------------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" ALE settings
" ----------------------------------------------------------------------------
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_text_changed = 0
let g:ale_open_list = 1
let g:ale_set_highlights = 0
let g:ale_set_quickfix = 1

nnoremap <leader>ee :ALELint<cr>
nnoremap coa :ALEToggle<cr>

let g:ale_linters = {'python': ['flake8']}
let g:ale_python_flake8_executable =  $VIRTUAL_ENV . '/bin/flake8'

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

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
