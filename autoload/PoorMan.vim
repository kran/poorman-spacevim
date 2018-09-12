if exists("g:loaded_poorman_spacevim") 
 finish
endif
let g:loaded_poorman_spacevim = "v1"

let s:confirm_commands = {}

func! s:addGroup(list, name, path)
    if len(a:path) == 0 
        let a:list._name = a:name
    else
        if !has_key(a:list, a:path[0])
            let a:list[a:path[0]] = {}
        endif
        call s:addGroup(a:list[a:path[0]], a:name, a:path[1:])
    endif
endfunc


func! s:addCommand(list, name, path, cmd, ft)
    if len(a:path) == 1
        if !has_key(a:list, a:path[0])
            let a:list[a:path[0]] = {'_cmds': {}}
        endif
        let a:list[a:path[0]]._cmds[a:ft] = [a:name, a:cmd]
    else
        if !has_key(a:list, a:path[0])
            echoerr "Group not found: " . a:path[0]
            return
        endif
        call s:addCommand(a:list[a:path[0]], a:name, a:path[1:], a:cmd, a:ft)
    endif
endfunc


func! s:runCommand(cmd)
    if len(a:cmd) == 0
        return
    endif
    execute a:cmd[1]
endfunc

func! s:selectCommand(cmds)
    let ft = &ft
    if has_key(a:cmds, ft)
        return a:cmds[ft]
    elseif has_key(a:cmds, "*")
        return a:cmds["*"]
    else
        return []
    endif
endfunc

func! s:callCmd(dict, parent)
    let choices = []
    let keys = []
    let itkeys = sort(keys(a:dict))
    for key in itkeys
        if key[0] == '_'
            continue
        endif

        let conf = a:dict[key]
        let str = "&" . key
        if has_key(conf, '_cmds')
            let cmd = s:selectCommand(conf._cmds)
            if len(cmd) == 0
                continue
            endif
            let str .= cmd[0]
        elseif has_key(conf, '_name')
            let str .= conf._name 
        endif

        call add(keys, key)
        call add(choices, str)
    endfor

    let choiceString = join(choices, "\n")
    if len(choiceString) == 0
        echo "No command!"
        return
    endif

    let c = confirm(a:parent . ":", choiceString) - 1
    if c == -1
        return
    endif

    redraw
    if !has_key(a:dict[keys[c]], '_cmds')
        call s:callCmd(a:dict[keys[c]], a:dict[keys[c]]._name)
    else
        call s:runCommand(s:selectCommand(a:dict[keys[c]]._cmds))
    endif
endfunc

func! PoorMan#Init(groups, cmds)
    let g:confirm_commands = {}
    for grp in a:groups 
        let path = split(grp[0], '\zs')
        call s:addGroup(s:confirm_commands, grp[1], path)
    endfor
    for cmd in a:cmds
        let path = split(cmd[0], '\zs')
        call s:addCommand(s:confirm_commands, cmd[1], path, cmd[2], cmd[3])
    endfor
endfunc

func! PoorMan#Trigger()
    call s:callCmd(s:confirm_commands, "")
endfunc

