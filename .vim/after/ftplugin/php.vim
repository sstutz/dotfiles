setlocal omnifunc=phpactor#Complete
setlocal commentstring=//\ %s
setlocal keywordprg=:terminal++close\ pman
setlocal grepprg=rg\ --vimgrep\ --type\ php

let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let b:ale_linters = ['phpcs']
let g:PHPProjectBin = getcwd() . '/vendor/bin'
let g:PHPPhanBin = g:PHPProjectBin . '/phan'


if executable(g:PHPPhanBin)
    " start phan daemon
    let job = job_start(g:PHPPhanBin . ' --daemonize-tcp-port 4846 --quick')
    let &makeprg = getcwd() . '/vendor/bin/phan_client'

    if has('nvim')
        setlocal errorformat=%m\ in\ %f\ on\ line\ %l
    else
        setlocal errorformat=%m\ in\ %f\ on\ line\ %l,%-GErrors\ parsing\ %f,%-G
    endif

    function! PHPsynCHK()
        let winnum = winnr()
        silent make --disable-usage-on-error -l %

        " open the error window if it contains an error. Don't limit the number of lines.
        cw

        " return to the window with cursor set on the line of the first error (if any)
        execute winnum . 'wincmd w'
        redraw!
    endfunction
endif

augroup php_setup
    autocmd!
    " update tags in background whenever you write a php file
    autocmd BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags"  ] && .git/hooks/ctags' &
    if executable(g:PHPPhanBin)
        autocmd BufWritePost *.php call PHPsynCHK()
    endif
augroup END

" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>

" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>

" Goto definition of class or class member under the cursor
nnoremap gd :call phpactor#GotoDefinition()<CR>

" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>

" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
