Dir["#{File.dirname(__FILE__)}/actions/*.rb"].each { |file| require_relative file }

require 'pry'

binding.pry
