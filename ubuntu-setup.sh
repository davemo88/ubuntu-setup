#!bin/bash

apt-get update
# need to get vim since default vim is tiny version and we need huge
# e.g. vim-plug doesn't work with tiny
apt-get install vim curl git build-essential cmake automake autotools-dev python3-dev vlc -y

# rust and rust-analyzer to use with vim
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer --create-dirs
chmod +x ~/.local/bin/rust-analyzer

echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> .profile

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vimrc
git clone https://github.com/davemo88/vimrc 
cd vimrc && \
    git checkout rust && \
    cd $HOME

ln -s vimrc/vimrc .vimrc

vi +PlugInstall +qa

# build with rust completion after installing the plugin
cd .vim/plugged/YouCompleteMe/ && \
    ./install.py --rust-completer && \
    cd $HOME

# ctags for vim-tagbar
git clone https://github.com/universal-ctags/ctags.git && \
    cd ctags && \
    ./autogen.sh && \
    .configure --prefix=$HOME/.local/ && \
    make && \
    make install && \
    cd $HOME

#firefox https://addons.mozilla.org/firefox/downloads/file/3498619/adnauseam-3.9.104-an+fx.xpi
#firefox https://addons.mozilla.org/firefox/downloads/file/3542788/leechblock_ng-1.0.5-an+fx.xpi
