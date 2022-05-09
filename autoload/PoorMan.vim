if exists("g:loaded_poorman_spacevim") 
 finish
endif
let g:loaded_poorman_spacevim = "v1"

let s:pcg = v:null

func! s:runCommand(cmd)
    if a:cmd is v:null
        return
    endif
    execute a:cmd
endfunc

func! s:selectCommand(cmds)
    let ft = &ft
    if has_key(a:cmds, ft)
        return a:cmds[ft]
    elseif has_key(a:cmds, "_")
        return a:cmds["_"]
    else
        return v:null
    endif
endfunc


func PoorManCmdFilter(winid, key)
    if has_key(s:pcg, a:key) 
        call popup_close(a:winid)
        let sel = s:pcg[a:key]
        if has_key(sel, 'children')
            call s:callCmd(sel.children)
        else
            call s:runCommand(s:selectCommand(sel.cmd))
        endif
        return 1
    endif

    return popup_filter_menu(a:winid, a:key)
endfunc

func! s:callCmd(dict)
    let s:pcg = a:dict
    let choices = []
    let maxlen = 0
    for [k, it] in items(a:dict)
        let choice = '['.k. ']'.it.name
        if has_key(it, 'children')
            let choice .= ' →'
            call add(choices, choice)
        else
            let ft = &ft
            if has_key(it.cmd, '_') || has_key(it.cmd, ft)
                call add(choices, choice)
            endif
        endif
    endfor
    call popup_menu(choices, #{filter: 'PoorManCmdFilter'})
endfunc

func! PoorMan#Trigger()
    call s:callCmd(g:poorman_spacevim_cmds)
endfunc
