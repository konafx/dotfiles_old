# README
You should install ArchLinux/Manjaro

## dependencies
[WIP]
```
paru -S base-devel zip unzip git
```

## chezmoi
[chezmoi](https://www.chezmoi.io/)
dotfile manager

Install
```
BINDIR="${LOCAL_BIN_DIR:-$HOME/.local/bin}" sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
chezmoi update
```

## Zsh
[Zsh](https://www.zsh.org/)
shell

```
chsh -s $(which zsh)
```

### zinit
zsh plugin manager
[zdharma-continuum/zinit: 🌻 Flexible and fast ZSH plugin manager](https://github.com/zdharma-continuum/zinit)


## afx
[WIP]
[AFX](https://babarot.me/afx/)


Install
```
AFX_BIN_DIR="${LOCAL_BIN_DIR:-$HOME/.local/bin}" curl -sL https://raw.githubusercontent.com/b4b4r07/afx/HEAD/hack/install | bash
```
