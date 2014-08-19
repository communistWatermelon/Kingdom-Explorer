path = "items/drops/"

function generateDropType(hpChance, mChance, cChance)
	-- generate a random number. use that number to figure out if something is dropped
	-- use the Chance modifiers to change how likely it is for that item to be dropped
	local tempClass, tempH, tempM, tempC

	if hpChance + mChance + cChance > 100 then
		print("bad chances!")
	end

	--love.math.setRandomSeed(os.time())
	local rand = love.math.random(0, 100)

	tempH = hpChance
	tempM = hpChance + mChance
	tempC = hpChance +  mChance + cChance

	if rand <= tempH then
		return "health"
	elseif rand > tempH and rand <= tempM then
		return "magic"
	elseif rand > tempM and rand <= tempC then 
		return "cash"
	else 
		return nil
	end
end

function generateDropfromParam(param)
	-- a wrapper for generate drop, that lets you pass in what is dropping an item instead of passing
	--	in the chances directly
	print("not yet implemented!")
end

function placeDrop(item, x, y)
	local tempAmount = love.math.random(1, 100)

	-- places the drop on the map
	if item == nil then
		return
	end

	table.insert(dropsTable, { 
					class = item,
					location = { x = x , y = y},
					draw = { sprite = lg.newImage(path .. item .. ".png") },
					size = { width = 32, height = 32},
					alive = true,
					amount = math.floor(tempAmount)
				})
end

function checkDrops(deadDrops)
	for i=1, #dropsTable do
		if not dropsTable[i].alive then
			table.insert(deadDrops, i)
		end
	end

	for j=#deadDrops, 1, -1 do
		table.remove(dropsTable, deadDrops[j])
	end
end

function updateDrops()
	local collided = false
	local collision = 0
	local deadDrops = {}

	collided, collision = checkCollisionsTable(hero, dropsTable)

	if collided then
		table.insert(deadDrops, collision)
		useDrop(collision)
		checkDrops(deadDrops)
	end
end

function useDrop(number)
	local tempDrop = dropsTable[number]
	local tempClass = getClass(tempDrop)

	if tempClass == "health" then
		changeHealth(hero, tempDrop.amount)
	elseif tempClass == "magic" then
		print("changing magic is not yet implemented!")
	elseif tempClass == "cash" then
		changeCash(tempDrop.amount)
	end

	tempDrop.alive = false
end

function drop(x, y, param, hpChance, mChance, cChance)
	-- the function that will call all others, for simplicity
	local item

	if param ~= nil then
		item = generateDropfromParam(param)
	else
		item = generateDropType(hpChance, mChance, cChance)
	end

	placeDrop(item, x, y)
end

function drawDrops()
	for i=1, #dropsTable do
		lg.draw( getAnim(dropsTable[i], "sprite"), 
			getX(dropsTable[i]), getY(dropsTable[i]), 0, 1, 1, 
			getWidth(dropsTable[i])/2, getHeight(dropsTable[i])/2)
	end
end