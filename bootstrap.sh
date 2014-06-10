git submodule update --recursive --init

rm -rf ~/.zsh
rm -rf ~/.zshrc
rm -rf ~/.gitignore_global
rm -rf ~/.ssh/config
rm -rf ~/.ackrc
rm -rf ~/.gemrc
rm -rf ~/.gitconfig

tmpdir=$(command pwd)

ln -s $tmpdir/zsh/oh-my-zsh ~/.oh-my-zsh
ln -s $tmpdir/zsh ~/.zsh
ln -s $tmpdir/zsh/zshrc ~/.zshrc
ln -s $tmpdir/tmux ~/.tmux
ln -s $tmpdir/tmux/tmux.conf ~/.tmux.conf
ln -s $tmpdir/tmux/tmuxinator ~/.tmuxinator
ln -s $tmpdir/vim/vimrc ~/.vimrc
mkdir ~/.vim
ln -s $tmpdir/vim/plugin ~/.vim/plugin
ln -s $tmpdir/vim/syntax ~/.vim/syntax
ln -s $tmpdir/vim/UltiSnips ~/.vim/UltiSnips
mkdir ~/.vim/bundle
mkdir ~/.vim/view
mkdir ~/.vim/tmp
mkdir ~/.vim/tmp/unite
mkdir ~/.vim/tmp/backups
mkdir ~/.vim/tmp/swap
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

ln -s $tmpdir/home_dir/gitignore_global ~/.gitignore_global
ln -s $tmpdir/home_dir/ackrc ~/.ackrc
ln -s $tmpdir/home_dir/gemrc ~/.gemrc
ln -s $tmpdir/home_dir/gitconfig ~/.gitconfig
ln -s $tmpdir/home_dir/pry ~/.pry
ln -s $tmpdir/home_dir/pryrc.rb ~/.pryrc
ln -s $tmpdir/home_dir/pryrc-helpers.rb ~/.pryrc-helpers.rb
ln -s $tmpdir/home_dir/mackup.cfg ~/.mackup.cfg
ln -s $tmpdir/home_dir/mackup ~/.mackup
ln -s $tmpdir/private/config ~/.ssh/config
ln -s $tmpdir/zsh/gary.zsh-theme zsh/oh-my-zsh/themes/gary.zsh-theme
ln -s $tmpdir/zsh/gary_pure_mod.zsh-theme zsh/oh-my-zsh/themes/gary_pure_mod.zsh-theme
ln -s $tmpdir/private/netrc ~/.netrc

[ -f $tmpdir/private/gitconfig.local ] && ln -s $tmpdir/private/gitconfig.local ~/.gitconfig.local

mkdir -p zsh/oh-my-zsh/custom/plugins
ln -s $tmpdir/zsh/plugins/eifion/ $tmpdir/zsh/oh-my-zsh/custom/plugins/eifion

if [[ $(uname) = 'Linux' ]]; then
  cd submodules/fasd
  PREFIX=$HOME make install
  cd ..
fi

[ -d $tmpdir/private/ ] && echo "Private stuff already exists" || mkdir ./zsh/private
touch ./zsh/private/private_files_go_here.zsh
