require 'active_support/all'

def display_audio
  system "~/.zsh/bin/AudioSwitcher -s 'Display Audio'"
  system "~/.zsh/bin/AudioSwitcher -t system  -s 'Display Audio'"
end

def usb_audio
  system "~/.zsh/bin/AudioSwitcher -s 'C-Media USB Audio Device   '"
  system "~/.zsh/bin/AudioSwitcher -t system -s 'C-Media USB Audio Device   '"
end

def audio?
  output = capture(:stdout) do
    system '~/.zsh/bin/AudioSwitcher -c'
  end
end

if audio? == "Display Audio\n"
  usb_audio
  system "terminal-notifier -message 'Moving to HEADPHONES 🎧' -title 'Audio Switch' -sender 'com.apple.systempreferences'"
else
  display_audio
  system "terminal-notifier -message 'Moving to SPEAKERS 🔊' -title 'Audio Switch' -sender 'com.apple.systempreferences'"
end

