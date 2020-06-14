if command -qs batcat; and ! functions -q bat
    alias bat=batcat
end

if command -qs batcat; or command -qs bat
    # man
    set -q MANPAGER; or set -xU MANPAGER "sh -c 'col -bx | bat -l man -p'"
else
    echo "Please install bat first. Check https://github.com/sharkdp/bat"
end
