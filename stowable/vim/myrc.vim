" Plugins: {
    runtime! plugins.vim
    runtime! mappings.vim
" }

" Autocommand Groups: {
    autocmd QuickFixCmdPost *grep* cwindow

    augroup MyColors
        autocmd!
        autocmd ColorScheme * highlight cursorline guibg=#333333
                          \ | highlight CursorColumn guibg=#333333
                          \ | highlight ColorColumn ctermbg=red
    augroup END

    augroup TooLong
        autocmd!
        autocmd winEnter,BufEnter * call clearmatches()
                                \ | call matchadd('ColorColumn', '\%81v', 100)
                                \ | call matchadd('ColorColumn', '\%101v', 100)
    augroup END

    augroup on_buf_read
        autocmd!
        " Jump to the last position when reopening a file
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
                        \ | exe "normal! g'\""
                        \ | endif
    augroup END

    augroup on_buf_write
        autocmd!
        autocmd BufWritePre * :call stripTrailingWhitespaces#StripTrailingWhitespaces()
    augroup END
" }

" General: {
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
" }

" Backups: {
    set nobackup
    let &directory=g:configpath . '/swap//' " Place swapfiles away from projects
    let &undodir=g:configpath . '/undo//'   " Same for persistent undo files
    set undofile
" }

" Encoding: {
    set encoding=utf-8 nobomb
    scriptencoding utf-8
    set fileencoding=utf-8
" }

" Formatting: {
    set list
    set listchars=tab:»-,extends:›,precedes:‹,nbsp:·,trail:·
    set nowrap
    set autoindent
    set expandtab
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set nojoinspaces
    set formatoptions+=or
    set formatoptions+=j
" }

" Splits: {
    set splitbelow
    set splitright
" }

" UI: {
    set background=dark
    if has("termguicolors")
        set termguicolors
        " set Vim-specific sequences for RGB colors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    colorscheme gruvbox
    let g:gruvbox_contrast_dark='medium'
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
    set showtabline=2

    if has('cmdline_info')
        set ruler
        set showcmd
    endif
" }

" Search: {
    set incsearch
    set hlsearch
    set ignorecase
    set smartcase
    if executable('rg')
        set grepprg=rg\ --vimgrep
    endif
    set tags+=./.git/tags;
" }

" Folding: {
    set foldmethod=indent
    set nofoldenable
    set foldnestmax=5
" }

" Netrw {
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_browse_split = 4
    let g:netrw_altv = 1
    let g:netrw_winsize = 25
" }
