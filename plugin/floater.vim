" floater.nvim - Floating Terminal
" Maintainer: Kraust <http://github.com/kraust>
" Version 0.2

if exists('loaded_floater')
    finish
endif
let g:loaded_floater = 1

function! floater#Exec(command, close_on_open) abort
    let floater_buf = nvim_create_buf(v:false, v:true)

    call setbufvar(floater_buf, '&signcolumn', 'no')

    let width = &columns - 4
    let height = (&lines / 2) - 2
    "let offset = 1
    let offset = (&lines / 2) - 1

    let opts = { 
                \ 'relative': "editor",
                \ 'row' : offset,
                \ 'col' : 2,
                \ 'width': width, 
                \ 'height': height
                \}

    call nvim_open_win(floater_buf, v:true, opts)
    call termopen(a:command)
    if a:close_on_open == v:true
        silent! exec 'q'
    endif
endfunction

command! -nargs=0 FloaterOpen call floater#Exec(&shell, v:false)

