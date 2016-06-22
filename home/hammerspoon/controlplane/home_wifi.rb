Dir["#{File.dirname(__FILE__)}/actions/*.rb"].each { |file| require_relative file }

omni_perspective('Home')
set_password_prompt 8400
internal_audio
home_printer
