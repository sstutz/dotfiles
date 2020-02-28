" VimPlug: {{{
call plug#begin(g:configpath . '/plugged')
" Visual Helpers
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vim-peekaboo'
Plug 'markonm/traces.vim'
Plug 'Shougo/echodoc.vim'

" Colors
Plug 'morhetz/gruvbox'
Plug 'fcpg/vim-fahrenheit'

" Misc
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'dense-analysis/ale'
Plug 'machakann/vim-sandwich'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko/vim-test'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-plug'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-apathy'
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'kkoomen/vim-doge'

if executable('git')
    Plug 'lambdalisue/gina.vim'
endif

" Language Support
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'phpactor/phpactor', { 'for': 'php', 'do': ':call phpactor#Update()' }
Plug 'vim-vdebug/vdebug', { 'for': 'php', 'on': 'Breakpoint' }
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'  }
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'javascriptreact'] }
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascriptreact'], 'do': 'npm install' }
Plug 'andys8/vim-elm-syntax'

if (has('python3'))
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-ultisnips'
    Plug 'ncm2/ncm2-tern', {'for': ['javascript', 'javascriptreact']}
    Plug 'phpactor/ncm2-phpactor', {'for': 'php'}

    Plug 'SirVer/ultisnips'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
else
    Plug 'ajh17/VimCompletesMe'
    Plug 'cohama/lexima.vim'
endif

Plug 'sheerun/vim-polyglot', { 'do': './build' }
call plug#end()
" }}}

" Tagbar: {{{
noremap <C-t> :TagbarToggle<CR>
" }}}

" AirlineVim: {{{
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" }}}

" Ale: {{{
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_list_window_size = 5
" }}}

" Ncm2: {{{
augroup ncm2
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    autocmd User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
    autocmd User Ncm2PopupClose set completeopt=menuone,popup
    set shortmess+=c
    let g:ncm2#complete_length=2
augroup END
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<c-y>", 'n') : "\<CR>")
" }}}

" UltiSnips: {{{
let g:UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsRemoveSelectModeMappings = 0
let g:UltiSnipsEditSplit='vertical'
smap <c-u> <Plug>(ultisnips_expand)
" }}}

" VimTest: {{{
if filereadable('docker/deploy.sh')
    function! DockerTransform(cmd) abort
        return './docker/deploy.sh exec php bash -c "XDEBUG_CONFIG=idekey=docker APP_ENV=testing ' . a:cmd . '"'
    endfunction
    let g:test#custom_transformations = {'docker': function('DockerTransform')}
    let g:test#transformation = 'docker'
endif
let test#vim#term_position = 'vertical'
let test#strategy = 'vimterminal'
let test#php#phpunit#options = '--no-coverage'

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>gt :TestVisit<CR>
" }}}

" Polyglot: {{{
let g:polyglot_disabled = ['go', 'elm']
" }}}

" Editorconfig: {{{
let g:EditorConfig_core_mode = 'vim_core'
let g:EditorConfig_exclude_patterns = ['scp://.*']
" }}}

" Phpactor: {{{
let g:phpactorBranch = 'develop'
let g:phpactorOmniError = v:true
let g:phpactorOmniAutoClassImport = v:true
if (executable('fzf'))
    let g:phpactorInputListStrategy='phpactor#input#list#fzf'
endif
" }}}

" Vdebug: {{{
let g:vdebug_keymap = {
            \   'run' : '<Leader><F5>',
            \   'run_to_cursor' : '<Down>',
            \   'step_over' : '<Up>',
            \   'step_into' : '<Left>',
            \   'step_out' : '<Right>',
            \   'close' : '<leader>q',
            \   'detach' : '<F7>',
            \   'set_breakpoint' : '<Leader>b',
            \   'eval_visual' : '<Leader>e'
            \}

" Mapping '/remote/path' : '/local/path'
let g:vdebug_options= {
            \   'port' : 9001,
            \   'server' : 'localhost',
            \   'timeout' : 30,
            \   'on_close' : 'detach',
            \   'break_on_open' : 1,
            \   'max_children' : 128,
            \   'ide_key' : 'docker',
            \   'path_maps' : {
            \       '/var/www/html': '~/Projects/work/portal'
            \   },
            \   'debug_window_level' : 0,
            \   'debug_file_level' : 0,
            \   'debug_file' : '/tmp/vdebug.log',
            \   'watch_window_style' : 'expanded',
            \}
" }}}

" FZF: {{{
if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --hidden -l -i ""'
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)

    " Likewise, Files command with preview window
    command! -bang -nargs=? -complete=dir Files
                \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
elseif executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
endif

" Files + devicons
function! Fzf_dev()
    let l:fzf_file_options = '--preview "bat --theme="OneHalfDark" --style=numbers,changes --color always {2..-1} | head -'.&lines.'"'

    function! s:files()
        let files = split(system($FZF_DEFAULT_COMMAND), '\n')
        return s:prepend_icon(files)
    endfunction

    function! s:prepend_icon(candidates)
        let l:result = []
        for l:candidate in a:candidates
            let l:filename = fnamemodify(candidate, ':p:t')
            let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
            call add(l:result, printf('%s %s', l:icon, l:candidate))
        endfor

        return result
    endfunction

    function! s:edit_file(item)
        let l:pos = stridx(a:item, ' ')
        let l:file_path = a:item[pos+1:]
        execute 'silent e' file_path
    endfunction

    call fzf#run({
                \ 'source': <sid>files(),
                \ 'sink':   function('s:edit_file'),
                \ 'options': '-m ' . l:fzf_file_options,
                \ 'down':    '40%'
                \ })
endfunction

" --column: Show column number
" --line-number: Show line numober
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore -g "!tags" --hidden --follow --glob "!build/*" --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%'),
            \   <bang>0)

noremap <leader>G :Find <c-r>=expand("<cword>")<cr><cr>
noremap <leader>/ :Lines<cr>
noremap <c-p> :call Fzf_dev()<cr>
" }}}

" Emmet: {{{
let g:user_emmet_leader_key = ','
let g:user_emmet_settings = {
    \  'javascriptreact' : {
    \      'extends' : 'jsx',
    \  },
    \}
" }}}

" Echodoc.vim: {{{
set cmdheight=2
let g:echodoc_enable_at_startup = 1
" }}}

" LanguageClient: {{{
augroup lsp_config
    autocmd!
    function! Lsp_mappings()
        if has_key(g:LanguageClient_serverCommands, &filetype)
            " Bind K to show documentation for the current symbol
            nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
            " Bind gd to go to the definition of a symbol
            nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
            " Bind <F2> to global rename
            nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
            " Bind <F5> to the context menu for more options
            nnoremap <buffer> <silent> <F5> :call LanguageClient_contextMenu()<CR>
        endif
    endfunction

    " Execute the bindings for supported languages
    autocmd FileType * call Lsp_mappings()
augroup END
" }}}

" extends % functionality
runtime! macros/matchit.vim

" man pages viewer
runtime! ftplugin/man.vim

" use vim-surround like keybindings
runtime! macros/sandwich/keymap/surround.vim

" vim: set sw=4 ts=8 sts=4 et tw=78 foldenable foldmethod=marker spell:
