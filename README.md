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
$ sudo chown -R $USER /usr/local/go/pkg
$ CGO_ENABLED=0 go install -a -installsuffix cgo std
```

`GOPATH` is set to `~/.go` in [~/.path](bash/.path)


Install Docker
--------------

Create `docker` group so we don't have to use `sudo`:
```console
$ sudo groupadd docker
$ sudo gpasswd -a $USER docker
```

> There are some security considerations to this, see
> [Docker Daemon Attack Surface][].

See latest Docker version:
```console
$ curl -sSL https://api.github.com/repos/docker/docker-ce/releases/latest | jq --raw-output .tag_name
```

Install Docker from static binaries:
```console
$ DOCKER_VERSION=$(curl -sSL https://api.github.com/repos/docker/docker-ce/releases/latest | jq --raw-output .tag_name)
$ curl -Lo /tmp/docker.tgz "https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER_VERSION#v}.tgz"
$ sudo tar -C /usr/local/bin --strip-components 1 -xzvf /tmp/docker.tgz
```

Include contributed completions for Bash:
```console
$ mkdir -p /etc/bash_completion.d
$ curl -Lo /etc/bash_completion.d/docker https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker
```


Install Docker Compose
----------------------

See latest Docker Compose version:
```console
$ curl -sSL https://api.github.com/repos/docker/compose/releases/latest | jq --raw-output .tag_name
```

Install Docker Compose from static binaries:
```console
$ COMPOSE_VERSION=$(curl -sSL https://api.github.com/repos/docker/compose/releases/latest | jq --raw-output .tag_name)
$ sudo curl -Lo /usr/local/bin/docker-compose "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)"
$ sudo chmod +x /usr/local/bin/docker-compose
```

Include contributed completions for Bash:
```console
$ mkdir -p /etc/bash_completion.d
$ curl -Lo /etc/bash_completion.d/docker-compose https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose
```


Install asdf-vm
---------------

Install asdf-vm:
```console
$ ASDF_VERSION=$(curl -sSL https://raw.githubusercontent.com/asdf-vm/asdf/master/VERSION)
$ git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_VERSION
```

Include completions for Bash:
```console
$ mkdir -p /etc/bash_completion.d
$ cp ~/.asdf/completions/asdf.bash /etc/bash_completion.d/asdf
```


Vim plugins
-----------

Plugins are managed using Vim's native packages ([Vim8 packages][]) with Git
Submodules.

See `:help packages` in Vim for how packages are used.

Add a plugin:
```console
$ cd ~/dotfiles
$ git submodule add https://github.com/fatih/vim-go.git vim/.vim/pack/go/opt/vim-go
```


People who don't know they've contributed
-----------------------------------------

- [jessfraz](https://github.com/jessfraz/dotfiles)
- [alexpearce](https://github.com/alexpearce/dotfiles)
- [nicknisi](https://github.com/nicknisi/dotfiles/)


  [Docker Daemon Attack Surface]: https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface

  [Vim8 packages]: https://vimhelp.org/repeat.txt.html#packages
