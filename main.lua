--[[ 
the main process of the game
handles controls, health, damage
	loads loads
 	map player
 	loads savegame
--]]
require('map')
require('character')
require('item')
require('hud')

lk = love.keyboard
lw = love.window
lg = love.graphics
lm = love.mouse
lf = love.filesystem

function love.load()
	diffX = 0
	diffY = 0
	maps = {'coredump', 'chez-peter', 'map1', 'map2'}
	loadMap('/maps/' .. maps[1] .. '.lua')
	loadCharacter()
	loadOverlay()
end

function love.update(dt)
	if lk.isDown("i") then
		drawInventory()
	end

	if lk.isDown("e") then
		equipItem("sword")
	end

	oldLocationX, oldLocationY = getLocation()
	moveCharacter(dt, diffX, diffY)
	diffX, diffY = updateOverlay(dt)
	currentLocationX, currentLocationY = getLocation()
	changeX = currentLocationX - oldLocationX
	changeY = currentLocationY - oldLocationY
	
	if (math.abs(changeX) > 0 or math.abs(changeY) > 0) then
		moveMap(dt)
	end
	--print(newX/32)
end

function love.mousepressed(x, y, button)
	if button == "l" then
		controllerPressed(x, y)	
	end

	if button == "r" then
		print(lm.getPosition())
		print(getLocation())
	end
end

function love.mousereleased(x, y, button)
	if button == "l" then 
		controllerReleased() 
	end
end

function love.resize(w, h)
	scaleW = w / 800
	scaleH = h / 576

	resizeOverlay(w, h)
end

function love.draw()	
	drawMap(currentMap)
	drawOverlay()
end
