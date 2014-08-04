local dragging = { active = false, diffX = 0, diffY = 0 }

function love.touchpressed(id, x, y, pressure)
	local tempx, tempy = x * lg.getWidth(),  y * lg.getHeight()

	if (x <= .5) then
		controllerPressed(tempx, tempy)	
	else
		startSwipe(tempx, tempy) 
	end
end

function love.touchreleased(id, x, y, pressure)
	local tempx, tempy = x * lg.getWidth(), y * lg.getHeight()

	if (x <= .5) then
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