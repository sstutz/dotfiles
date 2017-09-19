call plug#begin(g:configpath . '/plugged')

" Visual
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'
Plug 'edkolev/tmuxline.vim'
Plug 'mhinz/vim-signify'
Plug 'ryanoasis/vim-devicons'
Plug 'kshenoy/vim-signature'

" Colors
Plug 'morhetz/gruvbox'

" Language Support
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'elmcast/elm-vim', {'for': 'elm'}
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'joonty/vdebug', { 'for': 'php', 'on': 'Breakpoint' }
Plug 'lambdalisue/gina.vim'
Plug 'sheerun/vim-polyglot'

" Misc
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'neomake/neomake'
Plug 'machakann/vim-sandwich'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-peekaboo'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-plug'

function! DockerTransform(cmd) abort
    let docker_project = filereadable('docker/deploy.sh')
    return './docker/deploy.sh exec php bash -c "APP_ENV=testing ' . a:cmd . '"'
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'
let test#strategy = 'vimterminal'

" Add plugins to &runtimepath
call plug#end()

" Plugin specific settings
runtime! macros/sandwich/keymap/surround.vim
runtime! plugins/lightline.vim
runtime! plugins/neomake.vim
runtime! plugins/fzf.vim
runtime! plugins/vdebug.vim
