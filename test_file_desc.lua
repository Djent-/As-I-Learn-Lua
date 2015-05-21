--TODO: check to see if the file is already being tracked

--open or create file

--assemble data table from file
data = {}

--parse command-line argument
validargs = {}
validargs.track = function(filename)
		arg2 = filename or arg[2]
		--check if the first argument is a string (filename)
		check(arg[2], "string")
		--TODO: check to see if the file is already being tracked
		--add the file to the data table
		data.append({filename = arg[2], attributes = {}})
	end
validargs.untrack = function()
		--check if the first argument is a string (filename)
		check(arg[2], "string")
		--look for the file to be untracked
		for i = 1, #data do
			if data[i].filename = arg[2] then
				data:remove(i)
			end
		end
	end
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
		validargs.track()
		--go through and add the remaining arguments to attributes
		--arg starts at [-1], so I don't know if the # operator will work
		for x = 3, #arg do
			check(arg[x], "string")
			
		end
	end
--list the file's attributes
validargs.display = function()
		
	end

--parse the commandline arguments
if not arg[1] then
	error("Command was not supplied")
end
argfound = false
for k, v in next, validargs do
	if arg[1] = k then
		--run the command
		validargs[k]()
		argfound = true
		break
	end
end
--if the user did not supply a valid argument
if not argfound then
	error(arg[1] .. " is not a valid command.")
end
	
--write data table to file

--basic assert helper function
function check(var, vtype)
	if not var then error("Checked variable is nil or false.") end
	check(vtype, "string")
	if type(var) ~= vtype then
		error(var .. " is not of type " .. vtype)
	end
	return
end