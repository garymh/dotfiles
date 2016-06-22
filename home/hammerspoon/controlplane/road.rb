Dir["#{File.dirname(__FILE__)}/actions/*.rb"].each { |file| require_relative file }

omni_perspective 'Road'
internal_audio
set_password_prompt 1
`osascript -e "set Volume 0"`
