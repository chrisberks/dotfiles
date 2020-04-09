dotfiles
========


Install
-------

```console
$ cd ~/dotfiles
$ stow bash tmux vim # and whatever else you want
```


Install submodules
------------------

```console
$ git submodule update --init --recursive
```


Install Go
----------

Remove existing Go installation:
```console
$ sudo rm -rf /usr/local/go
```

Install from source:
```console
$ GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text")
$ curl -sSL "https://dl.google.com/go/${GO_VERSION}.linux-amd64.tar.gz" | sudo tar -v -C /usr/local -xz
```
For other Go versions see: [golang.org/dl](https://golang.org/dl/)

Rebuild stdlib for faster builds:
```console
$ sudo chown -R "${user}" /usr/local/go/pkg
$ CGO_ENABLED=0 go install -a -installsuffix cgo std
```

`GOPATH` is set to `~/.go` in [~/.path](bash/.path)


Vim plugins
-----------

Plugins are managed using Vim's native packages ([Vim8 packages](https://vimhelp.org/repeat.txt.html#packages)) with Git Submodules.

See `:help packages` in Vim for how packages are used.

Add a plugin:
```console
$ git submodule add https://github.com/fatih/vim-go.git ~/.vim/pack/go/opt/vim-go
```


People who don't know they've contributed
-----------------------------------------

- [jessfraz](https://github.com/jessfraz/dotfiles)
- [alexpearce](https://github.com/alexpearce/dotfiles)
- [nicknisi](https://github.com/nicknisi/dotfiles/)
