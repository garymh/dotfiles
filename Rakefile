require 'rake'
# require 'highline/import'

class File
  def self.dotfiles_path file
    join(ENV['PWD'], file)
  end

  def self.home_directory_path file
    join(ENV['HOME'], ".#{File.basename(file)}")
  end

  def self.oh_my_zsh_dir
    join(ENV['HOME'], '.oh-my-zsh', 'custom')
  end

  def self.for_vim_dir file
    join(ENV['HOME'], '.vim', File.basename(file))
  end

  def self.home_symlink file
    original = dotfiles_path(file)
    new      = home_directory_path(original)

    custom_symlink(original, new)
  end

  def self.vim_symlink file
    original = dotfiles_path(file)
    new      = for_vim_dir(original)

    custom_symlink(original, new)
  end

  def self.basic_symlink old, new
    custom_symlink(old, new)
  end

  def self.custom_symlink old, new
    if File.exist?(new) # && FileUtils.identical?(old, new)
      puts "#{new} already created. skipping..."
    else
      FileUtils.ln_s(old, new, force: true)
      puts "Creating: #{new}"
    end
  end
end

desc 'setup zsh'
task :zsh do
  install_oh_my_zsh
  switch_to_zsh
end

task default: 'install'
desc 'install dotfiles as symlinks'
task :install do
  install_submodules

  # home directory
  (Dir['home/*'] - %w(home/vim)).each do |f|
    File.home_symlink(f)
  end

  # vim directory
  (Dir['home/vim/*']).each do |f|
    File.vim_symlink(f)
  end

  oh_my_zsh_custom_files
  private_files
  install_neobundle
  create_vim_folders
  create_private_folders
  compile_fasd
  submodule_symlinks
  move_rbenv_default_gems
end

def install_submodules
  puts 'Installing submodules'
  `git submodule init`
end

def oh_my_zsh_custom_files
  %w(plugins themes).each do |f|
    new = File.join(File.oh_my_zsh_dir, f)
    old = File.join(ENV['PWD'], 'home/zsh', f)

    File.basic_symlink(old, new)
  end
end

def move_rbenv_default_gems
  File.basic_symlink(File.join(ENV['PWD'], 'new_machine', 'gems'),
                     File.join(ENV['RBENV_ROOT'], 'default-gems'))
end

def private_files
  private = File.join(ENV['PWD'], 'private')

  File.basic_symlink(File.join(private, 'gitconfig.local'),
                     File.home_directory_path('gitconfig.local'))

  File.basic_symlink(File.join(private, 'config'),
                     File.join(ENV['HOME'], '.ssh/config'))
end

def install_neobundle
  system 'curl https://raw.githubusercontent.com/' \
    'Shougo/neobundle.vim/master/bin/install.sh | sh'
end

def compile_fasd
  if `uname` == 'Linux'
    `cd submodules/fasd && PREFIX=$HOME make install`
  end
end

def create_private_folders
  FileUtils.mkdir_p File.join(ENV['HOME'], '.zsh/private')
  `touch ~/.zsh/private/private.zsh`
end

def submodule_symlinks
  File.basic_symlink(File.join(ENV['PWD'], 'submodules/dir_colors_solarized',
                               'dircolors.ansi-dark'),
                     File.join(ENV['HOME'], '.dir_colors'))
end

def create_vim_folders
  dirs = %w(bundle view tmp/unite tmp/backups tmp/swap)
  dirs.each do |d|
    dir = File.join(ENV['HOME'], '.vim', d)
    puts "creating folder: #{dir}"
    FileUtils.mkdir_p dir
  end

  File.basic_symlink(File.join(ENV['PWD'], 'vim', 'after'),
                     File.for_vim_dir('after'))

  File.basic_symlink(File.join(ENV['PWD'], 'vim', 'ftplugin'),
                     File.for_vim_dir('ftplugin'))

  File.basic_symlink(File.join(ENV['PWD'], 'vim', 'Ultisnips'),
                     File.for_vim_dir('neosnippets'))
end

def install_oh_my_zsh
  if File.exist?(File.join(ENV['HOME'], '.oh-my-zsh'))
    puts 'found ~/.oh-my-zsh'
  else
    print 'install oh-my-zsh? [ynq] '
    case $stdin.gets.chomp
    when 'y'
      puts 'installing oh-my-zsh'
      system 'curl -L http://install.ohmyz.sh | sh'
    when 'q'
      exit
    else
      puts 'skipping oh-my-zsh, you will need to change ~/.zshrc'
    end
  end
end

def switch_to_zsh
  if ENV['SHELL'] =~ /zsh/
    puts 'using zsh'
  else
    if yesno('Switch to zsh?')
      puts 'switching to zsh'
      system 'chsh -s `which zsh`'
    else
      puts 'skipping zsh'
    end
  end
end

task :update_submodules do
  puts 'Updating submodules'
  `git submodule update`
  `git submodule foreach git pull origin master`
end

# from https://gist.github.com/botimer/2891186
def yesno(prompt = 'Continue?', default = true)
  a = ''
  s = default ? '[Y/n]' : '[y/N]'
  d = default ? 'y' : 'n'
  until %w[y n].include? a
    a = ask("#{prompt} #{s} ") { |q| q.limit = 1; q.case = :downcase }
    a = d if a.length == 0
  end
  a == 'y'
end
