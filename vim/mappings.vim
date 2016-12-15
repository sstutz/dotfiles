" map leader to spacebar!
let mapleader="\<space>"

nnoremap <silent> <Leader>W :w !sudo tee % > /dev/null<CR>:edit!<CR>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" clear search results
map <F12> :set hls! hls?<CR>
