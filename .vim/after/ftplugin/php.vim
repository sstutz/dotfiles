setlocal omnifunc=phpactor#Complete
setlocal commentstring=//\ %s
setlocal keywordprg=:terminal++close\ pman
setlocal grepprg=rg\ --vimgrep\ --type\ php

let g:phpactorOmniError = v:true
let g:phpactorOmniAutoClassImport = v:true

let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'

let g:PHPPhanBin = getcwd() . '/vendor/bin/phan'
if executable(g:PHPPhanBin)
    " start phan daemon
    let job = job_start(g:PHPPhanBin . ' --daemonize-tcp-port 4846 --quick')
    echom "Phan daemon started on 4846"

    let &makeprg = getcwd() . '/vendor/bin/phan_client'

    if has("nvim")
        setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    else
        setlocal errorformat=%m\ in\ %f\ on\ line\ %l,%-GErrors\ parsing\ %f,%-G
    endif

    au! BufWritePost    *.php,*.html  call PHPsynCHK()

    function! PHPsynCHK()
        let winnum = winnr()

        " or 'silent make --disable-usage-on-error -l %' in Phan 0.12.3+
        silent make --disable-usage-on-error -l %

        " open the error window if it contains an error. Don't limit the number of lines.
        cw

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
nmap <Leader>gd :call phpactor#GotoDefinition()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

" update tags in background whenever you write a php file
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags"  ] && .git/hooks/ctags' &

