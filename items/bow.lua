local path = "items/bow/"

local arrow = {}

function loadBow()
	local img = love.graphics.newImage(path .. "bowanim.png")
   	local anim = newAnimation(img, 128, 128, 0.04, 9)
   	anim:setMode("once")
   	anim:stop()
	
	bow = { stats = { atk = 70, speed = 300 },
			draw = { sprite = lg.newImage(path .. "bow.png"), projectile = lg.newImage(path .. "arrow.png"), attack = anim },
			size = { width = 32, height = 5}
		}
end

function useBow(x, y)
	fireArrow(x, y)
	getAnim(bow, "attack"):play()
	getAnim(bow, "attack"):reset()
end

function fireArrow(x, y)
	local facing = getFacing(hero)

	local modx = 0
	local mody = 0

	if facing == 0 then
		modx = -10
		mody = 16
	elseif facing < 0 then
		modx = 16
		mody = 10
	elseif facing > 0 and facing < 3 then
		modx = -16
		mody = -10
	elseif facing > 3 then
		modx = 10
		mody = -16
	end

	local dx, dy = getSpeed(bow) * math.cos(facing - (math.pi/2)), getSpeed(bow) * math.sin(facing - (math.pi / 2))
	table.insert( arrow, { x = (x+modx), y = (y+mody), dx = dx, dy = dy, facing = facing - (math.pi / 2)} )
end

function BowCollision(x, y)
	local facing = getFacing(hero)
	local mobSize = getSize(mob)
	local boww, bowh

	for i=1, #mobTable do
		local mobLoc = getLocation(mobTable[i])
		if facing == 0 or facing > 3 then
			boww = getHeight(bow)
			bowh = getWidth(bow)
		elseif facing < 0 or ( facing > 0 and facing < 3)  then
			bowh = getHeight(bow) 
			boww = getWidth(bow)
		end

	 	for a,b in ipairs(arrow) do
			if mobLoc.x < b.x + boww and
				b.x < mobLoc.x + mobSize.width and
				mobLoc.y < b.y + bowh and
				b.y < mobLoc.y + mobSize.height then
					changeHealth(mobTable[i], -getAttack(bow))
					table.remove(arrow, a)
	        end

	        if b.x > (lg.getWidth()+math.abs(mapX)) or b.y > (lg.getHeight()+math.abs(mapY)) or b.x < math.abs(mapX) or b.y < math.abs(mapY) then
	        	table.remove(arrow, a)
	        end

	        if not checkTile(b.x, b.y, true) then
	        	table.remove(arrow, a)
	        end
	    end
	end
end

function animateBow(x, y)
	getAnim(bow, "attack"):draw(x, y, getFacing(hero), 1, 1, getAnimWidth(bow, "attack")/2, getAnimHeight(bow, "attack")/2)
	for i, v in ipairs (arrow) do
		lg.draw( getAnim(bow, "projectile"), v.x, v.y, v.facing)
	end
end

function updateBow(dt)
	local tempLoc = getLocation(hero)

	getAnim(bow,"attack"):update(dt)
	for i, v in ipairs (arrow) do
		v.x = v.x + v.dx * dt
		v.y = v.y + v.dy * dt
	end

	BowCollision(tempLoc.x, tempLoc.y)
end

function drawBow(x, y)
	lg.draw(getAnim(bow, "sprite"), x-8, y)
end
