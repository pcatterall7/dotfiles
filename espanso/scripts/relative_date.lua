function getRelativeDate(cmdString)
	local dayMap = {
		sun=1,
		mon=2,
		tue=3,
		wed=4,
		thu=5,
		fri=6,
		sat=7
	}
	local today = os.time()
	local todayDayOfWeek = os.date("*t", today).wday
	local isLastWeek = false

	if string.sub(cmdString, 2, 2) == "l" then
		isLastWeek = true
	end

	if not isLastWeek then
		local dayOfWeekStr = string.sub(cmdString, 2, 5)
		local dayOfWeek = dayMap[dayOfWeekStr]
		diff = dayOfWeek - todayDayOfWeek
		if dayOfWeek < todayDayOfWeek then
			diff = diff + 7
		end
	else
		local dayOfWeekStr = string.sub(cmdString, 3, 6) -- TODO: split this out
		local dayOfWeek = dayMap[dayOfWeekStr]
		diff = dayOfWeek - todayDayOfWeek
		if dayOfWeek > todayDayOfWeek then
			diff = diff - 7
		end
	end


	
	local targetDate = today + (60 * 60 * 24 * diff)
	return os.date("%Y-%m-%d", targetDate)
	
end

local arg = {...}
print(getRelativeDate(arg[1]))