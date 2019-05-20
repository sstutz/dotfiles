setlocal noexpandtab
setlocal tabstop=8

compiler go
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_list_type = "quickfix"
let g:go_def_mode='gopls'

nnoremap <leader>b :GoDebugBreakpoint<cr>
nnoremap <leader><F5> :GoDebugStart<cr>
nnoremap <leader>q :GoDebugStop<cr>
