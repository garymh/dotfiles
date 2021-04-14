#!/usr/bin/env ruby
# vi:syntax=ruby

require 'open-uri'
require 'base64'
require 'bundler/inline'
require 'pry'

gemfile do
  source 'https://rubygems.org'
  gem 'gitlab'
end

THE_PROJECT = 278_964
YA_BOI      = 142_752
GIT_DIR     = "#{ENV['HOME']}/code/work/gdk/gitlab".freeze
TMP_DIR     = "/tmp/gitlab".freeze
MAIN_BRANCH = "master"
@branch     = File.open("#{GIT_DIR}/.git/HEAD").read
                  .gsub("ref: refs/heads/", "")
                  .delete("\n")

def update
  g           = Gitlab.client
  basic_scope = { scope: 'assigned_to_me', state: 'opened' }
  mrs         = g.merge_requests(THE_PROJECT, basic_scope)
  issues      = g.issues(THE_PROJECT, basic_scope)

  File.open("#{TMP_DIR}/MRs.json", "w")    { |f| f.write jsonify(mrs) }
  File.open("#{TMP_DIR}/issues.json", "w") { |f| f.write jsonify(issues) }
end

def jsonify(thing)
  thing.map(&:to_hash).to_json
end

def needs_an_update?
  no_data? || old_data?
end

def old_data?
  File.ctime("/tmp/gitlab/MRs.json") < Time.now - 15 * 60
  # if not updated in
  # the last 15 minutes
end

def no_data?
  File.exist?("#{TMP_DIR}/MRs.json") ? false : true
end

def on_default_branch?
  @branch == MAIN_BRANCH
end

unless on_default_branch?
  Dir.mkdir(TMP_DIR) unless File.directory?(TMP_DIR)

  update if needs_an_update?
end
