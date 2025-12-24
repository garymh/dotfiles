dockutil --remove all
dockutil --add "/Applications/Safari.app"
dockutil --add "/Applications/Firefox.app"
dockutil --add "/Applications/Firefox Developer Edition.app"
dockutil --add '' --type spacer --section apps --after "Firefox Developer Edition"
dockutil --add "/System/Applications/Mail.app"
dockutil --add "/System/Applications/Messages.app"
dockutil --add '' --type spacer --section apps --after Messages
dockutil --add "/Applications/Ghostty.app"
dockutil --add "/Applications/OmniFocus.app"
dockutil --add "/Applications/Discord.app"
dockutil --add "/Applications/Slack.app"
dockutil --add '' --type spacer --section apps --after Slack
dockutil --add "$HOME/Applications/Gmail.app"
dockutil --add "/Applications/BusyCal.app"
dockutil --add "/Applications/System Settings.app"
dockutil --add "$HOME/Downloads/Personal Folder/Downloads" --view list --display folder --sort name
