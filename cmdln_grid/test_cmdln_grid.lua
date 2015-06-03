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
	local data = {}
	for y = 1, 10 do
		queue_line(test_line)
	end
	--write_file(to_display)
	display(read_file())
end

function clear()
	--windows
	os.execute("cls")
end

function pause()
	--windows
	os.execute("pause")
end

function display(table_data)
	local table_data = table_data or to_display
	clear()
	--calculate the amount of spaces needed
	local digits_in_line = getDigits(#table_data)
	print(string.rep(" ", digits_in_line + 1) .. line_topper)
	
	for x = 1, #table_data do
		print(x .. string.rep(" ", digits_in_line - getDigits(x) + 1) .. table_data[x])
	end
	table_data = {}
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

function read_file(filename)
	local filename = filename or "cmdln_grid.DATA"
	datafile = io.open(filename, "w")
	local data = {}
	for line in datafile:lines() do
		table.insert(data, line)
	end
	datafile:flush()
	datafile:close()
	return data
end

function write_file(data, filename)
	local filename = filename or "cmdln_grid.DATA"
	datafile = io.open(filename, "w+")
	local data = data
	for x = 1, #data do
		datafile:write(data[x] .. "\n")
	end
	datafile:flush()
	datafile:close()
end

to_display = {}
main()
pause()