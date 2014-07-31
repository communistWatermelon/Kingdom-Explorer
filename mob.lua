require("character")

local mob

function loadMob()
	mob = { x = 200, y = 300, atk = 5, speed = 50, health = 100, startx = 200, starty = 300, moving = "left", maxMove = 50, width = 30, height = 30, dead = false}
end

function getMobLocation()
	return mob.x, mob.y
end

function getMobAttack()
	return mob.atk
end

function getMobSize()
	return mob.width, mob.height
end

function getMobSpeed()
	--body
	return mob.speed
end

function changeMobSpeed(change)
	-- adds 'change' to the mob's speed
	-- if change is negative, mob loses speed
	mob.speed = mob.speed + change
end

function changeMobHealth(change)
	-- adds 'change' to the mob's health
	-- if change is negative, mob loses health
	mob.health = mob.health + change

	if change < 0 then
		mob.x = mob.x - 30
	end

	if mob.health <= 0 then
		mob.dead = true
	end
end

function getMobHealth()
	return mob.health
end

function checkCollisions(mobs)
	herox, heroy = getLocation()
	herow, heroh = getSize()
	mobx, moby = getMobLocation()
	mobw, mobh = getMobSize()

	return mobx < herox + herow and
		herox < mobx + mobw and
		moby < heroy + heroh and
		heroy < moby + mobh and not mob.dead
end

function moveMob(dt)
	if mob.moving == "left" then
		if ((mob.x - mob.startx) < mob.maxMove) then
			mob.x = mob.x + (dt * mob.speed)
		else
			mob.moving = "right"
		end
	elseif mob.moving == "right" then
		if ((mob.x - mob.startx) > -mob.maxMove) then
			mob.x = mob.x - (dt * mob.speed)
		else
			mob.moving = "left"
		end
	end
end

function drawMobs(mobs)
	-- draw character
	--lg.draw(mob.sprite, mob.x, mob.y, facing, 1, 1, mob.sprite:getWidth()/2, mob.sprite:getHeight()/2)
	-- draw equipped item
	if mob.health > 0 then
		lg.rectangle("fill", mob.x, mob.y, mob.width, mob.height)
	end
end
