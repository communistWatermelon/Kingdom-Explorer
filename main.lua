--[[ 
the main process of the game
handles controls, health, damage
	loads loads
 	map player
 	loads savegame
--]]
require('map')
require('character')

function love.load()
	love.resize(love.window.getWidth(), love.window.getHeight())
	maps = {'coredump', 'chez-peter', 'map1'}
	loadMap('/maps/' .. maps[1] .. '.lua')
	loadCharacter()
end

function love.update(dt)
	moveCharacter(dt2)
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