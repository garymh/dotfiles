dockutil --remove all
dockutil --add "/Applications/Safari.app"
dockutil --add "/Applications/Firefox.app"
dockutil --add "/Applications/Firefox Developer Edition.app"
dockutil --add "/System/Applications/Mail.app"
dockutil --add "/Applications/Mailspring.app"
dockutil --add '' --type spacer --section apps --after Mailspring
dockutil --add "/System/Applications/Messages.app"
dockutil --add "/Applications/kitty.app"
dockutil --add "/Applications/OmniFocus.app"
dockutil --add "/Applications/Discord.app"
dockutil --add "/Applications/Slack.app"
dockutil --add "/System/Applications/Calendar.app"
dockutil --add '' --type spacer --section apps --after Calendar
dockutil --add "/Applications/System Settings.app"
dockutil --add "$HOME/Downloads" --view list --display folder --sort name
