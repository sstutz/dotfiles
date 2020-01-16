setlocal completefunc=LanguageClient#complete
"
" https://en.parceljs.org/hmr.html#safe-write
setlocal backupcopy=yes
"
" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['elm-format']

let b:ale_elm_format_executable = 'elm-format'


let g:tagbar_type_elm = {
      \ 'kinds' : [
      \ 'f:function:0:0',
      \ 'm:modules:0:0',
      \ 'i:imports:1:0',
      \ 't:types:1:0',
      \ 'a:type aliases:0:0',
      \ 'c:type constructors:0:0',
      \ 'p:ports:0:0',
      \ 's:functions:0:0',
      \ ]
      \}

let g:LanguageClient_serverCommands = {
  \ 'elm': ['elm-language-server'],
  \ }

let g:LanguageClient_rootMarkers = {
  \ 'elm': ['elm.json'],
  \ }
