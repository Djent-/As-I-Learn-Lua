
--open or create file

--assemble data table from file
data = {}

--parse command-line argument
validargs = {}
validargs.track = function()
		--check if the first argument is a string (filename)
		check(arg[2], "string")
		data.append({filename = arg[2], attributes = {}})
	end
validargs.untrack = function()
		
	end
validargs.assign = function()
		
	end
validargs.display = function()
		
	end

for k, v in next, validargs do
	if arg[1] = k then
		validargs[k]()
	end
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