# ==============================
#   .pryrc
# ==============================

Pry.config.ls.heading_color = :bright_green
Pry.config.ls.public_method_color = :bright_blue
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

# Record how long you hack with Ruby this session.
pryrc_start_time = Time.now

require '~/.pryrc-helpers'

# ___ is to Avoid name conflict
___ = PryrcHelpers

# what are the gems you use daily in REPL? Put them in ___daily_gems
___daily_gems  = %w[benchmark]

# ___pry_gems is for loading vendor plugins for Pry.
___pry_gems = %w[awesome_print hirb sketches]

___daily_gems.___require_gems
___pry_gems.___require_gems

def show_screen
  if respond_to?(:save_screenshot)
    page.save_screenshot("screenshot.png")
    system("open 'screenshot.png'")
  end
end

## Enable Pry's show-method in Ruby 1.8.7
# https://github.com/pry/pry/wiki/FAQ#how-can-i-use-show-method-with-ruby-187
if RUBY_VERSION == "1.8.7"
  safe_require 'ruby18_source_location', "Install this gem to enable Pry's show-method"
  warn 'Ruby 1.8.7 is retired now, please consider upgrade to newer version of Ruby.'
end

# ==============================
#  Vulnerability Reminder
# ==============================

if RUBY_REVISION < 41671
  print ___.colorize "YOUR RUBY #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} HAS A VULNERABILITY IN SSL CLIENT, PLEASE CONSIDER UPGRADE TO LATEST VERSION. ", 31
  print ___.colorize "MORE INFORMATION: http://goo.gl/dAfuH\n", 31
end

# ============================
#   hirb
# ============================
# A mini view framework for console/irb that's easy to use, even while under its influence. Console goodies include a no-wrap table, auto-pager, tree and menu.
# Visit http://tagaholic.me/hirb/ to know more.

if defined? Hirb
  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

# ==============================
#   Awesome Print
# ==============================
# Pretty print your Ruby objects with style -- in full color and with proper indentation
# http://github.com/michaeldv/awesome_print
if defined? AwesomePrint
  AwesomePrint.pry!
  ## The following line enables awesome_print for all pry output,
  # and enables paging using Pry's pager with awesome_print.
  Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai(indent: 2)}", output)}
  ## If you want awesome_print without automatic pagination, use below:
  # Pry.config.print = proc { |output, value| output.puts value.ai }


  ## Evaluated result display inline
  # Pry.config.print = lambda { |output, value| output.print "\e[1A\e[18C # => "; output.puts value.inspect }

  ## if in bundler, break out, so awesome print doesn't have to be in Gemfile
  # if defined? Bundler
  #   Gem.post_reset_hooks.reject! { |hook| hook.source_location.first =~ %r{/bundler/} }
  #   Gem::Specification.reset
  #   load 'rubygems/custom_require.rb'
  # end
end # End of AwesomePrint

### End of Vendor Stuff

# ==============================
#   Pry Configurations
# ==============================

Pry.config.history.file = "~/.irb_history"
Pry.config.editor = "subl -w"
Pry.config.theme = 'monokai'

# ==============================
#   Pry Prompt
# ==============================

Pry.config.pager = true
Pry.config.color = true
Pry.config.history.should_save = true

# wrap ANSI codes so Readline knows where the prompt ends
def colour(name, text)
  if Pry.color
    "\001#{Pry::Helpers::Text.send name, '{text}'}\002".sub '{text}', "\002#{text}\001"
  else
    text
  end
end

# pretty prompt
# Pry.config.prompt = [
#   # proc { |object, nest_level, pry| colour :red, defined?(Rails) ? "#{Rails.env}" : "" },
#   proc do |object, nest_level, pry|
#     prompt = colour :blue, defined?(Rails) ? "[#{Rails.env[0]}] " : "[#{RUBY_VERSION}] "
#     prompt += colour :bright_black, Pry.view_clip(object)
#     prompt += ":#{nest_level}" if nest_level > 0
#     prompt += colour :cyan, ' » '
#   end, proc { |object, nest_level, pry| colour :cyan, '» ' }
# ]

# tell Readline when the window resizes
old_winch = trap 'WINCH' do
  if `stty size` =~ /\A(\d+) (\d+)\n\z/
    Readline.set_screen_size $1.to_i, $2.to_i
  end
  old_winch.call unless old_winch.nil?
end

# Exception
Pry.config.exception_handler = proc do |output, exception, _|
  puts ___.colorize "#{exception.class}: #{exception.message}", 31
  puts ___.colorize "from #{exception.backtrace.first}", 31
end

# Handy hotkeys for debugging!
if defined?(PryDebugger)
  Pry.config.commands.alias_command 'c', 'continue'
  Pry.config.commands.alias_command 's', 'step'
  Pry.config.commands.alias_command 'n', 'next'
  Pry.config.commands.alias_command 'f', 'finish'
