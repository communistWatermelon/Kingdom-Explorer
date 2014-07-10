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

function love.load()
	love.resize(love.window.getWidth(), love.window.getHeight())
	maps = {'coredump', 'chez-peter', 'map1'}
	loadMap('/maps/' .. maps[1] .. '.lua')
	loadCharacter()
	loadSword()
end

function love.update(dt)
	if love.keyboard.isDown("i") then
		drawInventory()
	end

	if love.keyboard.isDown("g") then
		addToInventory("sword")
	end

	if love.keyboard.isDown("e") then
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
	love.graphics.push()
	love.graphics.scale(scaleW, scaleH)
	drawMap(currentMap)
	drawCharacter()
	love.graphics.pop()
end
