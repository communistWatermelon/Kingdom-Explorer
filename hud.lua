require('math')
require('utils')
require('character')

local ctrlr
local cWidth
local cHeight
local xDivider
local yDivider
local maxMovement

function loadHud()
	heroHealth = getHealth()
end

function loadController()
	cWidth = lg.getWidth()
	cHeight = lg.getHeight()
	xDivider = 8
	yDivider = 4
	maxMovement = 100

	tileset = lg.newImage("/assets/circle.png")
	ctrlr = {
		x = cWidth / xDivider, 
		y = cHeight - (cHeight / yDivider),
		image = tileset,
		w = tileset:getWidth(),
		h = tileset:getHeight(),
		dragging = { active = false, diffX = 0, diffY = 0 }
	}	
end

function loadOverlay()
	loadHud()
	loadController()
end

function drawOverlay()
	drawHud()
	drawController()
end

function updateOverlay(dt)
	updateHud(dt)
	return updateController(dt)
end

function updateHud(dt)
end

function updateController(dt)
	if ctrlr.dragging.active then
		local tempX = lm.getX()
		local tempY = lm.getY()
		if (math.dist(cWidth / xDivider, (cHeight - (cHeight / yDivider)), tempX, tempY) < maxMovement) then
			ctrlr.x = lm.getX() - ctrlr.dragging.diffX
			ctrlr.y = lm.getY() - ctrlr.dragging.diffY
		end
	end
	return (ctrlr.x - (cWidth / xDivider)), (ctrlr.y - (cHeight - (cHeight / yDivider)))
end

function controllerPressed(x, y)
	if x > ctrlr.x and x < ctrlr.x + ctrlr.w
	and y > ctrlr.y and y < ctrlr.y + ctrlr.h
	then
		ctrlr.dragging.active = true
		ctrlr.dragging.diffX = x - ctrlr.x
		ctrlr.dragging.diffY = y - ctrlr.y
	end
end

function controllerReleased()
	ctrlr.dragging.active = false
	ctrlr.x = cWidth / xDivider
	ctrlr.y = cHeight - (cHeight / yDivider)
end

function love.mousepressed(x, y, button)
	
end

function love.mousereleased(x, y, button)
	
end

function resizeOverlay(x, y)
	ctrlr.x = x + (x / xDivider)
	ctrlr.y = lg.getHeight() - (y / yDivider)
	cWidth = lg.getWidth()
	cHeight = lg.getHeight()
end

function drawHud()
	-- draws the health bar, money, and what ever else
	lg.rectangle("line", 20, 20, 400, 16)
	lg.rectangle("fill", 25, 25, heroHealth*4, 16)
end

function drawController()
	-- draws the controller for the touch screen devices. should be a small joystick on the left
	lg.draw(ctrlr.image, ctrlr.x, ctrlr.y)
end