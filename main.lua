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
require("AnAL")

lk = love.keyboard
lw = love.window
lg = love.graphics
lm = love.mouse
lf = love.filesystem

function love.load()
	diffX = 0
	diffY = 0
	maps = {'coredump', 'chez-peter', 'map1', 'map2'}
	loadMap('/maps/' .. maps[4] .. '.lua')
	loadCharacter()
	loadOverlay()
	local img  = love.graphics.newImage("assets/explode.png")
   	anim = newAnimation(img, 96, 96, 0.1, 0)
   	anim:setMode("once")
   	anim:stop()
end

function love.update(dt)
	if lk.isDown("i") then
		drawInventory()
	end

	if lk.isDown("e") then
		equipItem("sword")
	end

	diffX, diffY = updateOverlay(dt)
	moveCharacter(dt, diffX, diffY)
	anim:update(dt)   
end

function love.mousepressed(x, y, button)
	if button == "l" then
		controllerPressed(x, y)	
		anim:play()
	end

	if button == "r" then
		print(lm.getPosition())
		print(getLocation())
	end
end

function love.mousereleased(x, y, button)
	if button == "l" then 
		controllerReleased() 
		anim:stop()
	end
end

function love.resize(w, h)
	scaleW = w / 800
	scaleH = h / 576

	resizeOverlay(w, h)
end

function love.draw()
	lg.push()
	lg.translate(16, 16)
	drawMap(currentMap)
	drawOverlay()
	lg.pop()
	anim:draw(100, 100)
end
