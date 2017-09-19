if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --hidden -l -i ""'
elseif executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
endif

if executable('rg')
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)

    " Likewise, Files command with preview window
    command! -bang -nargs=? -complete=dir Files
                \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endif

" Files + devicons
function! Fzf_dev()
    if executable('rougify')
        let l:fzf_files_options =
                    \ '--preview "echo {} | tr -s \" \" \"\n\" | tail -1 | xargs rougify | head -'.&lines.'"'
    else
        let l:fzf_files_options = '-x +s'
    endif

    function! s:files()
        let files = split(system($FZF_DEFAULT_COMMAND), '\n')
        return s:prepend_icon(files)
    endfunction

    function! s:prepend_icon(candidates)
        let result = []
        for candidate in a:candidates
            let filename = fnamemodify(candidate, ':p:t')
            let icon = WebDevIconsGetFileTypeSymbol(filename, isdirectory(filename))
            call add(result, printf("%s %s", icon, candidate))
        endfor

        return result
    endfunction

    function! s:edit_file(item)
        let parts = split(a:item, ' ')
        let file_path = get(parts, 1, '')
        execute 'silent e' file_path
    endfunction

    call fzf#run({
                \ 'source': <sid>files(),
                \ 'sink':   function('s:edit_file'),
                \ 'options': '-m ' . l:fzf_files_options,
                \ 'down':    '40%'
                \ })
endfunction
" }
noremap <c-p> :call Fzf_dev()<cr>
noremap <c-b> :Buffers<cr>
noremap <c-l> :Lines<cr>
