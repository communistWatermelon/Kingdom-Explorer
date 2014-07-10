local hero
local inv = {}

function loadCharacter()
	hero = { x = 500, y = 32, speed = 100, inventory = inv, equipped = nil }
	addToInventory("butts")
end

function transitionCharacter(x, y)
	hero.x = x
	hero.y = y
end

function mouseMoveCharacter(dt)
	local tempx = hero.x
	local tempy = hero.y
	x, y = lm.getPosition()

	diffX = x - hero.x
	diffY = y - hero.y

	if diffX > 0 then
		tempx = hero.x + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
		end
	elseif diffX < 0 then 
		tempx = hero.x - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
		end
	end

	if diffY > 0 then 
		tempy = hero.y + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
		end
	elseif diffY < 0 then 
		tempy = hero.y - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
		end
	end 
end

function addToInventory(item)
	hero.inventory[1] = item
end

function drawInventory()
	print(hero.inventory[1])
end

function moveCharacter(dt)
	local tempx = hero.x
	local tempy = hero.y

	if lm.isDown("l") then
		mouseMoveCharacter(dt)
		return
	end

	if lk.isDown("left") then
		tempx = hero.x - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
		end
	elseif lk.isDown("right") then
		tempx = hero.x + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
		end
	end
	
	if lk.isDown("up") then
		tempy = hero.y - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
		end	
	elseif lk.isDown("down") then
		tempy = hero.y + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
		end	
	end
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
