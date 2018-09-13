
## About

This tiny plugin is inspired by [SpaceVim](https://spacevim.org/), I like the idea of using just one key to group commands. But not all the other features.

this plugin does *not* change the way you using vim.

## Screenshot

![poorman](https://raw.githubusercontent.com/kran/poorman-spacevim/master/poorman-vim.gif)

## Usage

```
" define groups
" format: [$key, $name]
let s:groups = [
    \["a", "application"],
    \["b", "buffer"],
    \["s", "cscope"],
    \["p", "project"],
    \["f", "files"],
    \["ff", "formater"],
    \["t", "toggle"],
    \["j", "jump"],
\]


" then define commands under groups
" format: [$key, $name, $command, $filetype]
" commands will show in all buffer when filetype with * 
" others will show on matching the buffer filetype
let s:commands = [
    \["sa", "connect source", "cs add cscope.out", "*"],
    \["ss", "find current", "call CScopeConfirm(expand('<cword>'))", "*"],
    \["si", "input", "call CScopeConfirm('')", "*"],
    \["ffj", "json", "%!python -m json.tool", "*"],
    \["1", "tab1", "normal 1gt", "*"],
    \["2", "tab2", "normal 2gt", "*"],
    \["3", "tab3", "normal 3gt", "*"],
    \["4", "tab4", "normal 4gt", "*"],
    \["0", "tablast", "tablast", "*"],
    \["r", "quickrun", "!php %", "php"],
    \["r", "quickrun", "so %", "vim"],
    \["r", "quickrun", "!go run %", "go"],
    \["r", "quickrun", "!cargo run", "rust"],
    \["c", "change dir", "lcd %:p:h", "*"],
    \["d", "nerdtree", "NERDTreeToggle", "*"],
    \["bt", "buffer tags", "Denite outline", "*"],
    \["g", "grep", "Denite grep -ignorecase", "*"],
    \["pt", "tags", "Denite tag", "*"],
    \["tn", "line number", "set nu!", "*"],
    \["tp", "paste", "set paste!", "*"],
    \["th", "hightlight", "call ToggleHighlight()","*"],
    \["w", "easymotion", "call EasyMotion#WB(0,2)", "*"],
    \["jd", "goto define", "normal \<plug>DeopleteRustGoToDefinitionDefault", "rust"],
    \["jh", "show help", "normal \<plug>DeopleteRustShowDocumentation", "rust"],
\]

" now register groups and commands to PoorMan
call PoorMan#Init(s:groups, s:commands)

" define your key bindings
nmap <silent> <space> :call PoorMan#Trigger()<cr>
nmap <silent> <c-n> :call PoorMan#Trigger()<cr>
imap <silent> <c-n> :call PoorMan#Trigger()<cr>

```

## Similar plugins 

- [vim-which-key](https://github.com/liuchengxu/vim-which-key), much better UI

