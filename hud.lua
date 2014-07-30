require('math')
require('utils')
require('character')

local heroHealth
local ctrlr
local cWidth
local cHeight
local xDivider
local yDivider
local maxMovement
local buffer
local cScale

function loadHud()
	heroHealth = getHealth()
end

function loadController()
	cWidth = lg.getWidth()
	cHeight = lg.getHeight()
	xDivider = 8
	yDivider = 4
	cScale = 50
	maxMovement = cScale*1.5

	--ctrlr.w
	ctrlr = {
		x = cWidth / xDivider, 
		y = cHeight - (cHeight / yDivider),
		--image = tileset,
		w = cScale,
		h = cScale,
		dragging = { active = false, diffX = 0, diffY = 0 }
	}

	bottom = {
		x = cWidth / xDivider,
		y = cHeight - (cHeight / yDivider),
		w = cScale/1.5,
		h = cScale/1.5
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
	tempH = getHealth()
	if tempH >= 0 then
		heroHealth = getHealth()
	end
end

function updateController(dt)
	if ctrlr.dragging.active then
		local tempX = lm.getX()
		local tempY = lm.getY()
		if (math.dist((cWidth / xDivider), (cHeight - (cHeight / yDivider)), tempX, tempY) < maxMovement) then
			ctrlr.x = tempX
			ctrlr.y = tempY
		end
	end
	return (ctrlr.x - (cWidth / xDivider)), (ctrlr.y - (cHeight - (cHeight / yDivider)))
end

function controllerPressed(x, y)
	if x > ctrlr.x-(cScale/2) and x < ctrlr.x + ctrlr.w
	and y > ctrlr.y-(cScale/2) and y < ctrlr.y + ctrlr.h
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

function resizeOverlay(x, y)
	ctrlr.x = (x / xDivider)
	ctrlr.y = y - (y / yDivider)
	bottom.x = ctrlr.x
	bottom.y = ctrlr.y
	cWidth = lg.getWidth()
	cHeight = lg.getHeight()
end

function drawHud()
	-- draws the health bar, money, and whatever else
	lg.rectangle("line", 20, 20, 400, 16)
	lg.rectangle("fill", 25, 25, heroHealth*4, 16)
	lg.rectangle("line", lg.getWidth() - 52, 25, 32, 32)
end

function drawController()
	-- draws the controller for the touch screen devices. should be a small joystick on the left
	lg.push()
		lg.setColor(0,0,0,100)
		lg.circle("fill", bottom.x, bottom.y, bottom.w*2, 100)
		lg.setColor(255,255,255,100)
		lg.circle("fill", ctrlr.x, ctrlr.y, ctrlr.w/2, 100)
	lg.pop()
	lg.setColor(255,255,255,255)
end