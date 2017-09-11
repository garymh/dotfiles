require 'json'

karabiner_dir   = "#{ENV['HOME']}/.config/karabiner"
desk_active     = "#{karabiner_dir}/desk_active"
internal_active = "#{karabiner_dir}/internal_active"
cli = "\"/Library/Application\ Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli\""

if ARGV[0] == "desk"
  system(cli + " --select-profile 'Desk profile'")
  File.open(desk_active, 'w') { |file| file.write('') }
  File.delete(internal_active) if File.exist?(internal_active)
else
  system(cli + " --select-profile 'Default profile'")
  File.open(internal_active, 'w') { |file| file.write('') }
  File.delete(desk_active) if File.exist?(desk_active)
end
