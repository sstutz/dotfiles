" Setup vim-Plug Support {
    if filereadable(expand("~/.vim/plugins.vim"))
      source ~/.vim/plugins.vim
    endif
" }


" General: {
    syntax on                       " syntax highlighting
    filetype plugin indent on       " Automatically detect file types
    set background=dark             " Assume a dark background
    set t_Co=256                    " set vim color to 256
    set backspace=indent,eol,start  " backspace for dummys
    set mouse=a                     " automatically enable mouse usage
    set virtualedit=onemore         " allow for cursor beyond last character
    set hidden                      " hides buffers instead of closing them
    set history=1000                " Number of lines in command history
    set autochdir                   " Automatically cd to directory of file being opened
    set nrformats="alpha,bin,hex"   " Let ^A^X in/decrease binary, hex or single letters
    set wildmenu                    " Enhance command-line completion
    set wildmode=list:longest,full
" }


" Backups: {
    set nobackup                " Disable creation of backup files
    set directory=~/.vim/swap// " Place swapfiles away from projects
                                "  ...but include full paths in the filenames (//)
    set undodir=~/.vim/undo//   " Same for persistent undo files
    set undofile                "  ...which will work better if we turn it on
" }


" Encoding: {
    scriptencoding utf-8
    set encoding=utf-8 nobomb   " The encoding displayed.
    set fileencoding=utf-8      " The encoding written to file.
" }


" Formatting: {
    set list
    exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
    set nowrap                  " wrap long lines
    set autoindent              " indent at the same level of the previous line
    set expandtab               " tabs are spaces, not tabs
    set shiftwidth=4            " use indents of 4 spaces
    set tabstop=4               " an indentation every four columns
    set softtabstop=4           " let backspace delete indent
    set nojoinspaces            " Only insert one space when joining lines
    set formatoptions+=or       " Automatically add comment marker on next line
    set formatoptions+=j        " Automatically remove comment marker on line merge
" }


" Splits: {
    set splitbelow              " Open new splits below
    set splitright              " Open new vertical splits to the right
" }


" UI: {
    colorscheme wombat256mod        " load a colorscheme
    set title                       " Display filename in the terminal title
    set showmatch                   " show matching brackets/parenthesis
    set showmode                    " display the current mode
    set cursorline                  " highlight current line
    hi cursorline guibg=#333333     " highlight bg color of current line
    hi CursorColumn guibg=#333333   " highlight cursor
    set number                      " Line numbers on
    set laststatus=2                " Always show statusline
    set scrolloff=10                " Start scroll 10 lines away from top/bottom


    " highlight the 81st and 101st columns
    highlight ColorColumn ctermbg=red
    call matchadd('ColorColumn', '\%81v', 100)
    call matchadd('ColorColumn', '\%101v', 100)

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and selected characters/lines in visual mode
    endif
" }


" Search: {
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present

    " Set :grep command to use The Silver Searcher
    set grepprg="ag --nogroup --nocolor"

" }


" Functions: {
    " removes all trailing whitespaces on save
    execute 'source' g:configpath . '/functions/stripTrailingWhitespaces.vim'

    " quick rename of current file
    execute 'source' g:configpath . '/functions/renameFile.vim'

    " briefly hide everything except the match...
    execute 'source' g:configpath . '/functions/hideOnSearch.vim'
" }


" Jump to the last position when reopening a file
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

