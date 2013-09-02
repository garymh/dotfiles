
git submodule init
git submodule update

rm -rf ~/.oh-my-zsh
rm -rf ~/.zsh
rm -rf ~/.zshrc
rm -rf ~/.gitignore_global
rm -rf ~/.ssh/config
rm -rf ~/.ackrc
rm -rf ~/.gemrc
rm -rf ~/.gitconfig
rm -rf ~/.irbrc
rm -rf zsh/oh-my-zsh/themes/gary.zsh-theme
rm -rf zsh/oh-my-zsh/custom/eifion

ln -s $(command pwd)/zsh/oh-my-zsh ~/.oh-my-zsh
ln -s $(command pwd)/zsh ~/.zsh
ln -s $(command pwd)/zsh/zshrc ~/.zshrc
ln -s $(command pwd)/gitignore_global ~/.gitignore_global
ln -s $(command pwd)/ackrc ~/.ackrc
ln -s $(command pwd)/gemrc ~/.gemrc
ln -s $(command pwd)/gitconfig ~/.gitconfig
ln -s $(command pwd)/irbrc ~/.irbrc
ln -s $(command pwd)/private/config ~/.ssh/config
ln -s $(command pwd)/zsh/gary.zsh-theme zsh/oh-my-zsh/themes/gary.zsh-theme
mkdir zsh/oh-my-zsh/custom/plugins
ln -s $(command pwd)/zsh/eifion zsh/oh-my-zsh/custom/plugins/eifion

cd fasd
PREFIX=$HOME make install

mkdir ~/dotfiles/zsh/private
touch ~/dotfiles/zsh/private/private_files_go_here.zsh

cd ~

