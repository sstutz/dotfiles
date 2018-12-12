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

" Language Support
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'elmcast/elm-vim', {'for': 'elm'}
Plug 'phpactor/phpactor', { 'for': 'php', 'do': 'composer install' }
Plug 'vim-vdebug/vdebug', { 'for': 'php', 'on': 'Breakpoint' }
Plug 'lambdalisue/gina.vim'
Plug 'sheerun/vim-polyglot'

" Misc
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'w0rp/ale'
Plug 'machakann/vim-sandwich'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-plug'
Plug 'ajh17/VimCompletesMe'

function! DockerTransform(cmd) abort
    return './docker/deploy.sh exec php bash -c "APP_ENV=testing ' . a:cmd . '"'
endfunction

if filereadable('docker/deploy.sh')
    let g:test#custom_transformations = {'docker': function('DockerTransform')}
    let g:test#transformation = 'docker'
endif

let test#strategy = 'vimterminal'
let test#php#phpunit#options = '--no-coverage'

" Add plugins to &runtimepath
call plug#end()

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
noremap <c-b> :Buffers<cr>
noremap <c-l> :Lines<cr>
