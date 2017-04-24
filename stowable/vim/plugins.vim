call plug#begin('~/.vim/plugged')

" Visual
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'nanotech/jellybeans.vim'
Plug 'michalbachowski/vim-wombat256mod'
Plug 'morhetz/gruvbox'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'trevordmiller/nova-vim'

" Language Support
Plug 'fatih/vim-go'
Plug 'elmcast/elm-vim'
Plug 'tpope/vim-fugitive'



" Misc
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'mattn/emmet-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-surround'
Plug 'sjl/splice.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'mhinz/vim-startify'

" Add plugins to &runtimepath
call plug#end()


" NerdTree: {
    let NERDTreeShowBookmarks=1
    let NERDTreeBookmarksFile=$HOME."/.vim/bookmarks"
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
    map <C-n> :NERDTreeToggle<CR>
" }


" VimAirline: {
    let g:airline_powerline_fonts = 1
    let g:airline_theme = "tomorrow"
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_nr_show = 1
"}


" Syntastic: {
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0

    let g:syntastic_php_checkers=['php', 'phpcs']
    let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
" }


" CtrlP: {
    " Ignore certain folders/files
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|idea|svn|hg|DS_Store)$'   " Ignore .git and .idea directories

    " faster matcher
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

    " The Silver Searcher - AG to build the index in no time!
    let g:ctrlp_user_command = 'ag %s --nocolor
        \ --nogroup --hidden
        \ --ignore "**/*.pyc"
        \ -g ""'
" }


" Rainbow Parentheses: {

    " Activation based on file type
    augroup rainbow_lisp
        autocmd!
        autocmd FileType php,go,scheme RainbowParentheses
    augroup END

    let g:rainbow#max_level = 16
    let g:rainbow#pairs = [['(', ')'], ['[', ']']]

    " List of colors that you do not want. ANSI code or #RRGGBB
    " let g:rainbow#blacklist = [233, 234]
" }


" Splice: {
    let g:splice_initial_layout_grid = 1
" }


" Elm: {
    let g:elm_format_autosave = 1
" }


let g:gruvbox_contrast_dark='medium'
