setlocal noexpandtab
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4

compiler go
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
