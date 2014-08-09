function updateCharacters(dt, x, y)
	moveHero(dt, x, y)
	moveMobs(dt)
end

function checkCharacters()
	local collided = false
	local collision = 0

	collided, collision = checkCollisionsTable(hero, mobTable)

	if collided then
		changeHealth(hero, (-getAttack(mobTable[collision])))
	end

	checkCharactersHealth()
end

function checkCharactersHealth()
	local deadMob = {}
	if getHealth(hero) <= 0 then
		-- draw game over screen
		print("You died!")
	end	

	if #mobTable > 0 then
		for i=1, #mobTable do
			if getHealth(mobTable[i]) <= 0 then
				table.insert(deadMob, i)
			end
		end

		for j=#deadMob, 1, -1 do
			table.remove(mobTable, deadMob[j])
		end
	end
end

function checkCollision(param, param2)
	loc1 = getLocation(param)
	size1 = getSize(param)
	loc2 = getLocation(param2)
	size2 = getSize(param2)

	return loc2.x < loc1.x + size1.width and
			loc1.x < loc2.x + size2.width and
			loc2.y < loc1.y + size1.height and
			loc1.y < loc2.y + size2.height
end

function checkCollisionsTable(param, table)
	local result = false
	
	for i=1, #table do
		loc1 = getLocation(param)
		size1 = getSize(param)
		loc2 = getLocation(table[i])
		size2 = getSize(table[i])

		result = loc2.x < loc1.x + size1.width and
				loc1.x < loc2.x + size2.width and
				loc2.y < loc1.y + size1.height and
				loc1.y < loc2.y + size2.height or result
		
		if result then
			return result, i
		end
	end

	return result, 0 
end

function drawCharacters()
	local tempLoc = getLocation(hero)
	drawHero()
	drawMobs()
	if (getEquipped(hero) ~= nil) then
		animateEquipped(tempLoc.x, tempLoc.y)
	end
end
