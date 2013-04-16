brew update
brew upgrade

exec < homebrew_list
while read line
do
  brew install $line
done

echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."