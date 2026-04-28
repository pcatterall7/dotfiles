-- Things 3 Stale Todo Cleanup
--
-- Automatically manages stale todos in Things 3 by tagging and eventually canceling
-- todos that have been sitting without a project for too long.
--
-- HOW IT WORKS:
-- 1. Finds incomplete todos in Anytime/Someday older than 30 days (NOT in any project)
-- 2. Adds "expiring-soon" tag and appends "expiry-tagged: YYYY-MM-DD" to notes
-- 3. After 7 more days, cancels the todo
--
-- SETUP:
--   launchctl load ~/Library/LaunchAgents/com.user.things-cleanup.plist
--   launchctl list | grep things-cleanup  # verify it's loaded
--
-- USAGE:
--   Runs automatically daily at 9:00 AM via launchd
--   Manual test: osascript ~/bin/things-cleanup.applescript
--   Force run now: launchctl start com.user.things-cleanup
--   View logs: tail -f ~/Library/Logs/things-cleanup-error.log
--
-- CONFIGURATION:
--   Edit daysBeforeTagging and daysBeforeCancelling properties below
--   Modify schedule in ~/Library/LaunchAgents/com.user.things-cleanup.plist
--
-- UNINSTALL:
--   launchctl unload ~/Library/LaunchAgents/com.user.things-cleanup.plist
--   rm ~/Library/LaunchAgents/com.user.things-cleanup.plist
--   rm ~/bin/things-cleanup.applescript

use AppleScript version "2.4"
use scripting additions

-- Configuration
property daysBeforeTagging : 30
property daysBeforeCancelling : 7
property expiringTag : "expiring-soon"
property expiryMarker : "expiry-tagged: "

-- Get today's date in YYYY-MM-DD format
on getTodayString()
	set today to current date
	set y to year of today as string
	set m to text -2 thru -1 of ("0" & (month of today as integer))
	set d to text -2 thru -1 of ("0" & (day of today as integer))
	return y & "-" & m & "-" & d
end getTodayString

-- Parse date from expiry-tagged: YYYY-MM-DD in notes
on getExpiryDate(noteText)
	if noteText is missing value then return missing value

	set AppleScript's text item delimiters to expiryMarker
	set textItems to text items of noteText

	if (count of textItems) < 2 then
		return missing value
	end if

	-- Extract the date portion (YYYY-MM-DD) after the marker
	set dateString to text item 2 of textItems
	set AppleScript's text item delimiters to {return, linefeed, space, tab}
	set dateParts to text items of dateString
	set dateString to text item 1 of dateParts -- First part before any whitespace

	set AppleScript's text item delimiters to ""

	-- Parse YYYY-MM-DD
	if length of dateString < 10 then return missing value

	try
		set y to text 1 thru 4 of dateString as integer
		set m to text 6 thru 7 of dateString as integer
		set d to text 9 thru 10 of dateString as integer

		set expiryDate to current date
		set year of expiryDate to y
		set month of expiryDate to m
		set day of expiryDate to d
		set time of expiryDate to 0

		return expiryDate
	on error
		return missing value
	end try
end getExpiryDate

-- Calculate days between two dates
on daysBetween(startDate, endDate)
	return (endDate - startDate) / days
end daysBetween

-- Process a single todo
on processTodo(theTodo)
	tell application "Things3"
		-- Skip if already completed or cancelled
		if status of theTodo is not open then
			return
		end if

		-- Check if todo is in a project (skip if it is)
		try
			if project of theTodo is not missing value then
				return
			end if
		end try

		-- Get todo age
		set creationDate to creation date of theTodo
		set today to current date
		set age to my daysBetween(creationDate, today)

		-- Only process if older than threshold
		if age < daysBeforeTagging then
			return
		end if

		-- Get current tags and notes
		set todoTags to tag names of theTodo
		set todoNotes to notes of theTodo

		-- Check if already has expiring tag
		set hasExpiringTag to false
		if todoTags contains expiringTag then
			set hasExpiringTag to true
		end if

		if hasExpiringTag then
			-- Check if should be cancelled
			set expiryDate to my getExpiryDate(todoNotes)

			if expiryDate is not missing value then
				set daysSinceTagged to my daysBetween(expiryDate, today)

				if daysSinceTagged ≥ daysBeforeCancelling then
					-- Cancel the todo
					set status of theTodo to canceled
					log "Cancelled: " & name of theTodo & " (tagged " & (daysSinceTagged as integer) & " days ago)"
				end if
			end if
		else
			-- Add expiring tag and date to notes
			if todoNotes is missing value then
				set todoNotes to ""
			end if

			set todayString to my getTodayString()
			set expiryNote to expiryMarker & todayString

			-- Check if marker already exists (shouldn't happen, but be safe)
			if todoNotes does not contain expiryMarker then
				if todoNotes is "" then
					set notes of theTodo to expiryNote
				else
					set notes of theTodo to todoNotes & return & return & expiryNote
				end if

				-- Add the tag
				set tag names of theTodo to todoTags & {expiringTag}

				log "Tagged: " & name of theTodo
			end if
		end if
	end tell
end processTodo

-- Main execution
try
	-- Check if Things 3 is installed
	tell application "System Events"
		if not (exists application process "Things3") then
			-- Launch Things 3 in background
			tell application "Things3"
				launch
				delay 2 -- Give it time to start
			end tell
		end if
	end tell

	tell application "Things3"
		log "Starting Things 3 cleanup at " & (current date) as string

		set processedCount to 0
		set taggedCount to 0
		set cancelledCount to 0

		-- Process Anytime list
		try
			set anytimeTodos to to dos of list "Anytime"
			repeat with theTodo in anytimeTodos
				my processTodo(theTodo)
				set processedCount to processedCount + 1
			end repeat
		end try

		-- Process Someday list
		try
			set somedayTodos to to dos of list "Someday"
			repeat with theTodo in somedayTodos
				my processTodo(theTodo)
				set processedCount to processedCount + 1
			end repeat
		end try

		log "Finished processing " & processedCount & " todos"
	end tell

	return "Success"

on error errMsg number errNum
	log "Error: " & errMsg & " (" & errNum & ")"
	return "Error: " & errMsg
end try
