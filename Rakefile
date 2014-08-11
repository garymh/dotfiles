require 'rake'
require 'pry'

class File
  def self.in_working_dir file
    join(ENV['PWD'], file)
  end

  def self.for_home_dir file
    expand_path("~/.#{basename(file)}")
  end

  def self.for_vim_dir file
    expand_path("~/.vim/#{basename(file)}")
  end

  def self.already_linked? file
    exist?(file) && symlink?(file)
  end

  def self.custom_symlink old, new
    if already_linked?(new)
      puts "#{new} already exists"
    else
      File.symlink(old, new)
      puts "symlink created: #{new}"
    end
  end

  def self.home_symlink file
    original = in_working_dir(file)
    new      = for_home_dir(original)

    custom_symlink(original, new)
  end

  def self.vim_symlink file
    original = in_working_dir(file)
    new      = for_vim_dir(original)

    custom_symlink(original, new)
  end

  def self.oh_my_zsh_dir
    File.join(ENV['HOME'], '.oh-my-zsh', 'custom')
  end
end

desc 'setup zsh'
task :zsh do
  install_oh_my_zsh
  switch_to_zsh
end

desc 'delete old files'
task :delete_files do
  old_files = %w{.zsh .zshrc .zshenv .gitignore_global
                .ssh/config .gemrc .gitconfig
                .dir_colors .git_templates .gitconfig.local
                .netrc .mackup.cfg .pry .pryrc .pryrc-helpers.rb
                .rubocop.yml .tidyrc .tmux .tmux.conf .tmuxinator
                .vimrc .zshrc .zshenv
  }

  old_files.each do |f|
    file = File.join(ENV['HOME'], f)
    File.delete(file) if File.exists?(file)
  end
end

desc 'symlink dotfiles'
task :dotfile_links do
  (Dir['home/*'] - %w{home/vim}).each do |f|
    File.home_symlink(f)
  end

  (Dir['home/vim/*']).each do |f|
    File.vim_symlink(f)
  end

  %w{plugins themes}.each do |f|
    new = File.join(File.oh_my_zsh_dir, f)
    old = File.join(ENV['PWD'], 'home/zsh', f)

    FileUtils.rm_rf(new) if File.exists?(new)
    File.symlink(old, new)
  end
end

desc 'Install submodules'
task :init_submodules do
  puts 'Installing submodules'
  `git submodule init`
end

desc 'Update submodules'
task :update_submodules do
  puts 'Updating submodules'
  `git submodule update`
  `git submodule foreach git pull origin master`
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], '.oh-my-zsh'))
    puts 'found ~/.oh-my-zsh'
  else
    print 'install oh-my-zsh? [ynq] '
    case $stdin.gets.chomp
    when 'y'
      puts 'installing oh-my-zsh'
      system %Q{curl -L http://install.ohmyz.sh | sh}
    when 'q'
      exit
    else
      puts 'skipping oh-my-zsh, you will need to change ~/.zshrc'
    end
  end
end

def already_linked? file
  File.identical? "home/#{file}", File.join(ENV['HOME'], "#{file}")
end

def switch_to_zsh
  if ENV['SHELL'] =~ /zsh/
    puts 'using zsh'
  else
    print 'switch to zsh? (recommended) [ynq] '
    case $stdin.gets.chomp
    when 'y'
      puts 'switching to zsh'
      system %Q{chsh -s `which zsh`}
    when 'q'
      exit
    else
      puts 'skipping zsh'
    end
  end
end

