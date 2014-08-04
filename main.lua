require('core/map')
require('core/item')
require('characters/hero')
require('characters/mob')
require('ui/hud')
require("libraries/AnAL")
require("libraries/functions")
require("libraries/androidFunctions")

local diffX, diffY = 0, 0

function setVariables()
	lk = love.keyboard
	lw = love.window
	lg = love.graphics
	lm = love.mouse
	lf = love.filesystem
	mapX, mapY = 0, 0
	maps = {'coredump', 'chez-peter', 'map1', 'map2'}
end

function love.load()
	setVariables()
	loadMap('/maps/' .. maps[4] .. '.lua')
	loadCharacter()
	loadOverlay(hero)
	loadMob()
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
