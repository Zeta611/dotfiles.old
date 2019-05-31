on open of input
	set filename to POSIX path of input
	set cmd to "clear;cd `dirname " & filename & "`;nvim " & filename
	tell application "iTerm"
		tell the current window
			create window with default profile
			tell the current session
				write text cmd
			end tell
		end tell
	end tell
end open


