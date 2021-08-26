#!/usr/bin/env ruby
# vi:syntax=ruby

# require 'open-uri'
# require 'base64'
require 'bundler/inline'
require 'pry'

# if REQUIREMENTS
#   REQUIREMENTS.each do |file|
#     require_relative "../gl_bin/#{file}"
#   end
# else
  require_relative "../gl_bin/globject"
  require_relative "../gl_bin/merge_request"
  require_relative "../gl_bin/issue"
  require_relative "../gl_bin/pipeline"
  require_relative "../gl_bin/updater"
# end

gemfile do
  source 'https://rubygems.org'
  gem 'gitlab'
  gem 'markdown-tables'
  gem "pastel"
  gem "tty"
  gem 'tty-box'
  gem 'tty-config'
  gem 'tty-cursor'
  gem 'tty-prompt'
  gem 'tty-table'
end

GIT_DIR = "#{ENV['HOME']}/code/work/gdk/gitlab".freeze
USERNAME = "garyh".freeze
MAIN_BRANCH = "master".freeze
@branch = File.open("#{GIT_DIR}/.git/HEAD").read
              .gsub("ref: refs/heads/", "")
              .delete("\n")

def on_default_branch?
  @branch == MAIN_BRANCH
end
