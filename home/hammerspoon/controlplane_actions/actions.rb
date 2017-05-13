require 'json'

def terminal_notifier message
  app = "/usr/local/bin/terminal-notifier"
  system "#{app} -message \"#{message}\""
end

def dock_hiding value
  system "defaults write com.apple.dock autohide -boolean #{value} && killall Dock"
end

def set_password_prompt time
  system "defaults write com.apple.screensaver askForPasswordDelay -int #{time}"
end

def set_wallpaper file
  system "osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"#{ENV['HOME']}/iCloud/Wallpapers/#{file}\"'"
end

def stock_wallpaper
  system "osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"#{ENV['HOME']}/iCloud/wallpaper.png\"'"
end

def vpn_wallpaper
  system "~/.zsh/bin/vpn_wallpaper"
end

def display_audio
  system "~/.zsh/bin/AudioSwitcher -s 'Display Audio'"
  system "~/.zsh/bin/AudioSwitcher -t system  -s 'Display Audio'"
end

def recording_audio
  system "~/.zsh/bin/AudioSwitcher -s 'BLUE NESSIE USB MIC'"
  system "~/.zsh/bin/AudioSwitcher -t system  -s 'BLUE NESSIE USB MIC'"
  system "~/.zsh/bin/AudioSwitcher -t input  -s 'BLUE NESSIE USB MIC'"
end

def usb_audio_676
  system "~/.zsh/bin/AudioSwitcher -s 'iMic USB audio system'"
  system "~/.zsh/bin/AudioSwitcher -t system  -s 'iMic USB audio system'"
end

def internal_audio
  system "~/.zsh/bin/AudioSwitcher -s 'Built-in Output'"
  system "~/.zsh/bin/AudioSwitcher -t system  -s 'Built-in Output'"
end

def usb_audio
  system "~/.zsh/bin/AudioSwitcher -s 'C-Media USB Audio Device   '"
  system "~/.zsh/bin/AudioSwitcher -t system -s 'C-Media USB Audio Device   '"
end

def omni_perspective perspective
  system "osascript -e 'tell application \"OmniFocus\" to tell the default document to tell the front document window to set perspective name to \"#{perspective}\"'"
  puts "Changing Omnifocus perspective to #{perspective}"
end

def home_printer
  system 'lpoptions -d Brother_HL_2170W_series___Oracle'
end

def rhlccc_printer
  system 'lpoptions -d _165_124_121_95'
end

def dvorak_printer
  system 'lpoptions -d Brother_HL_2270DW_series___The_Dvorak_Family_iMac'
end
