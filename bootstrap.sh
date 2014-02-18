git submodule update --recursive --init

rm -rf ~/.zsh
rm -rf ~/.zshrc
rm -rf ~/.gitignore_global
rm -rf ~/.ssh/config
rm -rf ~/.ackrc
rm -rf ~/.gemrc
rm -rf ~/.gitconfig

ln -s $(command pwd)/zsh/oh-my-zsh ~/.oh-my-zsh
ln -s $(command pwd)/zsh ~/.zsh
ln -s $(command pwd)/zsh/zshrc ~/.zshrc
ln -s $(command pwd)/tmux ~/.tmux
ln -s $(command pwd)/tmux/tmux.conf ~/.tmux.conf
ln -s $(command pwd)/tmux/tmuxinator ~/.tmuxinator
ln -s $(command pwd)/vim/vim ~/.vim
ln -s $(command pwd)/vim/vimrc ~/.vimrc
ln -s $(command pwd)/home_dir/gitignore_global ~/.gitignore_global
ln -s $(command pwd)/home_dir/ackrc ~/.ackrc
ln -s $(command pwd)/home_dir/gemrc ~/.gemrc
ln -s $(command pwd)/home_dir/gitconfig ~/.gitconfig
ln -s $(command pwd)/home_dir/pry ~/.pry
ln -s $(command pwd)/home_dir/pryrc.rb ~/.pryrc
ln -s $(command pwd)/home_dir/pryrc-helpers.rb ~/.pryrc-helpers.rb
ln -s $(command pwd)/home_dir/mackup.cfg ~/.mackup.cfg
ln -s $(command pwd)/home_dir/mackup ~/.mackup
ln -s $(command pwd)/private/config ~/.ssh/config
ln -s $(command pwd)/zsh/gary.zsh-theme zsh/oh-my-zsh/themes/gary.zsh-theme
ln -s $(command pwd)/private/netrc ~/.netrc

mkdir -p zsh/oh-my-zsh/custom/plugins
ln -s $(command pwd)/zsh/eifion zsh/oh-my-zsh/custom/plugins/eifion

if [[ $(uname) = 'Linux' ]]; then
  cd submodules/fasd
  PREFIX=$HOME make install
  cd ..
fi

cp submodules/rmate/rmate ~/bin

mkdir ./zsh/private
touch ./zsh/private/private_files_go_here.zsh