end

# ==============================
#   Customized hotkeys for Pry
# ==============================
# Ever get lost in pryland? try w!
Pry.config.commands.alias_command 'w', 'whereami'
# Clear Screen
Pry.config.commands.alias_command '.clr', '.clear'

# ==============================
#   Customized hotkeys for Ruby
# ==============================
# Add more for your convenience
# You may quickly define a variable like r or l in REPL
# Then you lose these aliases, so take care!
alias :r :require
alias :l :load

### Copy to clipboard!

# ==============================
#   pbcopy
# ==============================
# Create command 'pbcopy' : Copy the last returned value in the Mac OS clipboard
# options : -m : Multiline copy
# Usage :
#         a => [1, 2, 3]
#         pbcopy
#         [1, 2, 3]
#         pbcopy -m
#          [
#           1,
#           2,
#           3,
#          ]
if RUBY_PLATFORM =~ /darwin/i # OSX only.
  # The pbcopy manual page for Mac OS X
  # http://goo.gl/o3nGsr
  def pbcopy(str, opts = {})
    IO.popen('pbcopy', 'r+') { |io| io.print str }
  end

  Pry.config.commands.command "pbcopy", "Copy last returned object to clipboard, -m for multiline copy" do

    multiline = arg_string == '-m'
    pbcopy _pry_.last_result.ai(:plain => true,
                                :indent => 2,
                                :index => false,
                                :multiline => multiline)
    output.puts "Copied #{multiline ? 'multilined' : ''}!"
  end

  Pry.config.commands.alias_command 'cp', 'pbcopy'
end

# ==============================
#   Rails
# ==============================

# Launch Pry with access to the entire Rails stack.
rails = File.join(Dir.getwd, 'config', 'environment.rb')
if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails
  case Rails.version.to_i
  when 2
    require 'console_app'
    require 'console_with_helpers'
  when 3
    require 'rails/console/app'
    require 'rails/console/helpers'
    extend Rails::ConsoleMethods if Rails.version.to_f >= 3.2
  else
    warn '[WARN] cannot load Rails console commands'
  end
end

# ==============================
#   Welcome to Pry
# ==============================
Pry.active_sessions = 0

Pry.config.hooks.add_hook(:before_session, :welcome) do
    if Pry.active_sessions.zero?
      puts "Hello #{___.user}! I'm Pry #{Pry::VERSION}."
      puts "I'm Loading Ruby #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} and everything else for you:"

      ### Fake Loading Progress bar
      # |====================>
      [*1..9].each do |e|
        print ___.pryrc_progress_bar e
        $stdout.flush
        sleep ___.pryrc_speed
      end

      # Print |==================> Load Completed!
      # 9 is to keep progress bar have the same length (see above each loop)
      print ___.pryrc_progress_bar 9, true

      puts ___.welcome_messages
    end
  Pry.active_sessions += 1
end

# ==============================
#   So long, farewell...
# ==============================
Pry.config.hooks.add_hook(:after_session, :farewell) do
  Pry.active_sessions -= 1
  if Pry.active_sessions.zero?
    if ___.true_true_or_false
      puts ___.farewell_messages
    else
      interpreted_time = ___.interpret_time(Time.now - pryrc_start_time)
      interpreted_time = 'ever' if interpreted_time == '0 second'
      puts "Hack with Ruby for #{interpreted_time}!"
    end
  end
end


# =============================
#  Custom stuff
# =============================

module Bcaudit
  module AuditInfo
    def self.current_ip
      "127.0.0.1"
    end
  end
end

#Sketches
begin
  require 'sketches'
  Sketches.config :editor => 'subl -w'
rescue LoadError => err
  puts "no sketches :("
end

#Benchmark
def bench_this(iterations=100, &block)
  require 'benchmark'
  Benchmark.bm{|b| b.report{iterations.times(&block)}}
end

# === CUSTOM COMMANDS ===
# from: https://gist.github.com/1297510
default_command_set = Pry::CommandSet.new do
  command "copy", "Copy argument to the clip-board" do |str|
     IO.popen('pbcopy', 'w') { |f| f << str.to_s }
  end

  command "ref" do
    ActionDispatch::Reloader.cleanup!
    ActionDispatch::Reloader.prepare!
  end

  command "clear" do
    system 'clear'
    if ENV['RAILS_ENV']
      output.puts "Rails Environment: " + ENV['RAILS_ENV']
    end
  end

  command "sql", "Send sql over AR." do |query|
    if ENV['RAILS_ENV'] || defined?(Rails)
      pp ActiveRecord::Base.connection.select_all(query)
    else
      pp "No rails env defined"
    end
  end
  command "caller_method" do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
      file   = Regexp.last_match[1]
      line   = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts [file, line, method]
    end
  end
end

Pry.config.commands.import default_command_set
