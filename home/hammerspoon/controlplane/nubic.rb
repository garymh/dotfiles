Dir["#{File.dirname(__FILE__)}/actions/*.rb"].each { |file| require_relative file }

omni_perspective('Work')
internal_audio
