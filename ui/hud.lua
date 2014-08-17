require('math')

ctrlr = {}

local heroHealth
local cWidth
local cHeight
local xDivider
local yDivider
local maxMovement
local buffer
local cScale

function loadHud()
	heroHealth = getHealth(hero)
end

function loadController()
	cWidth = lg.getWidth()
	cHeight = lg.getHeight()
	xDivider = 8
	yDivider = 4
	cScale = 50
	maxMovement = cScale*1.5

	ctrlr = {
		location = { x = cWidth / xDivider, y = cHeight - (cHeight / yDivider) },
		size = { width= cScale, height = cScale },
		dragging = { active = false, diffX = 0, diffY = 0, oriX = 0, oriY = 0 }
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
	tempH = getHealth(hero)
	if tempH >= 0 then
		heroHealth = getHealth(hero)
	elseif tempH < 0 then
		heroHealth = 0
	end
end

function drawInventory()
	local inv = getInventory(hero)
	for i=1, #inv do
		print(inv[i])
	end
end

function updateController(dt)
	if ctrlr.dragging.active then
		local tempX = lm.getX()
		local tempY = lm.getY()

		if math.abs(tempX - ctrlr.dragging.oriX ) <= maxMovement then
			ctrlr.dragging.diffX = tempX
			setX(ctrlr, tempX)
		end

		if math.abs(tempY - ctrlr.dragging.oriY ) <= maxMovement then
			ctrlr.dragging.diffY = tempY
			setY(ctrlr, tempY)
		end
	end

	return ctrlr.dragging.diffX - ctrlr.dragging.oriX, ctrlr.dragging.diffY - ctrlr.dragging.oriY
end

function controllerPressed(x, y)
	ctrlr.location = { x = x, y = y }
	ctrlr.dragging = { active = true, diffX = 0, diffY = 0, oriX = x, oriY = y}
end

function controllerReleased()
	ctrlr.location = { x = cWidth / xDivider, y = cHeight - (cHeight / yDivider) }
	ctrlr.dragging = { active = false, diffX = 0, diffY = 0, oriX = 0, oriY = 0}
end

function resizeOverlay(x, y)
	ctrlr.location = { x = x / xDivider, y = y - (y / yDivider)}
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
		lg.setColor(255,255,255,100)
		lg.circle("fill", getX(ctrlr), getY(ctrlr), (getWidth(ctrlr)/2), 100)
	lg.pop()
	lg.setColor(255,255,255,255)
end