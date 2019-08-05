-- Archive behaviour found at: http://vemedio.com/blog/posts/my-archive-email-apple-script
on run argv
	tell application "Mail"
		set theSelectedMessages to selection
		set the selected_message to item 1 of the theSelectedMessages
		set message_id to the message id of the selected_message
		set my_subject to the subject of the selected_message

		set message_url to "message://%3c" & message_id & "%3e"

		set _mb to mailbox of selected_message
		set _acct to account of _mb
		set _archive_box to _acct's mailbox "Archive"

		--CREATE IN OMNIFOCUS
		tell front document of application "OmniFocus"
			-- tell quick entry
			-- 	make new inbox task with properties {name:my_subject, note:message_url}
			-- 	open
			-- end tell
			if argv is {"nodialog"} then
				set emailTag to first flattened tag where its name is "email"
				set my_title to "Email: " & my_subject
				set the_task to make new inbox task with properties {name:my_title, note:message_url}
				add emailTag to tags of the_task
			else
				tell quick entry
					make new inbox task with properties {name:my_subject, note:message_url}
					open
				end tell
			end if
			display notification "Successfully Exported message '" & my_subject & "' to OmniFocus" with title "Send Mail Message to OmniFocus"
		end tell
	end tell
end run
