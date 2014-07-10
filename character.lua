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
	x, y = love.mouse.getPosition()

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
	local temp = item
	hero.inventory[1] = temp
end

function drawInventory()
	print(hero.inventory[1])
end

function moveCharacter(dt)
	local tempx = hero.x
	local tempy = hero.y

	if love.mouse.isDown("l") then
		mouseMoveCharacter(dt)
		return
	end

	if love.keyboard.isDown("left") then
		tempx = hero.x - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
		end
	elseif love.keyboard.isDown("right") then
		tempx = hero.x + (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.x = tempx
		end
	end
	if love.keyboard.isDown("up") then
		tempy = hero.y - (hero.speed * dt)
		if checkTile(tempx, tempy) then
			hero.y = tempy
		end	
	elseif love.keyboard.isDown("down") then
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
	love.graphics.rectangle("fill", hero.x, hero.y, 32, 32)
	-- draw equipped item
	if hero.equipped ~= nil then
		-- later change the x and y to like, a hand
		drawItem(hero.equipped, hero.x, hero.y)
	end
end
