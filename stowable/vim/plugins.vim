call plug#begin('~/.vim/plugged')

" Visual
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'airblade/vim-gitgutter'

" Colors
Plug 'altercation/vim-colors-solarized'
Plug 'nanotech/jellybeans.vim'
Plug 'michalbachowski/vim-wombat256mod'
Plug 'morhetz/gruvbox'
Plug 'trevordmiller/nova-vim'

" Language Support
Plug 'fatih/vim-go'
Plug 'elmcast/elm-vim'
Plug 'tpope/vim-fugitive'
Plug 'joonty/vdebug'

" Misc
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'mattn/emmet-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-surround'
Plug 'sjl/splice.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'

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
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_id_checkers = 1

    let g:syntastic_error_symbol = "☠"
    let g:syntastic_warning_symbol = "⚠"
    let g:syntastic_style_error_symbol = "☢"
    let g:syntastic_style_warning_symbol = '💩'

    let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
    let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
" }


" CtrlP: {
    " Ignore certain folders/files
    let g:ctrlp_custom_ignore = '\v[\/]\.(git|idea|svn|hg|DS_Store)$'

    " faster matcher
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

    " The Silver Searcher - AG to build the index in no time!
    let g:ctrlp_user_command = 'ag %s --nocolor
        \ --nogroup --hidden
        \ --ignore "**/*.pyc"
        \ -g ""'
" }


" Splice: {
    let g:splice_initial_layout_grid = 1
" }


" Elm: {
    let g:elm_format_autosave = 1
" }


" Vdebug: {
    let g:vdebug_keymap = {
    \   "run" : "<Leader><F5>",
    \   "run_to_cursor" : "<Down>",
    \   "step_over" : "<Up>",
    \   "step_into" : "<Left>",
    \   "step_out" : "<Right>",
    \   "close" : "q",
    \   "detach" : "<F7>",
    \   "set_breakpoint" : "<Leader>s",
    \   "eval_visual" : "<Leader>e"
    \}

    " Mapping '/remote/path' : '/local/path'
    let g:vdebug_options= {
    \   "port" : 9001,
    \   "server" : '',
    \   "timeout" : 30,
    \   "on_close" : 'detach',
    \   "break_on_open" : 1,
    \   "max_children" : 128,
    \   "ide_key" : 'docker',
    \   "path_maps" : {
    \   },
    \   "debug_window_level" : 0,
    \   "debug_file_level" : 0,
    \   "debug_file" : "~/vdebug.log",
    \   "watch_window_style" : 'expanded',
    \   "marker_default" : '⬦',
    \   "marker_closed_tree" : '▸',
    \   "marker_open_tree" : '▾'
    \}
" }

let g:gruvbox_contrast_dark='medium'
