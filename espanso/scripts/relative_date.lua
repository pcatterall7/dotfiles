function getRelativeDate(dayOfWeekStr, isLastWeek)
	local dayMap = {
		sun = 1,
		mon = 2,
		tue = 3,
		wed = 4,
		thu = 5,
		fri = 6,
		sat = 7,
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

local args = { ... }
local input = args[1]
if input == "yest" then
	local yesterday = os.time() - (24 * 60 * 60)
	print(os.date("%Y-%m-%d", yesterday))
elseif input == "tom" then
	local tomorrow = os.time() + (24 * 60 * 60)
	print(os.date("%Y-%m-%d", tomorrow))
else
	local isLastWeek = string.sub(input, 1, 1) == "l"
	local day = string.sub(input, isLastWeek and 2 or 1, isLastWeek and 4 or 3)
	print(getRelativeDate(day, isLastWeek))
end
