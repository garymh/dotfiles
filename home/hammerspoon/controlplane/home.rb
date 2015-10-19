Dir["#{File.dirname(__FILE__)}/actions/*.rb"].each {|file| require_relative file }

dock_hiding(true)
omni_perspective("Home")
internal_audio
home_printer
set_password_prompt 3600
