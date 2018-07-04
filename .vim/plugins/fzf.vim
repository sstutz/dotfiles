if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --hidden -l -i ""'
    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:60%')
                \           : fzf#vim#with_preview('right:50%:hidden', '?'),
                \   <bang>0)

    " Likewise, Files command with preview window
    command! -bang -nargs=? -complete=dir Files
                \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
elseif executable('ag')
    let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
endif


" Files + devicons
function! Fzf_dev()
    let l:fzf_file_options =
                \ '--preview "[[ \$(file --mime {2..-1}) =~ binary ]] && echo {2..-1} is a binary file || (highlight -O ansi -l {2..-1} || coderay {2..-1} || rougify {2..-1} || cat {2..-1}) 2> /dev/null | head -'.&lines.'"'

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
        let l:pos = stridx(a:item, ' ')
        let l:file_path = a:item[pos+1:]
        execute 'silent e' file_path
    endfunction

    call fzf#run({
                \ 'source': <sid>files(),
                \ 'sink':   function('s:edit_file'),
                \ 'options': '-m ' . l:fzf_file_options,
                \ 'down':    '40%'
                \ })
endfunction
" }
noremap <c-p> :call Fzf_dev()<cr>
noremap <c-b> :Buffers<cr>
noremap <c-l> :Lines<cr>
