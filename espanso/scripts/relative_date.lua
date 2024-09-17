function getRelativeDate(dayOfWeekStr, isLastWeek)
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
	local isLastWeek = isLastWeek or false
	local dayOfWeek = dayMap[dayOfWeekStr]
	local diff = dayOfWeek - todayDayOfWeek
	-- adjust for days in the previous or next week
	if isLastWeek and dayOfWeek >= todayDayOfWeek then
		diff = diff - 7
	elseif not isLastWeek and dayOfWeek <= todayDayOfWeek then
		diff = diff + 7
	end

	local targetDate = today + (60 * 60 * 24 * diff)
	return os.date("%Y-%m-%d", targetDate)
	
end

local args = {...}
if string.sub(args[1], 1, 1) == "l" then
	isLastWeek = true
	day = string.sub(args[1], 2, 4)
else
	isLastWeek = false
	day = string.sub(args[1], 1, 3)
end
print(getRelativeDate(day, isLastWeek))