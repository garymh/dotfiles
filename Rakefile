require 'rake'

# TODO:
# homebrew?
# zsh
# rbenv
# source ~/.fresh/build/shell.sh

def install_fresh
  puts 'Installing fresh'
  `bash -c "\`curl -sL get.freshshell.com\`"`
end

def install_submodules
  puts 'Installing submodules'
  `git submodule init`
end

def switch_to_zsh
  if ENV['SHELL'] =~ /zsh/
    puts 'using zsh'
  else
    if yesno('Switch to zsh?')
      puts 'switching to zsh'
      system 'command -v zsh | sudo tee -a /etc/shells'
      system 'chsh -s `which zsh`'
    else
      puts 'skipping zsh'
    end
  end
end

task default: 'install'
desc 'install dotfiles as symlinks'
task :install do

end

desc 'setup zsh'
task :zsh do
  switch_to_zsh
end

task :update_submodules do
  puts 'Updating submodules'
  `git submodule update`
  `git submodule foreach git pull origin master`
end

# from https://gist.github.com/botimer/2891186
def yesno prompt = 'Continue?', default = true
  a = ''
  s = default ? '[Y/n]' : '[y/N]'
  d = default ? 'y' : 'n'
  until %w(y n).include? a
    a = ask("#{prompt} #{s} ") { |q| q.limit = 1; q.case = :downcase }
    a = d if a.length == 0
  end
  a == 'y'
end
