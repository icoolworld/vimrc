#!/bin/sh

set -e
cd ~/.vim_runtime/

# for ale
function install_linter_formater(){
    # install synatx checker
    npm install -g csslint
    npm install -g htmlhint
    npm config set unsafe-perm=true
    npm install -g fecs
    npm install -g stylelint
    npm install -g stylelint-config-standard
    npm install -g markdownlint
    npm install -g markdownlint-cli
    npm install -g alex
    #gem install mdl
    npm install -g jsonlint
    npm install -g write-good
    npm install -g textlint
    pip install yamllint
}

# for deoplete
function install_deoplete(){
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
    curl --fail -L https://github.com/neoclide/coc.nvim/archive/release.tar.gz|tar xzfv -

    # install coc extensions , include language server support
    vim -c "CocInstall -sync coc-phpls coc-python coc-go coc-json coc-html coc-css coc-tsserver coc-vetur coc-yaml coc-docker coc-git coc-xml coc-highlight coc-snippets coc-lists coc-vimlsp coc-tabnine coc-marketplace coc-eslint coc-prettier coc-calc coc-stylelint coc-todolist coc-bookmark coc-webpack coc-ultisnips coc-sh coc-sql coc-lua coc-eomji coc-markdownlint coc-syntax coc-clock coc-ccls| q"
}

function install_vim_go() {
    vim -c "GoInstallBinaries"
}

install_linter_formater
# install_deoplete
install_coc
install_vim_go

echo "Installed the Custom Vim configuration successfully! Enjoy :-)"
