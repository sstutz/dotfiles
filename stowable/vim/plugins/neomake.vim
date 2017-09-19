" Neomake: {
    let g:neomake_open_list = 2
    call neomake#configure#automake('w')

    let g:neomake_warning_sign = {
        \ 'text': '⚠️',
        \ 'texthl': 'NeomakeWarningSign',
        \ }
    let g:neomake_error_sign = {
        \ 'text': '💀',
        \ 'texthl': 'NeomakeErrorSign',
        \ }
    let g:neomake_message_sign = {
        \   'text': '▶️',
        \   'texthl': 'NeomakeMessageSign',
        \ }
    let g:neomake_info_sign = {
        \ 'text': 'ℹ',
        \ 'texthl': 'NeomakeInfoSign'
        \ }
" }

