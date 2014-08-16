local dragging = { active = false, diffX = 0, diffY = 0 }

function love.touchpressed(id, x, y, pressure)
	local tempx, tempy = x * lg.getWidth(),  y * lg.getHeight()

	if (x <= .3) then
		controllerPressed(tempx, tempy)	
	else
		startSwipe(tempx, tempy) 
	end
end

function love.touchreleased(id, x, y, pressure)
	local tempx, tempy = x * lg.getWidth(), y * lg.getHeight()

	if (x <= .3) then
		controllerReleased()
	else
		endSwipe(tempx, tempy)
	end
end

function startSwipe(x, y)
	dragging.active = True
	dragging.diffX = x
	dragging.diffY = y
end

function endSwipe(x, y)
	dragging.active = false
	dragging.diffX = x - dragging.diffX
	dragging.diffY = y - dragging.diffY
	local swipe = swipeDirection()

	if swipe == "down" then
		-- show inventory screen
		drawInventory()
	elseif swipe == "up" then
		 -- show map screen
	elseif swipe == "left" then
		--switch to item to the left
		equipItem(hero, "Lv1Sword")
	elseif swipe == "right" then
		--switch to item to the right
		equipItem(hero, "Bow")
	else
		tempEquipped = getEquipped(hero)
		if tempEquipped ~= nil then
			local tempLoc = getLocation(hero)
			useItem(tempEquipped, tempLoc.x, tempLoc.y)
		end
	end
end

function swipeDirection()
	local swipeHeight = lg.getHeight()
	local swipeWidth = lg.getWidth()
	local lowSwipe = 2
	local highSwipe = 4
	local direction

	if (math.abs(dragging.diffY) > math.abs(dragging.diffX)) then
		if dragging.diffY > (swipeHeight / highSwipe) then
			direction = "down"
		elseif dragging.diffY < -(swipeHeight / highSwipe) then
			direction = "up"
		end
	elseif (math.abs(dragging.diffX) > math.abs(dragging.diffY)) then
		if dragging.diffX < -(swipeWidth / highSwipe) then
			direction = "left"
		elseif dragging.diffX > (swipeWidth / highSwipe) then
			direction = "right"
		end
	end
	
	return direction
end

function mouseMove(dt, x, y)
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