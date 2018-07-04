" removes all trailing whitespaces on save
function! stripTrailingWhitespaces#StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
