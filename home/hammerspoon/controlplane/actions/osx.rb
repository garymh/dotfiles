def dock_hiding value
  system "defaults write com.apple.dock autohide -boolean #{value} && killall Dock"
end

def app_is_running? app_name
  `ps aux` =~ /#{app_name}/ ? true : false
end

def set_password_prompt time
  system "defaults write com.apple.screensaver askForPasswordDelay -int #{time}"
end

def quit app_name
  system "osascript -e 'tell application \"#{app_name}\" to quit'"
end

def wifi status
  system "networksetup -setairportpower en0 #{status}"
end

def remove_item
  system "/usr/libexec/PlistBuddy -c 'Delete :menuExtras:1' ~/Library/Preferences/com.apple.systemuiserver.plist"
end

def set_wallpaper file
  system "osascript -e 'tell application \"Finder\" to set desktop picture to POSIX file \"#{ENV['HOME']}/iCloud/Wallpapers/#{file}\"'"
end

def display_audio
  system "~/.zsh/bin/AudioSwitcher -s 'Display Audio'"
  system "~/.zsh/bin/AudioSwitcher -t system  -s 'Display Audio'"
end

def podcast_audio
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
  system "~/.zsh/bin/AudioSwitcher -s 'USB PnP Sound Device'"
  system "~/.zsh/bin/AudioSwitcher -t system -s 'USB PnP Sound Device'"
end
