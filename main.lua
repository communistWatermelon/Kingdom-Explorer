require('core/map')
require('core/item')
require("core/projectiles")
require('characters/hero')
require('characters/mob')
require('characters/characters')
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
	
	projectiles = {}
	mobTable = {}
	mobProjectiles = {}
end

function love.load()
	setVariables()
	loadMap('/maps/' .. maps[4] .. '.lua')
	loadHero()
	loadOverlay(hero)
end

function love.update(dt)
	diffX, diffY = updateOverlay(dt)
	updateCharacters(dt, diffX, diffY)
	updateEquippedItem(dt)
	updateProjectiles(dt)
	checkCharacters()
end

function love.mousepressed(x, y, button, isTouch)
	if not isTouch then
		if button == "l" then
			if (x < lg.getWidth()/3) then
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

			if (x < lg.getWidth()/3) then
				controllerReleased() 
			else
				endSwipe(x, y)
			end
			
		end
	end
end

function love.resize(w, h)
	scaleW = w / 800
	scaleH = h / 576

	resizeOverlay(w, h)
end

function love.draw()
	lg.push()
		lg.translate(mapX, mapY)		
		drawMap(currentMap)
		drawCharacters()
		drawProjectiles()
	lg.pop()
	
	drawOverlay()
	drawEquipped()
end
