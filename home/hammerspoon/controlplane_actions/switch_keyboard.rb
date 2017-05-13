require 'json'

karabiner_dir = "#{ENV['HOME']}/.config/karabiner"
output        = "#{karabiner_dir}/karabiner.json"
json          = JSON.parse(File.read("#{karabiner_dir}/karabiner.json"))
profiles      = json["profiles"]
default       = profiles.find { |x| x['name'] == 'Default profile' }
desk          = profiles.find { |x| x['name'] == 'Desk profile' }

desk_active = "#{karabiner_dir}/desk_active"
internal_active = "#{karabiner_dir}/internal_active"

if ARGV[0] == "desk"
  default['selected'] = false
  desk['selected']    = true
  File.open(desk_active, 'w') { |file| file.write('') }
  File.delete(internal_active) if File.exist?(internal_active)
else
  default['selected'] = true
  desk['selected']    = false
  File.open(internal_active, 'w') { |file| file.write('') }
  File.delete(desk_active) if File.exist?(desk_active)
end

File.open(output, "w") {|file| file.puts JSON.dump(json) }
