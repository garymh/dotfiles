Dir["#{File.dirname(__FILE__)}/actions/*.rb"].each {|file| require_relative file }

dock_hiding(false)
omni_perspective("Work")
internal_audio
set_password_prompt 60
