setlocal omnifunc=phpactor#Complete
setlocal commentstring=//\ %s
setlocal keywordprg=:terminal\ pman\ <cr>:q
let g:neomake_php_phpcs_args_standard = 'PSR2'
setlocal grepprg=rg\ --vimgrep\ --type\ php

" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
