-- getters and setters
function getLocation(param)
	return param.location
end

function getAttack(param)
	return param.stats.atk
end

function getCash()
	return hero.cash
end

function changeCash(change)
	local current = getCash()
	current = current + change
	if current < 0 then
		current = 0
	elseif current >= 999 then
		current = 999
	end

	hero.cash = current
end

function getSize(param)
	return param.size
end

function getSpeed(param)
	return param.stats.speed
end

function changeSpeed(param, change)
	param.stats.speed = getSpeed(param) + change
end

function getClass(param)
	return param.class
end

function getAnimHeight(param, anim)
	return getAnim(param, anim):getHeight()
end

function getAnimWidth(param, anim)
	return getAnim(param, anim):getWidth()
end

function changeHealth(param, change, direction)
	param.stats.health = param.stats.health + change

	if change < 0 then
		setX(param, getX(param) - 30)
	end

	if getClass(param) == "hero" then
		shiftMap(-15, 0)
	end
end

function getInventory(param)
	--body
	return param.inventory
end

function addToInventory(param, item)
	loadItem(item)
	param.inventory[(#param.inventory)+1] = item
end

function getFacing(param)
	return param.location.facing
end

function getEquipped(param)
	return param.equipped
end

function getInventory(param)
	return param.inventory
end

function setFacing(param, face)
	param.location.facing = face
end

function setLocation(param, x, y)
	setX(param, x)
	setY(param, y)
end

function getAnim(param, type)
	if type == "sprite" then
		return param.draw.sprite
	elseif type == "projectile" then
		return param.draw.projectile
	elseif type == "attack" then
		return param.draw.attack
	elseif type == "idle" then
		return param.draw.idle
	elseif type == "walk" then
		return param.draw.walk
	end
end

function getWidth(param)
	-- body
	return param.size.width
end

function getHeight(param)
	-- body
	return param.size.height
end

function equipItem(param, item)
	local inv = getInventory(param)
	if inv[1] ~= nil and getEquipped(param) ~= item then
		param.equipped = item
	end
end

function addFacing(param, tempFace) 
	setFacing(param, getFacing(param) + tempFace)
end

function setX(param, x)
	param.location.x = x
end

function setY(param, y)
	param.location.y = y
end

function getX(param)
	return param.location.x
end	

function getY(param)
	return param.location.y
end

function getHealth(param)
	return param.stats.health
end

function math.dist(x1,y1, x2,y2) 
	return ((x2-x1)^2+(y2-y1)^2)^0.5 
end