" Configuration Neovim

" Set configuration folder
let g:configpath=$HOME.'/.config/nvim'

"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:python3_host_prog = '/usr/bin/python3'

runtime! myrc.vim
