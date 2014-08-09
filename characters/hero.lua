local path = "characters/hero/"

function loadCharacter()
	local img = love.graphics.newImage(path .. "herowalk.png")
   	local wAnim = newAnimation(img, 64, 128, 0.1, 3)
   	wAnim:setMode("loop")
   	wAnim:stop()

	hero = { class = "hero", 
			location = {x = 144, y = 144, facing = 0},
			stats = { health = 100, speed = 100 }, 
			inventory = { }, 
			equipped = nil,
			draw = { sprite = lg.newImage(path .. "hero.png"), walk = wAnim },
			size = { width = 32, height = 32 },
			status = { alive = true }
		}
	
	addToInventory(hero, "Lv1Sword")
	addToInventory(hero, "Bow")
end

function mouseMoveCharacter(dt, x, y)
	local tempLoc = getLocation(hero)
	local tempx, tempy = tempLoc.x, tempLoc.y
	local moveX  = ""
	local moveY = ""
	local tempFace = 0

	if (math.abs(x) > 5) then
		if math.abs(x) < 30 then
			modx = 0.3
		else
			modx = 1
		end

		if x > 0 then
			tempx = getX(hero) + (getSpeed(hero) * dt * modx)
			if checkTile(tempx, tempy, false) then
				setX(hero, tempx)
				moveX = "left"
				setFacing(hero, math.pi/2)
				tempFace = math.pi/4
			end
		end
		if x < 0 then 
			tempx = getX(hero) - (getSpeed(hero) * dt * modx)
			if checkTile(tempx, tempy, false) then
				setX(hero, tempx)
				moveX = "right"
				setFacing(hero, -math.pi/2)
				tempFace = -math.pi/4
			end
		end
	end

	if(math.abs(y) > 5) then
		if math.abs(y) < 30 then
			mody = 0.3
		else
			mody = 1
		end
		if y > 0 then 
			tempy = getY(hero) + (getSpeed(hero) * dt * mody)
			if checkTile(tempx, tempy, false) then
				setY(hero, tempy) 
				moveY = "up"
				setFacing(hero, math.pi)
				tempFace = -tempFace
			end
		end
		if y < 0 then 
			tempy = getY(hero) - (getSpeed(hero) * dt * mody)
			if checkTile(tempx, tempy, false) then
				setY(hero, tempy) 
				moveY = "down"
				setFacing(hero, 0)
			end
		end

	end

	if moveX ~= "" and moveY ~= "" then
		addFacing(hero, tempFace)
	end

	if moveX ~= "" or moveY ~= "" then
		getAnim(hero, "walk"):play()
	else
		getAnim(hero, "walk"):seek(3)
		getAnim(hero, "walk"):stop()
	end

	mouseMoveMap(dt, x, y, moveX, moveY)
end

function drawInventory()
	local inv = getInventory(hero)
	for i=1, #inv do
		print(inv[i])
	end
end

function moveCharacter(dt, x, y)
	local tempLoc = getLocation(hero)
	local tempx, tempy = tempLoc.x, tempLoc.y
	local moveX = ""
	local moveY = ""
	local tempFace = 0

	updateWalk(dt)

	if lm.isDown("l") then
		mouseMoveCharacter(dt, x, y)
		return
	end

	if lk.isDown("left") then
		tempx = getX(hero) - (getSpeed(hero) * dt)
		if checkTile(tempx, tempy, false) then
			setX(hero, tempx)
			moveX = "left"
			setFacing(hero, -math.pi/2)
			tempFace = -math.pi/4
		end
	elseif lk.isDown("right") then
		tempx = getX(hero) + (getSpeed(hero) * dt)
		if checkTile(tempx, tempy, false) then
			setX(hero, tempx)
			moveX = "right"
			setFacing(hero, math.pi/2)
			tempFace = math.pi/4
		end
	end
	
	if lk.isDown("up") then
		tempy = getY(hero) - (getSpeed(hero) * dt)
		if checkTile(tempx, tempy, false) then
			setY(hero, tempy)
			moveY = "up"
			setFacing(hero, 0)
		end	
	elseif lk.isDown("down") then
		tempy = getY(hero) + (getSpeed(hero) * dt)
		if checkTile(tempx, tempy, false) then
			setY(hero, tempy)
			moveY = "down"
			setFacing(hero, math.pi)
			tempFace = -tempFace
		end	
	end

	if moveX ~= "" and moveY ~= "" then
		addFacing(hero, tempFace)
	end

	if moveX ~= "" or moveY ~= "" then
		getAnim(hero, "walk"):play()
	else
		getAnim(hero, "walk"):seek(3)
		getAnim(hero, "walk"):stop()
	end

	moveMap(dt, moveX, moveY)
end

function drawWalk(x, y)
	getAnim(hero, "walk"):draw(x, y, getFacing(hero), 1, 1, getAnimWidth(hero, "walk")/2, getAnimHeight(hero, "walk")/4)
end

function updateWalk(dt)
	getAnim(hero, "walk"):update(dt)
end

function drawCharacter(characters)
	lg.draw(getAnim(hero, "sprite"), getX(hero), getY(hero), getFacing(hero), 1, 1, getWidth(hero)/2, getHeight(hero)/2)
	drawWalk(getX(hero), getY(hero))
end

function drawEquipped()
	local tempEquip = getEquipped(hero)
	if tempEquip ~= nil then
		drawItem(tempEquip, lg.getWidth() - 45, 25)
	end
end
