call plug#begin(g:configpath . '/plugged')

" Visual Helpers
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'kshenoy/vim-signature'
Plug 'junegunn/vim-peekaboo'
Plug 'markonm/traces.vim'

" Colors
Plug 'morhetz/gruvbox'

" Misc
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'w0rp/ale'
Plug 'machakann/vim-sandwich'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wsdjeg/FlyGrep.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko/vim-test'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-plug'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-apathy'

if (has('python') || has('python3'))
    if (executable('editorconfig'))
        Plug 'editorconfig/editorconfig-vim'
        let g:EditorConfig_exclude_patterns = ['scp://.*']
    endif
    if (has('python3'))
        Plug 'ncm2/ncm2'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
        Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
        Plug 'ncm2/ncm2-ultisnips'
        Plug 'SirVer/ultisnips'
        autocmd BufEnter * call ncm2#enable_for_buffer()
        "
        " IMPORTANT: :help Ncm2PopupOpen for more information
        set completeopt=noinsert,menuone,noselect
        inoremap <silent> <expr> <CR>
                    \ ((pumvisible() && empty(v:completed_item))
                    \ ? "\<c-y>\<cr>"
                    \ : (!empty(v:completed_item)
                        \ ? ncm2_ultisnips#expand_or("", 'n')
                        \ : "\<CR>" ))

        " c-j c-k for moving in snippet
        inoremap <expr> <c-u> ncm2_ultisnips#expand_or("\<Plug>(ultisnips_expand)", 'm')
        snoremap <c-u> <Plug>(ultisnips_expand)
        let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
        let g:UltiSnipsJumpForwardTrigger = "<tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
        let g:UltiSnipsRemoveSelectModeMappings = 0
        let g:UltiSnipsEditSplit="vertical"
    endif
else
    Plug 'ajh17/VimCompletesMe'
    Plug 'cohama/lexima.vim'
endif

" Language Support
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'elmcast/elm-vim', {'for': 'elm'}
Plug 'phpactor/phpactor', { 'for': 'php', 'branch': 'develop', 'do': ':call phpactor#Update()' }
Plug 'vim-vdebug/vdebug', { 'for': 'php', 'on': 'Breakpoint' }
Plug 'lambdalisue/gina.vim'
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh'  }
" should be loaded last
Plug 'sheerun/vim-polyglot', { 'do': './build' }

" Add plugins to &runtimepath
call plug#end()

let g:polyglot_disabled = ['go', 'elm']

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_list_window_size = 5

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

let spacevim_debug_level = 1
let g:spacevim_search_tools = ['rg', 'ag', 'pt', 'ack', 'grep']

" extends % functionality
runtime! macros/matchit.vim
runtime! ftplugin/man.vim

" Plugin specific settings
runtime! macros/sandwich/keymap/surround.vim
runtime! plugins/lightline.vim
runtime! plugins/fzf.vim
runtime! plugins/vdebug.vim

" Plugin related mappings
noremap <C-t> :TagbarToggle<CR>

" Vim-Test Mappings
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>gt :TestVisit<CR>

noremap <leader>G :Find <c-r>=expand("<cword>")<cr><cr>
noremap <c-p> :call Fzf_dev()<cr>
noremap <c-l> :Lines<cr>

