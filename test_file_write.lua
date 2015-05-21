require("io")

f = io.open("t.test", "w+")
f:write("Line 1")
f:write("Line 2")
f:write("Line 3\n")
f:write("Line 4")
f:close()