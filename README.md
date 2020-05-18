# README
## [Go](https://github.com/golang/go)
### Install
```
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update
sudo apt install golang-go
```

### Configure
```
set -xU GOROOT /usr/local/go
set -xU GOPATH $HOME/.go
set -pU fish_user_paths $GOROOT/bin
set -pU fish_user_paths $GOPATH/bin
```

## [fish](http://fishshell.com)
### Install
```
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish
chsh -s $(which fish)
# or `sudo vim /etc/passwd`
```

### [fisher](https://github.com/jorgebucaran/fisher)
```
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
```

## [dot](https://github.com/ssh0/dot)
### Install & Configure
```
go get github.com/ssh0/dot
set -xU DOT_DIR $HOME/.dotfiles
set -xU DOT_REPO https://github.com/<user>/dotfiles.git
set -xU DOT_SCR $GOPATH/src/github.com/ssh0/dot
```

### Get plugin: [fish-dot](https://github.com/re3turn/fish-dot)
```
fisher add re3turn/fish-dot
```

### Clone dotfiles
```
dot clone && dot set
```

## [ghq](https://github.com/motemen/ghq)
```
go get github.com/motemen/ghq
```

## [volt](https://github.com/vim-volt/volt)
```
go get github.com/vim-volt/volt
set -xU VOLTPATH $HOME/.volt
volt get -l
```

## Enable ssh to remote repository
```
(mkdir ~/.ssh &&) cd ~/.ssh && ssh-keygen -t rsa
```

## [anyenv](https://github.com/anyenv/anyenv)
### Install
```
git clone https://github.com/anyenv/anyenv ~/.anyenv
set -pU fish_user_paths $HOME/.anyenv/bin
```
