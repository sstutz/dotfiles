" map leader to spacebar!
let mapleader="\<space>"

nnoremap <silent> <Leader>W :w !sudo tee % > /dev/null<CR>:edit!<CR>
