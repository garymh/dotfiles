#!/usr/bin/env ruby
# vi:syntax=ruby

require 'open-uri'
require 'base64'
require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'git'
  gem 'gitlab'
  gem 'pry'
  gem 'bitbar'
end

THE_PROJECT = 278_964
YA_BOI      = 142_752
GIT_DIR     = "#{ENV['HOME']}/code/work/gdk/gitlab/"
TMP_DIR    = "/tmp/gitlab"
git        = Git.open(Dir.new(GIT_DIR))
@branch     = git.current_branch

def update
  `source $PRIVATE_FILE`

  g           = Gitlab.client
  basic_scope = { scope: 'assigned_to_me', state: 'opened' }
  mrs         = g.merge_requests(THE_PROJECT, basic_scope)
  issues      = g.issues(THE_PROJECT, basic_scope)

  # binding.pry
  File.open("#{TMP_DIR}/MRs.json", "w")    { |f| f.write mrs.collect(&:to_hash).to_json }
  File.open("#{TMP_DIR}/issues.json", "w") { |f| f.write issues.collect(&:to_hash).to_json }
end

def needs_an_update?
  no_data? || old_data?
end

def old_data?
  File.ctime("/tmp/gitlab/MRs.json") < Time.now - 15 * 60
end

def no_data?
  if File.directory?("/tmp/gitlab") && File.exist?("/tmp/gitlab/MRs.json")
    false
  else
    Dir.mkdir("/tmp/gitlab")
    true
  end
end

return nil if @branch == 'master'

update if needs_an_update?
