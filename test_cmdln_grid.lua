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
	test_line = ""
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
	os.execute("pause")
end

function display()
	clear()
	--calculate the amount of spaces needed
	z = 1
	num = #to_display
	while num > 10 do
		num = num / 10
		z = z + 1
	end
	print(line_topper)
	for x = 1, #to_display do
		print(x .. " " .. to_display[x])
	end
	to_display = {}
end

function queue_line(line)
	table.insert(to_display, line)
end

to_display = {}
main()
pause()