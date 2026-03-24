on run argv
	set openQuickEntry to (count of argv) = 0
	
	set ofLib to load script POSIX file (POSIX path of (path to home folder) & ".hammerspoon/scripts/of_library.scpt")
	
	tell application "Mail"
		set sel to selection
		if sel is {} then error "No message selected"
		set theMessage to item 1 of sel
		set theSubject to subject of theMessage
		set theLink to "message://%3C" & (message id of theMessage) & "%3E"
		--		set tabURL to URL of current tab of front window
		--		set tabTitle to name of current tab of front window
	end tell
	
	set itemTag to "tech"
	
	ofLib's addOfTask(theSubject, theLink, itemTag, openQuickEntry)
end run