function __ev_find_my_vimrc -d "Search my vimrc"
    if command -q volt; and test -e $VOLTPATH/rc/(volt list -f "{{ .CurrentProfileName }}")/vimrc.vim
        printf "%s" $VOLTPATH/rc/(volt list -f "{{ .CurrentProfileName }}")/vimrc.vim
        return
    else if test -e $HOME/.vim/vimrc
        printf "%s" $HOME/.vim/vimrc
        return
    else if test -e $HOME/.vimrc
        printf "%s" $HOME/.vimrc
        return
    else
        echo "vimrc not found"
        return false
    end
end

function ev
    [ -n "$EDITOR" ]; and set editor $EDITOR; or set editor 'vim'

    set myvimrc (__ev_find_my_vimrc)
    or return false

    eval "$editor" $myvimrc
end

