--date created: 2015.05.20
--creator: [redacted]
--date modified: 2015.05.20, 2015.05.21
--modifiers: [redacted]
--Written on Lua 5.1.4

require("os")
require("io")
require("string")

--this needs to go at the beginning of the file
--basic assert helper function
function check(var, vtype)
	if not var then error("Checked variable is nil or false.") end
	if not vtype then error("No type to check against " .. var) end
	if type(var) ~= vtype then
		error(var .. " is not of type " .. vtype)
	end
	return var
end

--open or create file
datafile = io.open("DATA.DATA", "r")

--assemble data table from file
data = {}
--iterate over lines in datafile
tdatatable = {filename = nil, attributes = {}} --temporary data table
for line in datafile:lines() do
	--don't know how I will store the data within the file
	--if the line contains the filename
	if string.match(line, "^FILENAME") then
		local s, e = string.find(line, "^FILENAME")
		tdatatable.filename = string.sub(line, e + 1)
		
		--debug
		--print("Added " .. tdatatable.filename)
	end
	--if the line contains an attribute
	if string.match(line, "^ATTRIBUTE") then
		local s, e = string.find(line, "^ATTRIBUTE")
		table.insert(tdatatable.attributes, string.sub(line, e + 1))
	end
	--denote the end of the file attributes and move to the
	--next file
	if string.match(line, "^NEXT") then
		table.insert(data, tdatatable)
		tdatatable = {filename = nil, attributes = {}}
		
		--debug
		--print("#data: " .. #data)
	end
end

--close the datafile for now
--will open again to write data
datafile:flush()
datafile:close()

--parse command-line argument
validargs = {}
--start tracking a file
validargs.track = function(filename)
		arg2 = filename or arg[2]
		--check if the first argument is a string (filename)
		check(arg2, "string")
		--check to see if the file is already being trackedlocal found = false
		for x = 1, #data do
			if data[x].filename == arg2 then
				print(arg2 .. " is already being tracked.")
			end
		end
		--add the file to the data table
		table.insert(data, {filename = arg[2], attributes = {}})
		
		--debug
		--print("Tracked " .. arg2 .. " successfully")
	end
--stop tracking a file
validargs.untrack = function()
		--check if the first argument is a string (filename)
		check(arg[2], "string")
		--look for the file to be untracked
		for i = 1, #data do
			if data[i].filename == arg[2] then
				data:remove(i)
			end
		end
	end
--assign attributes to a file
validargs.assign = function()
		--check if the first argument is a string (filename)
		check(arg[2], "string")
		--see if the file is being tracked
		local found = false
		for x = 1, #data do
			if data[x].filename == arg[2] then
				found = x
				break
			end
		end
		--check whether the file is being tracked
		--if not found then error("File " .. arg[2] .. " is not being tracked.")
		--if the file is not being tracked, then track the file
		if not found then
			validargs.track()
		end
		found = found or #data
		--go through and add the remaining arguments to attributes
		--arg starts at [-1], so I don't know if the # operator will work
		for x = 3, #arg do
			check(arg[x], "string")
			--iterate through the file's attributes to see if the attribute
			--already is assigned
			local alreadyassigned = false
			for y = 1, #data[found].attributes do
				if data[found].attributes[y] == arg[x] then
					--attribute already is assigned
					alreadyassigned = true
				end
			end
			if not alreadyassigned then
				table.insert(data[found].attributes, arg[x])
			end
		end
	end
--list the file's attributes
validargs.display = function()
		--check if the first argument is a string (filename)
		check(arg[2], "string")
		--see if the file is being tracked
		local found = false
		for x = 1, #data do
			if data[x].filename == arg[2] then
				found = x
				break
			end
		end
		--loop through the attributes and print them
		--this may need to be changed for easier access
			--piping into other programs
		if not found then print(arg[2] .. " is not being tracked.") end
		for x = 1, #data[found].attributes do
			print(data[found].filename, data[found].attributes[x])
		end
	end
validargs.clear = function()
		data = {}
	end

--parse the commandline arguments
if not arg[1] then
	print("Command was not supplied")
	os.exit()
end
argfound = false
for k, v in next, validargs do
	if arg[1] == k then
		--run the command
		validargs[k]()
		argfound = true
		break
	end
end
--if the user did not supply a valid argument
if not argfound then
	print(arg[1] .. " is not a valid command.")
	os.exit()
end
	
--write data table to file
datafile = io.open("DATA.DATA", "w+")
--iterate over the data
for x = 1, #data do
	datafile:write("FILENAME" .. data[x].filename .. "\n")
	for y = 1, #data[x].attributes do
		datafile:write("ATTRIBUTE" .. data[x].attributes[y] .. "\n")
	end
	datafile:write("NEXT\n")
end

--close file
datafile:flush()
datafile:close()