setlocal omnifunc=phpactor#Complete
setlocal commentstring=//\ %s
setlocal keywordprg=:terminal\ pman\ <cr>:q
let g:neomake_php_phpcs_args_standard = 'PSR2'
setlocal grepprg=rg\ --vimgrep\ --type\ php

let g:PHPPhanBin = getcwd() . '/vendor/bin/phan'
if executable(g:PHPPhanBin)
    " start phan daemon
    let job = job_start(g:PHPPhanBin . ' --daemonize-tcp-port 4846 --quick')

    " Need to use absolute path to phan_client, or put it in your path (E.g. $HOME/bin/phan_client)
    " This is based off of a snippet mentioned on http://vim.wikia.com/wiki/Runtime_syntax_check_for_php
    let &makeprg = getcwd() . '/vendor/bin/phan_client'

    " Note: in Neovim, instead use %m\ in\ %f\ on\ line\ %l
    setlocal errorformat=%m\ in\ %f\ on\ line\ %l,%-GErrors\ parsing\ %f,%-G

    au! BufWritePost  *.php,*.html    call PHPsynCHK()

    function! PHPsynCHK()
        let winnum =winnr() " get current window number
        " or 'silent make --disable-usage-on-error -l %' in Phan 0.12.3+
        silent make --disable-usage-on-error -l %
        cw " open the error window if it contains an error. Don't limit the number of lines.
        " return to the window with cursor set on the line of the first error (if any)
        execute winnum . "wincmd w"
        :redraw!
    endfunction
endif

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
