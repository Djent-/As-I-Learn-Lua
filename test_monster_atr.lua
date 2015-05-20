--created 2015.05.20
--creator [redacted]
--modified 2015.05.20
--modifiers [redacted]

require("os")

monster = {}

function monster.new(attributes, name)
	local self = monster
	self.list = monster.list
	self.name = name
	self.attributes = attributes
	self.slots = {}
	return self
end

function monster.list(self)
	for k,v in next, self.attributes do
		print(k .. "=" .. self.attributes[k])
	end
end

function monster.totalAttributes(self)
	local atr = {attributes = {}}
	--cycle through the monster's stats
	for k, v in next, self.attributes do
		--cycle through the monster's slots
		for k2, v2 in next, self.slots do
			--cycle through each slot's attributes
			for k3, v3 in next, self.slots[k2].attributes do
				--if the slot has an attribute, add it to
				--the monster's base attribute
				if self.slots[k2][k] then
					atr.attributes[k] = v + v3
				end
			end
		end
	end
	--cycle through the monster's slots
	for k, v in next, self.slots do
		--cycle through each slot's attributes
		for k2, v2 in next, self.slots[k].attributes do
			--if the attribute is not present in the local count,
			--add it to the local count
			if not atr.attributes[k2] then
				atr.attributes[k2] = v2
			end
		end
	end
	
	--cycle through the monster's attributes
	for k, v in next, self.attributes do
		--if the attribute is not present in the local count
		--add it to the local count
		if not atr.attributes[k] then
			atr.attributes[k] = v
		end
	end
	
	return atr
end

function monster.equip(self, equipment)
	if not equipment then return end
	self.slots[equipment.slot] = equipment
end

ring = {}

--ring constructor
function ring.new(attributes, name)
	--extends equipable
	local self = equipable.new("ring")
	self.attributes = attributes
	self.name = name
	return self
end

equipable = {}
--constructor for the equipable class
function equipable.new(slot)
	local self = equipable
	self.slot = slot
	return self
end

--generic list for any object with an attributes table
function list(self)
	for k,v in next, self.attributes do
		print(k .. "=" .. self.attributes[k])
	end
end

state = {}
--state constructor
function state.new(name)
	local self = state
	self.name = name
	self.model = {}
	self.view = {}
	self.controller = {}
	return self
end

welcomescreen = state.new("Welcome")
welcomescreen.controller.start = function()
		welcomescreen.view.printwelcome()
	end
welcomescreen.view.printwelcome = function()
		print("Welcome to experiment #1")
		print("I am testing a new (to me) way of")
		print("handling states and iterating over")
		print("object attributes.")
	end

m1 = monster.new({str = 1, def = 2}, "M1")
monster.list(m1)
print()

r1 = ring.new({psnr = 2, cldr = 1, str = 3}, "R1")
m1:equip(r1)
a = m1:totalAttributes()
list(a)

os.execute("pause")