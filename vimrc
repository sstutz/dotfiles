" Environment {
    " Setup Bundle Support {
        if filereadable(expand("~/.vimrc.bundles"))
          source ~/.vimrc.bundles
        endif
    " }

    " Basics {
        set nocompatible        " must be first line
        set background=dark     " Assume a dark background
        set t_Co=256            " set vim color to 256
    " }
" }

" General {
    scriptencoding utf-8
    syntax on                   " syntax highlighting
    filetype plugin indent on   " Automatically detect file types
    set mouse=a                 " automatically enable mouse usage
    set virtualedit=onemore     " allow for cursor beyond last character
    set noswapfile              " disable the creation of swp files
    set nobackup                " disable the creation of backup files
    set hidden                  " hides buffers instead of closing them
" }

" Formatting {
    set nowrap                  " wrap long lines
    set autoindent              " indent at the same level of the previous line
    set expandtab               " tabs are spaces, not tabs
    set shiftwidth=4            " use indents of 4 spaces
    set tabstop=4               " an indentation every four columns
    set softtabstop=4           " let backspace delete indent
    set paste                   " avoid weird whitespace pasting
" }

" VimUI {
    colorscheme wombat256mod        " load a colorscheme
    set showmode                    " display the current mode
    set cursorline                  " highlight current line
    hi cursorline guibg=#333333     " highlight bg color of current line
    hi CursorColumn guibg=#333333   " highlight cursor
    set backspace=indent,eol,start  " backspace for dummys
    set nu                          " Line numbers on
    set incsearch                   " find as you type search
    set hlsearch                    " highlight search terms
    set ignorecase                  " case insensitive search
    set smartcase                   " case sensitive when uc present
    set showmatch                   " show matching brackets/parenthesis
    set showcmd

    if has('cmdline_info')
        set ruler                   " show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
        set showcmd                 " show partial commands in status line and
                                    " selected characters/lines in visual mode
    endif
" }


" key Mappings {
    " for command mode
    nmap <S-Tab> <<
    " for insert mode
    imap <S-Tab> <C-o><<
" }


" Plugins {
    " NerdTree {
        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=1
    " }

    " VimAirline {
        let g:airline_powerline_fonts = 1
        let g:airline_theme = "tomorrow"
        let g:airline#extensions#bufferline#enabled = 1
    "}
" }

" Functions {
    " removes all trailing whitespaces on save
    function! <SID>StripTrailingWhitespaces()
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfun
    autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

    " autocomlpete on tab
    function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
            return "\<tab>"
        else
            return "\<c-p>"
        endif
    endfunction
    inoremap <tab> <c-r>=InsertTabWrapper()<cr>
    inoremap <s-tab> <c-n>

    " quick rename of current file
    function! RenameFile()
        let old_name = expand('%')
        let new_name = input('New file name: ', expand('%'), 'file')
        if new_name != '' && new_name != old_name
            exec ':saveas ' . new_name
            exec ':silent !rm ' . old_name
            redraw!
        endif
    endfunction
    map <leader>n :call RenameFile()<cr>

    :au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }

" Always show statusline
set laststatus=2
