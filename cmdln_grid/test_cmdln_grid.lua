--filename:
--test_cmdln_grid.lua
--date created:
--2015.06.02
--creator:
--[redacted]
--date modified:
--2015.06.02
--modifiers:
--[redacted]

--constants
line_topper = "123456789abcdefghijklmn"

function main()
	local test_line = ""
	for x = 1, #line_topper do
		test_line = test_line .. "."
	end
	for y = 1, 10 do
		queue_line(test_line)
	end
	display()
end

function clear()
	--windows
	os.execute("cls")
end

function pause()
	--windows
	os.execute("pause")
end

function display()
	clear()
	--calculate the amount of spaces needed
	local digits_in_line = getDigits(#to_display)
	print(string.rep(" ", digits_in_line + 1) .. line_topper)
	
	for x = 1, #to_display do
		print(x .. string.rep(" ", digits_in_line - getDigits(x) + 1) .. to_display[x])
	end
	to_display = {}
end

function getDigits(number)
	local digits = 1
	while number >= 10 do
		number = number / 10
		digits = digits + 1
	end
	return digits
end

function queue_line(line)
	table.insert(to_display, line)
end

to_display = {}
main()
pause()