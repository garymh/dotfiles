require 'rake'

# TODO:
# rbenv
# source ~/.fresh/build/shell.sh

def install_homebrew
  puts 'Installing homebrew'
  system %{ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"}
  system 'brew tap Homebrew/brewdler'
  system 'cd homebrew && brew brewdle'
  # system 'brew brewdle'
end

def install_fresh
  puts 'Installing fresh'
  system 'bash -c "\`curl -sL get.freshshell.com\`"'
end

def install_submodules
  puts 'Installing submodules'
  system 'git submodule init'
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
  install_homebrew

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
