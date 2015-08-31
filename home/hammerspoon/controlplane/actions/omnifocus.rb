def omni_perspective(perspective)
  system "osascript -e 'tell application \"OmniFocus\" to tell the default document to tell the front document window to set perspective name to \"#{perspective}\"'"
  puts "Changing Omnifocus perspective to #{perspective}"
end
