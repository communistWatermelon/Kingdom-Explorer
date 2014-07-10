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

lk = love.keyboard
lw = love.window
lg = love.graphics
lm = love.mouse
lf = love.filesystem

function love.load()
	love.resize(love.window.getWidth(), love.window.getHeight())
	maps = {'coredump', 'chez-peter', 'map1'}
	loadMap('/maps/' .. maps[1] .. '.lua')
	loadCharacter()
end

function love.update(dt)
	if lk.isDown("i") then
		drawInventory()
	end

	if lk.isDown("g") then
		addToInventory("sword")
	end

	if lk.isDown("e") then
		equipItem("sword")
	end

	moveCharacter(dt)
end

function love.resize(w, h)
	width, height = w, h
	scaleW = width / 800
	scaleH = height / 576
end

function love.draw()
	lg.push()
	lg.scale(scaleW, scaleH)
	drawMap(currentMap)
	drawCharacter()
	lg.pop()
end
