" map leader to spacebar!
let mapleader="\<space>"

nnoremap <silent> <Leader>W :w !sudo tee % > /dev/null<CR>:edit!<CR>

" convenient split hotkeys
nnoremap <silent> <leader>s :split<CR>
nnoremap <silent> <leader>v :vsplit<CR>
nnoremap <silent> <leader>q :close<CR>
nnoremap <silent> <leader>fe :Lexplore<CR>

map <leader>n :call renameFile#RenameFile()<cr>

nnoremap <Space>s/ :FlyGrep<cr>

inoremap <expr> <CR>        pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab>       pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <Down>      pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <S-Tab>     pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <Up>        pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <Esc>       pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <PageDown>  pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>    pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" smarter command-line history navigation
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" quickly edit a macro
" <leader>m | "f<leader>m
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>

