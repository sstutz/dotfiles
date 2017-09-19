setlocal omnifunc=phpcd#CompletePHP
setlocal commentstring=//\ %s
setlocal keywordprg=:terminal\ pman\ <cr>:q
let g:neomake_php_phpcs_args_standard = 'PSR2'
setlocal grepprg=rg\ --vimgrep\ --type\ php
