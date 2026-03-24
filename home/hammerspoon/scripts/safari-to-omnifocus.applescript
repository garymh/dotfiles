on run argv
	set openQuickEntry to (count of argv) = 0
	
	set ofLib to load script POSIX file (POSIX path of (path to home folder) & ".hammerspoon/scripts/of_library.scpt")
	
	tell application "Safari"
		set tabURL to URL of current tab of front window
		set tabTitle to name of current tab of front window
	end tell
	
	set itemTag to "to read"
	
	ofLib's addOfTask(tabURL, tabTitle, itemTag, openQuickEntry)
end run