Dir["#{File.dirname(__FILE__)}/actions/*.rb"].each {|file| require_relative file }

dock_hiding(true)
omni_perspective("Road")
internal_audio
set_password_prompt 60
