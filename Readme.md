
## About

This tiny plugin is inspired by [SpaceVim](https://spacevim.org/), I like the idea of using just one key to group commands. But not all the other features.

this plugin does *not* change the way you using vim.

## Screenshot

![poorman](https://raw.githubusercontent.com/kran/poorman-spacevim/master/poorman-vim.gif)

## Usage

```
let g:poorman_spacevim_cmds = #{
    \f: #{name: '文件', children: #{
        \m: #{name: "mru",      cmd: #{_: "History"}},
        \s: #{name: "save",     cmd: #{_: "w"}},
        \v: #{name: "vimrc",     cmd: #{_: "e ~/.vimrc"}},
        \a: #{name: "save all", cmd: #{_: "wa"}} }
    \},
    \0: #{name: "上次标签", cmd: #{_: "tablast"}},
    \1: #{name: "标签1",    cmd: #{_: "normal 1gt"}},
    \2: #{name: "标签2",    cmd: #{_: "normal 2gt"}},
    \3: #{name: "标签3",    cmd: #{_: "normal 3gt"}},
    \4: #{name: "标签4",    cmd: #{_: "normal 4gt"}},
    \r: #{name: "执行",     cmd: #{vim: "so %",       php: "!php %", go: "!go run %", lua: "!lua %"}},
    \n: #{name: "切换行号",     cmd: #{_: "set nu!"}},
    \p: #{name: "粘贴模式",     cmd: #{_: "set paste!"}},
    \d: #{name: "目录浏览器",     cmd: #{_: "NERDtreeToggle"}},
    \w: #{name: "字符定位",     cmd: #{_: "call EasyMotion#WB(0,2)"}},
    \c: #{name: "切换到当前目录",     cmd: #{_: "lcd %:p:h"}},
    \b: #{name: "Buffers",     cmd: #{_: "Buffers"}},
    \t: #{name: "Tags",     cmd: #{_: "Tags"}},
\}

" define your key bindings
nmap <silent> <space> :call PoorMan#Trigger()<cr>


```
