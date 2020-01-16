" Mappings: {{{
runtime! mappings.vim
" }}}

" Plugins: {{{
runtime! plugins.vim
" }}}

" Autocommand Groups: {{{
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

augroup MyColors
    autocmd!
    autocmd ColorScheme
                \ * highlight cursorline    ctermbg=grey guibg=#333333
                \ | highlight CursorColumn  ctermbg=grey guibg=#333334
                \ | highlight ColorColumn   ctermbg=red  guibg=#fb4934
augroup END

augroup TooLong
    autocmd!
    autocmd winEnter,BufEnter
                \ * call clearmatches()
                \ | call matchadd('ColorColumn', '\%81v', 100)
                \ | call matchadd('ColorColumn', '\%101v', 100)
augroup END

augroup on_buf_read
    autocmd!
    " Jump to the last position when reopening a file
    autocmd BufReadPost \
                \ * if line("'\"") > 1 && line("'\"") <= line("$")
                \ | exe "normal! g'\""
                \ | endif
augroup END

augroup on_buf_write
    autocmd!
    autocmd BufWritePre * :call stripTrailingWhitespaces#StripTrailingWhitespaces()
augroup END
" }}}

" General: {{{
syntax on
filetype plugin indent on
set backspace=2
set mouse=a
set virtualedit=onemore
set hidden
set history=1000
set nrformats="alpha,bin,hex"     " Let ^A^X in/decrease binary, hex or single letters
set wildmenu
set wildmode=list:longest,full
set autoread
set ttimeout
set ttimeoutlen=50
set ttyfast
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
" }}}

" Backups: {{{
set nobackup
let &directory=g:configpath . '/files/swap//' " Place swapfiles away from projects

set undofile
let &undodir=g:configpath . '/files/undo//'   " Same for persistent undo files
" }}}

" Encoding: {{{
set encoding=utf-8 nobomb
scriptencoding utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencodings=ucs-bom,utf-8,ISO-8859-1,latin1
" }}}

" Formatting: {{{
set list
set listchars=tab:»-,extends:›,precedes:‹,nbsp:·,trail:·
set nowrap
set autoindent
set expandtab
set shiftwidth=4
set tabstop=8
set softtabstop=4
set nojoinspaces
set formatoptions+=orj
" }}}

" Splits: {{{
set splitbelow
set splitright
" }}}

" UI: {{{
set background=dark
if has('termguicolors')
    set termguicolors
    " set Vim-specific sequences for RGB colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
set title
set showmatch
set cursorline
set number
set relativenumber
set laststatus=2
set scrolloff=10
set sidescrolloff=5
set sidescroll=1
set showbreak=↪
set display+=lastline
set signcolumn=yes
set showtabline=2

if has('cmdline_info')
    set ruler
    set showcmd
endif
" }}}

" Search: {{{
set incsearch
set hlsearch
set ignorecase
set wildignorecase
set smartcase
if executable('rg')
    set grepprg=rg\ --vimgrep
elseif executable('ag')
    set grepprg=ag\ --vimgrep
endif
set tags+=./.git/tags;
" }}}

" Folding: {{{
set foldmethod=indent
set nofoldenable
set foldnestmax=5
" }}}

" Netrw: {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" }}}

" Spelling: {{{
" leave spell disabled by default
" enable via ftplugin or manually if needed
set spelllang=en,de
" }}}

" Diff: {{{
set diffopt=internal
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set diffopt+=filler
set diffopt+=vertical
set diffopt+=context:5
set diffopt+=foldcolumn:1
" }}}

" Misc: {{{
" Make shift-tab work on GNU screen/tmux
" http://superuser.com/questions/195794/gnu-screen-shift-tab-issue
set t_kB=[Z
command! -nargs=+ -complete=file_in_path -bar Grep  let a = split(<q-args>, ' ') | cgetexpr system(&grepprg . ' ' . shellescape(a[0]) . ' ' . get(a, 1, ''))
set digraph
" }}}

" vim: set sw=4 ts=8 sts=4 et tw=78 foldenable foldmethod=marker spell:
