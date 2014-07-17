local hero
local inv = {}

function loadCharacter()
	hero = { x = 144, y = 144, speed = 100, health = 100, inventory = inv, equipped = nil }
	addToInventory("sword")
end

function transitionCharacter(x, y)
	hero.x = x
	hero.y = y
end

function mouseMoveCharacter(dt, x, y)
	local tempx = hero.x
	local tempy = hero.y
	local moveX  = ""
	local moveY = ""

	if (math.abs(x) > 5) then
		if math.abs(x) < 50 then
			modx = 0.3
		else
			modx = 1
		end

		if x > 0 then
			tempx = hero.x + (hero.speed * dt * modx)
			if checkTile(tempx, tempy) then
				hero.x = tempx
				moveX = "left"
			end
		end
		if x < 0 then 
			tempx = hero.x - (hero.speed * dt * modx)
			if checkTile(tempx, tempy) then
				hero.x = tempx
				moveX = "right"
			end
		end
	end

	if(math.abs(y) > 5) then
		if math.abs(y) < 50 then
			mody = 0.3
		else
			mody = 1
		end
		if y > 0 then 
			tempy = hero.y + (hero.speed * dt * mody)
			if checkTile(tempx, tempy) then
				hero.y = tempy
				moveY = "up"
			end
		end
		if y < 0 then 
			tempy = hero.y - (hero.speed * dt * mody)
			if checkTile(tempx, tempy) then
				hero.y = tempy
				moveY = "down"
			end
		end 
	end
	
	mouseMoveMap(dt, x, y, moveX, moveY)
end

function getLocation()
	-- body
	return hero.x, hero.y
end

function getSpeed()
	--body
	return hero.speed
end

function changeSpeed(change)
	-- adds 'change' to the hero's speed
	-- if change is negative, hero loses speed
	hero.speed = hero.speed + change
end

function changeHealth(change)
	-- adds 'change' to the hero's health
	-- if change is negative, hero loses health
	hero.health = hero.health + change
end

function getHealth()
	--body
	return hero.health
end

function addToInventory(item)
	--body
	hero.inventory[1] = item
end

function drawInventory()
	--body
	print(hero.inventory[1])
end

function moveCharacter(dt, x, y)
	local tempx = hero.x
	local tempy = hero.y
	local moveX = ""
	local moveY = ""

	if lm.isDown("l") then
		mouseMoveCharacter(dt, x, y)
		return
	end

	if lk.isDown("left") then
		tempx = hero.x - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
			moveX = "left"
		end
	elseif lk.isDown("right") then
		tempx = hero.x + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
			moveX = "right"
		end
	end
	
	if lk.isDown("up") then
		tempy = hero.y - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
			moveY = "up"
		end	
	elseif lk.isDown("down") then
		tempy = hero.y + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
			moveY = "down"
		end	
	end
	moveMap(dt, moveX, moveY)
end

function equipItem(item)
	-- adds item to hero's equipped slot
	if hero.inventory[1] ~= nil then
		print("equipping " .. item)
		hero.equipped = item
	end
end

function drawCharacter(characters)
	-- draw character
	lg.rectangle("fill", hero.x, hero.y, 32, 32)
	-- draw equipped item
	if hero.equipped ~= nil then
		-- later change the x and y to like, a hand
		drawItem(hero.equipped, hero.x, hero.y)
	end
end
