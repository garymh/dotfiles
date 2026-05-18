dockutil --remove all
dockutil --add "/Applications/Safari.app"
dockutil --add "/Applications/Helium.app"
dockutil --add '' --type spacer --section apps --after "Helium"
dockutil --add "/System/Applications/Mail.app"
dockutil --add "/System/Applications/Messages.app"
dockutil --add '' --type spacer --section apps --after Messages
dockutil --add "/Applications/Ghostty.app"
dockutil --add "/Applications/OmniFocus.app"
dockutil --add "/Applications/Discord.app"
dockutil --add "/Applications/Slack.app"
dockutil --add '' --type spacer --section apps --after Slack
dockutil --add "$HOME/Applications/Gmail.app"
dockutil --add "/Applications/Calendar.app"
dockutil --add "/Applications/System Settings.app"
dockutil --add "$HOME/Downloads/Personal Folder/Downloads" --view list --display folder --sort name
