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


Install restic
--------------

See latest restic version:
```console
$ curl -sSL https://api.github.com/repos/restic/restic/releases/latest | jq --raw-output .tag_name
```

Install restic from binaries:
```console
$ RESTIC_VERSION=$(curl -sSL https://api.github.com/repos/restic/restic/releases/latest | jq --raw-output .tag_name)
$ RESTIC_URI="https://github.com/restic/restic/releases/download/${RESTIC_VERSION}"
$ curl -Lo /tmp/restic.bz2 "${RESTIC_URI}/restic_${RESTIC_VERSION#v}_$(uname -s)_$(dpkg --print-architecture).bz2"
$ sudo sh -c 'bzip2 -dc /tmp/restic.bz2 > /usr/local/bin/restic'
$ sudo chmod +x /usr/local/bin/restic
```

Include generated completions for Bash:
```console
$ mkdir -p /etc/bash_completion.d
$ sudo /usr/local/bin/restic generate --bash-completion /etc/bash_completion.d/restic
```

Include restic man pages:
```console
$ sudo mkdir -p /usr/local/share/man/man1
$ sudo /usr/local/bin/restic generate --man /usr/local/share/man/man1/
```


Install fd
----------

See latest fd version:
```console
$ FD_VERSION=$(curl -sSL https://api.github.com/repos/sharkdp/fd/releases/latest | jq --raw-output .tag_name)
$ curl -Lo /tmp/fd.deb "https://github.com/sharkdp/fd/releases/download/${FD_VERSION}/fd_${FD_VERSION#v}_amd64.deb"
$ sudo dpkg -i /tmp/fd.deb
```


Install ripgrep (rg)
--------------------

See latest ripgrep version:
```console
$ RIPGREP_VERSION=$(curl -sSL https://api.github.com/repos/BurntSushi/ripgrep/releases/latest | jq --raw-output .tag_name)
$ curl -Lo /tmp/ripgrep.deb "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/ripgrep_${RIPGREP_VERSION}_amd64.deb"
$ sudo dpkg -i /tmp/ripgrep.deb
```


Install skim (sk)
-----------------

See latest skim version:
```console
$ SKIM_VERSION=$(curl -sSL https://api.github.com/repos/lotabout/skim/releases/latest | jq --raw-output .tag_name)
$ SKIM_URI="https://github.com/lotabout/skim/releases/download/${SKIM_VERSION}/skim-${SKIM_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
$ curl -sSL $SKIM_URI | sudo tar -v -C /usr/local/bin -xz
```

Install vim plugin from skim's repo:
```console
$ mkdir -p ~/.vim/pack/utils/start/skim/plugin
$ curl -Lo ~/.vim/pack/utils/start/skim/plugin/skim.vim https://raw.githubusercontent.com/lotabout/skim/master/plugin/skim.vim
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


Install Haskell
---------------

Add GHC PPA to source list:
```console
$ sudo su -c 'echo -n "deb http://downloads.haskell.org/debian buster main" > /etc/apt/sources.list.d/haskell.list'
```

Add the GHC gpg key:
```console
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BA3CBA3FFE22B574
```

```console
$ sudo apt update
$ sudo apt install ghc-8.10.2 cabal-install-3.2
```


Install Firefox
---------------

> Windows 32bit              os=win
> Windows 64bit              os=win64
> OS X                       os=osx
> Linux x86_64               os=linux64
> Linux i686                 os=linux

```console
$ declare -A os=( ["x86_64"]="64" ["i686"]="" )
$ FIREFOX_OS="linux${os[$(uname -m)]}"
$ curl -sSL "https://download.mozilla.org/?product=firefox-latest&os=${FIREFOX_OS}&lang=en-GB" | sudo tar -v -C /opt -xj

$ curl -sSL "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-GB" | sudo tar -v -C /opt -xj
```


Install Thunderbird
-------------------

```console
$ curl -sSL "https://download.mozilla.org/?product=thunderbird-latest&os=linux64&lang=en-GB" | sudo tar -v -C /opt -xj
```


Install Google Chrome
---------------------

Add Google Chrome to source list:
```console
$ sudo su -c 'echo -n "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
```

Add the Google Chrome public key:
```console
$ curl -sSL https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
```

```console
$ sudo apt update
$ sudo apt install google-chrome-stable --no-install-recommends
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
