" map leader to spacebar!
let mapleader="\<space>"

nnoremap <silent> <Leader>W :w !sudo tee % > /dev/null<CR>:edit!<CR>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" clear search results
map <F12> :set hls! hls?<CR>

nnoremap <leader>t :CtrlPTag<cr>

if has('nvim')
    :tnoremap <Esc> <C-\><C-n>
	:tnoremap <A-h> <C-\><C-n><C-w>h
    :tnoremap <A-j> <C-\><C-n><C-w>j
    :tnoremap <A-k> <C-\><C-n><C-w>k
    :tnoremap <A-l> <C-\><C-n><C-w>l
    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l
endif
