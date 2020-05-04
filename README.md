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


Install Python
--------------

Install prerequisites:
```console
$ sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git --no-install-recommends
```

Install asdf-python plugin:
```console
$ asdf plugin-add python
```

See latest Python version (CPython):
```console
$ asdf list all python | grep ^[0-9][0-9.]*$ | tail -n1
```

Install Python using asdf-vm:
```console
$ PYTHON_VERSION=$(asdf list all python | grep ^[0-9][0-9.]*$ | tail -n1)
$ asdf install python $PYTHON_VERSION
```

Set global Python version:
```console
$ asdf global python $PYTHON_VERSION
$ pip install --upgrade pip
```

Install formatting tools (used by ALE):
```console
$ pip install black flake8 isort
$ asdf reshim python
```

> This will make the `black`, `flake8` and `isort` binaries available in the
> environment. These are also used by ALE, in Vim, to lint and fix code.

Create a `pyproject.toml` and `setup.cfg` in your Python project directory.

Put your configuation for...

- [Black](https://black.readthedocs.io/) in `pyproject.toml` under `[tool.black]`
- [Flake8](https://flake8.pycqa.org/) in `setup.cfg` under `[flake8]`
- [isort](https://github.com/timothycrosley/isort) in `pyproject.toml` under `[tool.isort]`

... and ALE will do the rest.

See Python project [configuration examples](examples/python/).


Install Node.js
---------------

Install prerequisites:
```console
$ sudo apt install -y dirmngr gpg curl --no-install-recommends
```

Install asdf-nodejs plugin:
```console
$ asdf plugin-add nodejs
```

Add the Node.js release team's gpg keys:
```console
$ gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 4ED778F539E3634C779C87C6D7062848A1AB005C 94AE36675C464D64BAFA68DD7434390BDBE9B9C5 71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 DD8F2338BAE7501E3DD5AC78C273792F7D83545D A48C2BEE680E841632CD4E44F07496B3EB3C1762 B9E2F5981AA6E0CD28160D9FF13993A75599653C
```

> Latest keys are in the Node.js [README.md](https://github.com/nodejs/node/#release-keys).

See latest Node.js version:
```console
$ asdf list all nodejs | grep ^[0-9][0-9.]*$ | tail -n1
```

Install Node.js using asdf-vm:
```console
$ NODE_VERSION=$(asdf list all nodejs | grep ^[0-9][0-9.]*$ | tail -n1)
$ asdf install nodejs $NODE_VERSION
```

Set global Node.js version:
```console
$ asdf global nodejs $NODE_VERSION
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
