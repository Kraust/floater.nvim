" floater.nvim - Floating Terminal
" Maintainer: Kraust <http://github.com/kraust>
" Version 0.3

if exists('loaded_floater')
    finish
endif
let g:loaded_floater = 1

let g:floater_buf = -1

function! floater#Exec(command, close_on_open) abort
    let znew_buf=v:false
    if bufexists(g:floater_buf) == v:false
        let znew_buf=v:true
        let g:floater_buf = nvim_create_buf(v:false, v:true)
        call setbufvar(g:floater_buf, '&signcolumn', 'no')
        call setbufvar(g:floater_buf, '&number', '0')
        call setbufvar(g:floater_buf, '&buflisted', '0')
    endif

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

    call nvim_open_win(g:floater_buf, v:true, opts)
    if znew_buf == v:true
        call termopen(a:command)
        if a:close_on_open == v:true
            silent! exec 'bd'
        endif
    endif
endfunction

function! floater#Toggle()
    if bufwinid(g:floater_buf) == -1
        call floater#Exec(&shell, v:false)
    else
        silent! exec 'q'
    endif
endfunction

command! -nargs=0 FloaterOpen call floater#Exec(&shell, v:false)

command! -nargs=0 FloaterToggle call floater#Toggle()

