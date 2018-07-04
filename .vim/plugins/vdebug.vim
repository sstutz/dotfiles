" Vdebug: {
    let g:vdebug_keymap = {
    \   "run" : "<Leader><F5>",
    \   "run_to_cursor" : "<Down>",
    \   "step_over" : "<Up>",
    \   "step_into" : "<Left>",
    \   "step_out" : "<Right>",
    \   "close" : "q",
    \   "detach" : "<F7>",
    \   "set_breakpoint" : "<Leader>b",
    \   "eval_visual" : "<Leader>e"
    \}

    " Mapping '/remote/path' : '/local/path'
    let g:vdebug_options= {
    \   "port" : 9001,
    \   "server" : 'localhost',
    \   "timeout" : 30,
    \   "on_close" : 'detach',
    \   "break_on_open" : 1,
    \   "max_children" : 128,
    \   "ide_key" : 'docker',
    \   "path_maps" : {
    \   },
    \   "debug_window_level" : 0,
    \   "debug_file_level" : 0,
    \   "debug_file" : "~/vdebug.log",
    \   "watch_window_style" : 'expanded',
    \   "marker_default" : '⬦',
    \   "marker_closed_tree" : '▸',
    \   "marker_open_tree" : '▾'
    \}
" }

