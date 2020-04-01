function __volt_plugin_search -d 'Search config file of vim plugin managed volt'
    set -l selected_plugin
    volt list -f "{{ range .Repos }}{{ println .Path }}{{ end }}" | fzf --ansi | read selected_plugin
    [ -n "$selected_plugin" ]; and vim $VOLTPATH/plugconf/$selected_plugin.vim
    commandline -f repaint
end
