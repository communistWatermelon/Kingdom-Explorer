require('map')
require('character')
require('mob')
require('item')
require('hud')
require("AnAL")
require("functions")

lk = love.keyboard
lw = love.window
lg = love.graphics
lm = love.mouse
lf = love.filesystem
mapX = 0
mapY = 0
local diffX = 0
local diffY = 0
local dragging

function love.load()
	dragging = { active = false, diffX = 0, diffY = 0 }
	
	maps = {'coredump', 'chez-peter', 'map1', 'map2'}
	loadMap('/maps/' .. maps[4] .. '.lua')
	
	loadCharacter()
	loadOverlay(hero)
	loadMob()
end

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

function love.update(dt)
	diffX, diffY = updateOverlay(dt)
	moveCharacter(dt, diffX, diffY)
	updateEquippedItem(dt)
	moveMob(dt)

	if (checkCollisions()) then
		changeHealth(hero, (-getAttack(mob)))
	end

	updateOverlay()
end

function love.mousepressed(x, y, button, isTouch)
	if not isTouch then
		if button == "l" then
			if (x < lg.getWidth()/2) then
				controllerPressed(x, y)	
			else
				startSwipe(x, y) 
			end
		end

		if button == "r" then
			print(lm.getPosition())
		end
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

function love.mousereleased(x, y, button, isTouch)
	if not isTouch then
		if button == "l" then 
			controllerReleased() 
			endSwipe(x, y)
		end
	end
end

function love.resize(w, h)
	scaleW = w / 800
	scaleH = h / 576

	resizeOverlay(w, h)
end

function love.draw()
	local tempLoc = getLocation(hero)
	
	lg.push()
		lg.translate(mapX, mapY)		
		drawMap(currentMap)
		drawMobs()
		drawCharacter()
		if (getEquipped(hero) ~= nil) then
			animateEquipped(tempLoc.x, tempLoc.y)
		else 
			drawCharacter()
		end
	lg.pop()
	
	drawOverlay()
	drawEquipped()
end
