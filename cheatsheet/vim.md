# Vim Cheat Sheet
## NOW
- `.` : repeat cmd
- `r{char}`: Replace cursol to {char}
- In INSERT mode
    - `Ctrl-W`: delete word (back cursor)
- In CommandLine mode
    - `Ctrl-R` + `register`: paster resigter

## Plugin
- `:SwitchColorScheme`: 色変更プラグイン
- `:CtrlPGhq`: GHQ起動

## Move
- `w` : word next
- `b` : word prev
- `e` : word next tail
- `f{char}` : right {char}
- 'F{char}` : left {char}
    - `;/,`: repeat `f/F/t/T` forward/opposite
- `}/{`: paragraph（段落）
- `\_`: 先頭 ($の逆)

```
               gg
               ?
              C-b
               H
               {
               k
^ F T ( b ge h   l w e ) t f $
               j
               }
               L
              C-f
               /
               G
```

## Edit
- `c{object}`: `d`の`s`版
- `gU{object}`: Upper
- `gu{object}`: Lower
- `g~{object}`: Switch Upper/Lower
- `gJ`: same `J` without inserting space

## Object
- `iw`: word
- `aw`: word with white space
- `ip`: paragraph
- `ap`: paragraph with last white line
- Block: `[ ]`, `( )`, `< >`, `" "`, `' '`
    - `t`: tag of html, xml

## Window
- `Ctrl-W`
    - `S`: Split horizontal
    - `v`: Split Vertical
    - `r`: Rotate downwards/rightwards
    - `R`: Rotate upwards/leftwards
    - `x`: Exchange current with next
    - `HJKL`: Move to the left/bottom/top/right
        - Using it, switch vertical/horizontal
    - `T`: Move to newtab

## Tab
- `gt`: go to next tab
- `gT`: go to preview tab

## Etc...
### コマンドラインのCtrl-R
yankしたものをコマンドラインに貼り付けられる

- `Ctrl-R`
    - `"`: Paste
    - `Ctrl-A`: Paste カーソル下の単語 （空白まで）
    - `Ctrl-W`: カーソル下のキーワード
    - `Ctrl-F`: カーソルしたのファイル名
