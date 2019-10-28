#!/bin/sh

set -e
cd ~/.vim_runtime/

# for ale
function install_linter_formater() {

    ###### for python #######

    # python linter
    pip3 install pylint --upgrade
    #@see https://gitlab.com/pycqa/flake8
    pip3 install flake8 --upgrade
    # python linter for style checking
    pip3 install pycodestyle --upgrade

    # python formating
    pip3 install black -U
    # sort imports alphabetically
    pip3 install isort -U
    pip3 install yapf -U
    pip3 install autopep8 -U

    ###### for golang #######

    # golang linter
    # go vet
    # go linter for style checking
    # golint

    # golang formating
    # gofmt
    # goimports

    ###### for java #######
    # java linter
    # javac

    # java formating
    # google-java-format
    # https://github.com/google/google-java-format/releases/download/google-java-format-1.7/google-java-format-1.7-all-deps.jar

    ###### for html #######
    # html linter
    npm install -g htmlhint

    ###### for css #######
    # css linter
    npm install -g stylelint
    npm install -g stylelint-config-standard
    npm install -g csslint

    ###### for javascript #######
    # css linter
    npm install -g eslint
    npm install -g standard
    npm config set unsafe-perm=true
    npm install -g fecs
    # js import format
    npm install -g import-js

    # html,css, vue, markdown, js formating
    yarn global add prettier
    npm install @starptech/prettyhtml --global
    npm -g install js-beautify

    # for js formating
    npm install -g prettier-eslint
    yarn global add prettier-eslint-cli

    ###### for yaml #######
    # yaml linter
    pip install yamllint
    # yaml formating
    # use prettier

    ###### for vue #######
    # vue linter
    # use vls, tsserver
    # vue formating
    # use prettier

    ###### for json #######
    # vue linter
    npm install -g jsonlint
    # json formating
    # use prettier

    ###### for dockerfile #######
    # dockerfile linter
    npm i -g dockerfile-linter

    ###### for vim #######
    # vim linter
    pip3 install vim-vint -U

    ###### for markdown #######
    # markdown linter
    npm install -g markdownlint
    npm install -g markdownlint-cli
    npm install -g alex
    #gem install mdl
    npm install -g write-good
    npm install -g textlint

    ###### for sql #######
    # sql linter
    pip3 install sqlint
    # sql formating
    pip3 install sqlformat

    ###### for sh/bash/mksh #######
    # sh/bash/mksh formating
    # GO111MODULE=on cd $(mktemp -d)
    # go mod init tmp
    go get mvdan.cc/sh/cmd/shfmt
}

# for deoplete
function install_deoplete() {
    cd ~/.vim_runtime/my_plugins/
    # for vim auto complete
    pip3 install pynvim
    git clone --depth=1 https://github.com/Shougo/deoplete.nvim.git
    git clone --depth=1 https://github.com/roxma/nvim-yarp.git
    git clone --depth=1 https://github.com/roxma/vim-hug-neovim-rpc.git

    # javascript auto complete
    npm install -g tern
    git clone --depth=1 https://github.com/carlitux/deoplete-ternjs.git

    # go auto complete
    git clone --depth=1 https://github.com/deoplete-plugins/deoplete-go.git
    cd deoplete-go/ && make && cd ../

    # php auto complete
    git clone --depth=1 https://github.com/lvht/phpcd.vim.git
    cd phpcd.vim/ && composer install && cd ../

    # python auto complete
    git clone --recursive https://github.com/deoplete-plugins/deoplete-jedi.git
    cd deoplete-jedi/ && git submodule update --init && cd ../

    # sql auto complete
    git clone --depth=1 https://github.com/jjohnson338/deoplete-mssql.git

    # vim auto complete
    git clone --depth=1 https://github.com/Shougo/neco-vim.git

    # zsh auto complete
    git clone --depth=1 https://github.com/deoplete-plugins/deoplete-zsh.git

    # deoplete-tabnine
    git clone --depth=1 https://github.com/tbodt/deoplete-tabnine.git
    cd deoplete-tabnine/ && ./install.sh && cd ../

    git clone --depth=1 https://github.com/fszymanski/deoplete-emoji.git

}

# for coc
function install_coc() {
    mkdir -p ~/.vim/
    cp coc-settings.json ~/.vim/

    cd ~/.vim_runtime/my_plugins/
    curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz | tar xzfv -

    # install coc extensions , include language server support

    # php
    # php lsp
    npm i intelephense -g
    vim -c "CocInstall -sync coc-phpls coc-python | q"

    # python
    # python lsp
    pip3 install 'python-language-server[all]' -U
    vim -c "CocInstall -sync coc-python | q"

    # golang
    # golang lsp
    GO111MODULE=on go get golang.org/x/tools/gopls@latest
    vim -c "CocInstall -sync coc-go | q"

    # java
    # java lsp
    # @see https://github.com/eclipse/eclipse.jdt.ls
    vim -c "CocInstall -sync coc-java | q"

    # html
    # with html lsp
    vim -c "CocInstall -sync coc-html | q"

    # css, less, scss
    # with css lsp
    vim -c "CocInstall -sync coc-css | q"

    # javascript
    # with Tsserver language server
    vim -c "CocInstall -sync coc-tsserver | q"

    # jest
    # @see https://jestjs.io/
    yarn global add jest
    vim -c "CocInstall -sync coc-snippets | q"
    vim -c "CocInstall -sync https://github.com/andys8/vscode-jest-snippets | q"

    # vue
    # with vue-language-server
    npm install vue-language-server -g
    vim -c "CocInstall -sync coc-vetur | q"

    # yaml
    # with yaml lsp
    # yaml-language-server, not work for completion
    vim -c "CocInstall -sync coc-yaml | q"

    # json
    # with json lsp, vscode-json-languageservice
    vim -c "CocInstall -sync coc-json | q"

    # dockerfile
    # dockerfile lsp
    npm install -g dockerfile-language-server-nodejs
    vim -c "CocInstall -sync coc-docker | q"

    # markdown, vim
    # markdown lsp, not work
    GO111MODULE=off go get github.com/mattn/efm-langserver

    # xml
    # with xml lsp
    vim -c "CocInstall -sync coc-xml | q"

    # vim
    # with lsp
    vim -c "CocInstall -sync coc-vimlsp | q"

    # git
    vim -c "CocInstall -sync coc-git | q"

    # shell
    # shell lsp
    npm i -g bash-language-server

    # emoji, only work in markdown
    vim -c "CocInstall -sync coc-emoji | q"

    # tabnine, not work
    # vim -c "CocInstall -sync coc-tabnine | q"

    # other completion source
    vim -c "CocInstall -sync coc-dictionary coc-tag coc-word coc-syntax coc-git coc-lists | q"

    # vim -c "CocInstall -sync coc-phpls coc-python coc-go coc-json coc-html coc-css coc-tsserver coc-vetur coc-yaml coc-docker coc-git coc-xml coc-highlight coc-snippets coc-lists coc-vimlsp coc-tabnine coc-marketplace coc-eslint coc-prettier coc-calc coc-stylelint coc-todolist coc-bookmark coc-webpack coc-ultisnips coc-sh coc-sql coc-lua coc-eomji coc-markdownlint coc-syntax coc-clock coc-ccls| q"
}

function install_vim_go() {
    vim -E --not-a-term -c "GoInstallBinaries" -c q
}

install_linter_formater
install_vim_go
# install_deoplete
install_coc

echo "Installed the Custom Vim configuration successfully! Enjoy :-)"
