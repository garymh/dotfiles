# require 'pry-rescue/rspec'
# require "super_diff/rspec-rails"

RSpec.configure do |config|
  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /bin\//,
    /gems/,
    /spec\/spec_helper\.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/
  ]
end

# require "luna/rspec/formatters/fulldesc"
