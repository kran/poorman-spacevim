if exists("g:loaded_poorman_spacevim") 
    finish
endif


let g:loaded_poorman_spacevim = "v1"
let s:menu = v:null
let s:menu_keys_sorted = []

func! s:executeCommand(cmd)
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

func! s:triggerMenuItem(sel)
    if has_key(a:sel, 'children')
        call s:popupMenu(a:sel.children)
    else
        call s:executeCommand(s:selectCommand(a:sel.cmd))
    endif
endfunc


func PoorManMenuFilter(winid, key)
    if has_key(s:menu, a:key) 
        call popup_close(a:winid, -2)
        let sel = s:menu[a:key]
        call s:triggerMenuItem(sel)
        return 1
    endif

    return popup_filter_menu(a:winid, a:key)
endfunc

func PoorManMenuCallback(winid, id)
    if a:id > 0 
        let sel = s:menu[s:menu_keys_sorted[a:id-1]]
        call s:triggerMenuItem(sel)
    endif
endfunc

func! s:popupMenu(dict)
    let s:menu = a:dict
    let s:menu_keys_sorted = []
    let keys_sorted = sort(keys(a:dict))
    let choices = []
    let maxlen = 0
    for k in keys_sorted
        let it = a:dict[k]
        let choice = '['.k. ']'.it.name
        if has_key(it, 'children')
            let choice .= ' ▼' 
            call add(choices, choice)
            call add(s:menu_keys_sorted, k)
        else
            let ft = &ft
            if has_key(it.cmd, '_') || has_key(it.cmd, ft)
                call add(choices, choice)
                call add(s:menu_keys_sorted, k)
            endif
        endif
    endfor
    let winid = popup_menu(choices, #{filter: 'PoorManMenuFilter', callback: 'PoorManMenuCallback'})
endfunc

func! PoorMan#Trigger()
    call s:popupMenu(g:poorman_spacevim_cmds)
endfunc
